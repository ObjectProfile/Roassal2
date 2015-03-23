"
A RTKiviatBuilder is a builder for Kiviat Chart, comparing objects considering metrics.

Instance Variables
	axisSize:		<Object>
	highlight:		<Object>
	kiviatMetrics:		<Object>
	kiviatNodes:		<Object>
	metrics:		<Object>
	objects:		<Object>
	shapes:		<Object>

axisSize
	- xxxxx

highlight
	- xxxxx

kiviatMetrics
	- xxxxx

kiviatNodes
	- xxxxx

metrics
	- xxxxx

objects
	- xxxxx

shapes
	- xxxxx

"
Class {
	#name : #RTKiviatBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'metrics',
		'kiviatMetrics',
		'kiviatNodes',
		'objects',
		'axisSize',
		'highlight',
		'polygons',
		'shapes',
		'axisTitle',
		'axisTitles'
	],
	#category : #'Roassal2-Builder-Kiviat'
}

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> activateAxisTitle [
"activate the axis titles in the view to identify metrics axis"
	axisTitle := #activated.

]

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> activateHighlight [
"activate the Highlight of a chart node when mouse is over and reduce alpha of ther chart nodes."
	highlight := #activated.

]

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> activatePolygons [
"activate the polygons in the view to identify chart nodes"
	polygons := #activated.

]

{ #category : #adding }
RTKiviatBuilder >> addMetric: blockOrSymbol [
	self addMetric: blockOrSymbol title: (blockOrSymbol asString).
]

{ #category : #adding }
RTKiviatBuilder >> addMetric: blockOrSymbol title: aString [
	metrics add: (aString -> blockOrSymbol).
]

{ #category : #adding }
RTKiviatBuilder >> addNodesAndEdgesToView [
"add to the view the chart nodes created"
	kiviatNodes do: [ :kn |
		view addAll: kn edgeKiviatElements. 
		view addAll: kn nodeKiviatElements.
		]
]

{ #category : #adding }
RTKiviatBuilder >> addObject: anObject [
	objects add: anObject.
]

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> axis: aRTKiviatMetric [
"creation of a metric axis"
	| config centralPoint allValues |
	kiviatMetrics add: aRTKiviatMetric.	
	
	allValues := (objects collect: [ :p | (aRTKiviatMetric block)  rtValue: p ]).	
	aRTKiviatMetric maxValue: ( allValues max).
	aRTKiviatMetric minValue: ( allValues min).
		
	config := RTAxisConfiguration new
					builder: self;
					numberOfTicks: 4;
					numberOfLabels: 4;
					minValue: 0;
					maxValue: aRTKiviatMetric maxValue;					
					labelConvertion: [ :number | number asFloat round: 2 ];
					positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position + (0 @ 15) ].
					(axisTitle = #activated) ifTrue: [ config title: (aRTKiviatMetric named)].
					
					
	centralPoint := (0@0).
	
	config axisFrom: 0@0 to: (aRTKiviatMetric modelBlock value: (self getNormalizedValue:(aRTKiviatMetric maxValue)  min:0  max:(aRTKiviatMetric maxSize)  minValue:(aRTKiviatMetric minValue) maxValue: (aRTKiviatMetric maxValue))).
	
]

{ #category : #accessing }
RTKiviatBuilder >> axisSize [
	^ axisSize
]

{ #category : #accessing }
RTKiviatBuilder >> axisSize: aSizeInPixels [
"define the size in pixel of all the axis"
	axisSize := aSizeInPixels
]

{ #category : #accessing }
RTKiviatBuilder >> axisTitles [
	^ axisTitles.
]

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> buildAxis [
"define the blocks of the metrics, divise 360° by the number of total metrics, and call the axis creation according to metrics"
	| angle |
	angle := 0.
	
	metrics doWithIndex: [ :m :i | 
		self axis: (RTKiviatMetric new modelBlock: [ :v | (v*(((i-1) * ((2 * Float pi) / (metrics size)))cos))@(v*(((i-1) * ((2 * Float pi) / (metrics size)))sin))]; maxSize: axisSize; block: m value; named: m key) ].
]

{ #category : #view }
RTKiviatBuilder >> configureView: aView [
	aView @ RTDraggableView.
]

{ #category : #hooks }
RTKiviatBuilder >> createShapeBuilder [
"redefinition for default shape"
	| sb |
	sb := super createShapeBuilder.
	sb shape: (RTEllipse new color: (Color blue alpha: 0.3); size: 10).
	^ sb
]

{ #category : #initialization }
RTKiviatBuilder >> createView [
	^ super createView @ RTDraggableView
]

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> defaultAxisSize [
	axisSize := 200
]

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> desactivateAxisTitle [
"desactivate the axis titles in the view to identify metrics axis"
	axisTitle := #desactivated.

]

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> desactivateHighlight [
	highlight := #desactivated.

]

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> desactivatePolygons [
	polygons := #desactivated.

]

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> executeHighlight [

	self executeHighlightLowColor: 0.2 highColor: 1.0

]

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> executeHighlightLowColor: lowColor highColor: highColor [
| titles |
"define the alpha values of the highlighted and others chart nodes to the view"
	
	( axisTitle = #activated ) ifTrue: [ 
		"for now this way to recover the axis Titles elements in the view is not really clean, but because of using RTAxisRenderer to create the axis and titles in the same time I did not found a way to get only the title element from it."
		titles := OrderedCollection new.
		self metrics do: [ :m | titles add: (view elements detect: [ :e |  (e shape isKindOf: RTLabel) and: [ (e trachelShape text) = (m key) ] ])].
		 ].

	((kiviatNodes flatCollect: [ :kn | kn nodeKiviatElements]) asGroup) do: [  :e | 
		e @ (RTShowLabel new labelledInteraction: (RTLabelled new text: [ :el | el kiviatNode named])).
		].
	
	((kiviatNodes flatCollect: [ :kn | kn nodeKiviatElements]) asGroup)  when: TRMouseEnter do: [  :evt | 
		(kiviatNodes select: [ :kn | kn named = evt element model kiviatNode named ]) do: [ :kn |
			kn nodeKiviatElements do: [ :e | self recordElement: e. e trachelShape color: (e trachelShape color alpha: highColor)].
			kn edgeKiviatElements do: [ :e | self recordElement: e. e trachelShape color: (e trachelShape color alpha: highColor)].
			].
		(kiviatNodes select: [ :kn | kn named ~= evt element model kiviatNode named ]) do: [ :kn |
			kn nodeKiviatElements do: [ :e | self recordElement: e. e trachelShape color: (e trachelShape color alpha: lowColor)].
			kn edgeKiviatElements do: [ :e | self recordElement: e. e trachelShape color: (e trachelShape color alpha: lowColor)]
			].
		( axisTitle = #activated ) ifTrue: [ titles do: [ :t | t trachelShape color: (t trachelShape color alpha: 0)]].
		view signalUpdate.
		].
	
	((kiviatNodes flatCollect: [ :kn | kn nodeKiviatElements]) asGroup) when: TRMouseLeave do: [  :evt | 
		kiviatNodes do: [ :kn |
			kn nodeKiviatElements do: [ :e | e trachelShape color: (e attributes at: #originalColor)].
			kn edgeKiviatElements do: [ :e | e trachelShape color: (e attributes at: #originalColor)].
			view signalUpdate].
		( axisTitle = #activated ) ifTrue: [ titles do: [ :t | t trachelShape color: (t trachelShape color alpha: 1)]].
		view signalUpdate.
		]. 
]

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> executePolygons [

	self executePolygonsColor: 0.2.
]

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> executePolygonsColor: alpha [
"define the alpha value and create polygons"
	kiviatNodes do: [  :kn | 
		view add: ((RTPolygon new borderColor: ((kn nodeKiviatElements first color) alpha: alpha);  color: ((kn nodeKiviatElements first color)alpha: alpha); vertices: ((kn nodeKiviatElements collect: [ :ne | ne position ]) asArray)) elementOn: kn).
		]

]

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> getNormalizedValue: val min: min max: max minValue: minValue maxValue: maxValue [ 
"obtain a normalized value from the original value given by a metric calculation according to the size of the axis"
	(val = min) ifTrue: [ ^ min].
	(maxValue = minValue) ifTrue: [ ^ max].
	
 	^ (min + ((max - min) * ( (val - minValue) / (maxValue - minValue)))).
]

{ #category : #initialization }
RTKiviatBuilder >> initialize [
	super initialize.

	self configureView: view.	
	self defaultAxisSize.
	
	highlight := #activated.
	polygons := #desactivated.
	axisTitle := #desactivated.
	
	axisTitles := OrderedCollection new.
	
	metrics := OrderedCollection new.
	objects := OrderedCollection new.
	
	kiviatNodes := OrderedCollection new.
	kiviatMetrics := OrderedCollection new.


]

{ #category : #accessing }
RTKiviatBuilder >> kiviatNodes [
	^ kiviatNodes
]

{ #category : #accessing }
RTKiviatBuilder >> metrics [
	^ metrics
]

{ #category : #accessing }
RTKiviatBuilder >> node: anRTKiviatNode [
"a chart node is represented by a set of elements according to the metrics values and connected by edges.
 Finish the creation of a chart node, creating elements in the view and edges."
| nodeElems edgeElems shapeNode shapeEdge |

	kiviatNodes add: anRTKiviatNode.
	nodeElems := OrderedCollection new.
	edgeElems := OrderedCollection new.
	
	shapeNode := (shapes isNil) ifFalse: [ RTEllipse new color:(shapes at: (kiviatNodes indexOf: anRTKiviatNode)); size: 10 ] ifTrue: [ anRTKiviatNode shapeNode ] .
	shapeEdge := anRTKiviatNode shapeEdge. 
	
	kiviatMetrics do: [ :m |
		nodeElems add: ((shapeNode) elementOn: ( RTKiviatElement new metric:(m block); position: (m modelBlock value: (self getNormalizedValue: (anRTKiviatNode arrayValues at: (kiviatMetrics indexOf: m)) min: 0  max: (m maxSize)  minValue: 0  maxValue:(m maxValue))); kiviatNode: anRTKiviatNode; value: (anRTKiviatNode arrayValues at: (kiviatMetrics indexOf: m))) ).
		].
	
	anRTKiviatNode addNodeElements: nodeElems.	
		
	nodeElems allButLast do: [ :e | edgeElems add: ((RTEdge from: e to: (nodeElems after:e)) + (shapeEdge color: (e trachelShape color)))]. 
	edgeElems add: ((RTEdge from: (nodeElems last) to: (nodeElems first)) + (shapeEdge color: (nodeElems first trachelShape color))).
	
	anRTKiviatNode addEdgeElements: edgeElems.	
	
	nodeElems do: [  :e | e translateBy: (e model position) ].
]

{ #category : #accessing }
RTKiviatBuilder >> objects [
	^ objects
]

{ #category : #accessing }
RTKiviatBuilder >> objects: anObjectsCollection [
"Define the number of objects to be evaluated by the metrics"
	objects := anObjectsCollection
]

{ #category : #actions }
RTKiviatBuilder >> recordElement: anElement [
	anElement attributes at: #originalColor put: (anElement trachelShape color)
]

{ #category : #hooks }
RTKiviatBuilder >> renderIn: aView [
	
	(kiviatMetrics size ~= metrics size) ifTrue:[
	(metrics size = 0) ifFalse: [ self buildAxis ]].
	self resetCreatedElements.
	
	"a chart node is represented by a set of elements according to the metrics values and connected by edges."
	objects do: [ :p | self node: (RTKiviatNode new values:(metrics collect: [ :m | m value rtValue: p ]); named: p; shapeNode: self shape). ].
	
	( polygons = #activated ) ifTrue: [ self executePolygons ].
	
	self addNodesAndEdgesToView.
	
	( highlight = #activated ) ifTrue: [ self executeHighlight ].
		
	"globalBuilder executeOn: self createdElements."


]

{ #category : #accessing }
RTKiviatBuilder >> shapes: aColorArray [
"shapes: takes in argument a collection of colors, at least of the size of the numbers of objects"
	shapes := aColorArray.
]
