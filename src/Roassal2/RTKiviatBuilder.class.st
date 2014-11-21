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
		'shapes',
		'axisSize',
		'highlight',
		'polygons'
	],
	#category : #'Roassal2-Builder-Kiviat'
}

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> activateHighlight [
	highlight := #activated.

]

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> activatePolygons [
	polygons := #activated.

]

{ #category : #adding }
RTKiviatBuilder >> addMetric: blockOrSymbol [
	metrics := metrics copyWith: blockOrSymbol.
]

{ #category : #adding }
RTKiviatBuilder >> addNodesAndEdgesToView [

	kiviatNodes do: [ :kn |
		view addAll: kn edgeElements. 
		view addAll: kn nodeElements.
		]
]

{ #category : #adding }
RTKiviatBuilder >> addObject: anObject [
	objects add: anObject.
]

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> axis: aRTKiviatMetric [
	| config centralPoint |
	kiviatMetrics := kiviatMetrics copyWith: aRTKiviatMetric.	
		
	aRTKiviatMetric maxValue: ((objects collect: [ :p | (metrics at: (kiviatMetrics indexOf:(aRTKiviatMetric)))  rtValue: p ]) max).
	aRTKiviatMetric minValue: ((objects collect: [ :p | (metrics at: (kiviatMetrics indexOf:(aRTKiviatMetric)))  rtValue: p]) min).
		
	config := RTAxisConfiguration new
					builder: self;
					numberOfTicks: 4;
					numberOfLabels: 4;
					minValue: 0;
					maxValue: aRTKiviatMetric maxValue;					
					labelConvertion: [ :number | number asFloat round: 2 ];
					positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position + (0 @ 15) ].
	centralPoint := (0@0).
	
	config axisFrom: 0@0 to: (aRTKiviatMetric modelBlock value: (self getNormalizedValue:(aRTKiviatMetric maxValue)  min:0  max:(aRTKiviatMetric maxSize)  minValue:(aRTKiviatMetric minValue) maxValue: (aRTKiviatMetric maxValue))).
	
]

{ #category : #accessing }
RTKiviatBuilder >> axisSize [
	^ axisSize
]

{ #category : #accessing }
RTKiviatBuilder >> axisSize: aSize [
	axisSize := aSize
]

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> buildAxis [
	| angle |
	angle := 0.
	
	(1 to: metrics size) do: [ :i | 
		self axis: (RTKiviatMetric new block: [ :v | (v*(((i-1) * ((2 * Float pi) / (metrics size)))cos))@(v*(((i-1) * ((2 * Float pi) / (metrics size)))sin))]; maxSize: axisSize) ].
]

{ #category : #view }
RTKiviatBuilder >> configureView: aView [
	aView @ RTDraggableView.
]

{ #category : #hooks }
RTKiviatBuilder >> createShapeBuilder [
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

	((kiviatNodes flatCollect: [ :kn | kn nodeElements]) asGroup) do: [  :e | 
		e @ (RTShowLabel new labelledInteraction: (RTLabelled new text: [ :el | el named])).
		].
	
	((kiviatNodes flatCollect: [ :kn | kn nodeElements]) asGroup)  when: TRMouseEnter do: [  :evt | 
		(kiviatNodes select: [ :kn | kn named = evt element model named ]) do: [ :kn |
			kn nodeElements do: [ :e | self recordElement: e. e trachelShape color: (e trachelShape color alpha: highColor)].
			kn edgeElements do: [ :e | self recordElement: e. e trachelShape color: (e trachelShape color alpha: highColor)].
			view signalUpdate].
		(kiviatNodes select: [ :kn | kn named ~= evt element model named ]) do: [ :kn |
			kn nodeElements do: [ :e | self recordElement: e. e trachelShape color: (e trachelShape color alpha: lowColor)].
			kn edgeElements do: [ :e | self recordElement: e. e trachelShape color: (e trachelShape color alpha: lowColor)].
			view signalUpdate].		
		].
	
	((kiviatNodes flatCollect: [ :kn | kn nodeElements]) asGroup) when: TRMouseLeave do: [  :evt | 
		kiviatNodes do: [ :kn |
			kn nodeElements do: [ :e | e trachelShape color: (e attributes at: #originalColor)].
			kn edgeElements do: [ :e | e trachelShape color: (e attributes at: #originalColor)].
			view signalUpdate]
		].
]

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> executePolygons [

	self executePolygonsColor: 0.2.
]

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> executePolygonsColor: alpha [

	kiviatNodes do: [  :kn | 
		view add: ((RTPolygon new borderColor: ((kn nodeElements first color) alpha: alpha);  color: ((kn nodeElements first color)alpha: alpha); vertices: ((kn nodeElements collect: [ :ne | ne position ]) asArray)) elementOn: kn).
		]

]

{ #category : #'as yet unclassified' }
RTKiviatBuilder >> getNormalizedValue: val min: min max: max minValue: minValue maxValue: maxValue [ 

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
| nodeElems edgeElems shapeNode shapeEdge |

	kiviatNodes add: anRTKiviatNode.
	nodeElems := OrderedCollection new.
	edgeElems := OrderedCollection new.
	
	shapeNode := (shapes isNil) ifFalse: [ RTEllipse new color:(shapes at: (kiviatNodes indexOf: anRTKiviatNode)); size: 10 ] ifTrue: [ anRTKiviatNode shapeNode ] .
	shapeEdge := anRTKiviatNode shapeEdge. 
	
	kiviatMetrics do: [ :m |
		nodeElems add: ((shapeNode) elementOn: ( RTKiviatElement new named:(anRTKiviatNode named); position: (m modelBlock value: (self getNormalizedValue: (anRTKiviatNode arrayValues at: (kiviatMetrics indexOf: m))  min: 0  max: (m maxSize)  minValue: 0  maxValue:(m maxValue))); kiviatNode: anRTKiviatNode; value: (anRTKiviatNode arrayValues at: (kiviatMetrics indexOf: m))) ).
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
	objects := anObjectsCollection
]

{ #category : #actions }
RTKiviatBuilder >> recordElement: anElement [
	anElement attributes at: #originalColor put: (anElement trachelShape color)
]

{ #category : #hooks }
RTKiviatBuilder >> renderIn: aView [
	
	(metrics size = 0) ifFalse: [ self buildAxis ].
	self resetCreatedElements.
	
	objects do: [ :p | self node: (RTKiviatNode new values:(metrics collect: [ :m | m rtValue: p ]); named: p; shapeNode: self shape). ].
	
	( polygons = #activated ) ifTrue: [ self executePolygons ].
	
	self addNodesAndEdgesToView.
	
	( highlight = #activated ) ifTrue: [ self executeHighlight ].
		
	globalBuilder executeOn: self createdElements.


]

{ #category : #accessing }
RTKiviatBuilder >> shapes: aColorArray [
"shapes: takes in argument a collection of colors, at least of the size of the numbers of objects"
	shapes := aColorArray.
]
