Class {
	#name : #RTLayoutTest,
	#superclass : #RTTest,
	#instVars : [
		'view'
	],
	#category : #'Roassal2-Core'
}

{ #category : #running }
RTLayoutTest >> setUp [
	super setUp.
	view := RTView new.
	
	1 to: 20 do: [ :i | view add: (RTBox elementOn: i) ]
]

{ #category : #tests }
RTLayoutTest >> testCircleLayout [

	| answer |
	RTCircleLayout on: view elements.
	answer := ((Array new: 20) at: 1 put: ((440@220)); at: 2 put: ((429@287)); at: 3 put: ((397@349)); at: 4 put: ((349@397)); at: 5 put: ((287@429)); at: 6 put: ((220@440)); at: 7 put: ((152@429)); at: 8 put: ((90@397)); at: 9 put: ((42@349)); at: 10 put: ((10@287)); at: 11 put: ((0@220)); at: 12 put: ((10@152)); at: 13 put: ((42@90)); at: 14 put: ((90@42)); at: 15 put: ((152@10)); at: 16 put: ((219@0)); at: 17 put: ((287@10)); at: 18 put: ((349@42)); at: 19 put: ((397@90)); at: 20 put: ((429@152)); yourself).
	self assert: ((view elements collect: #position) collect: #asIntegerPoint) asArray = answer
	
]

{ #category : #tests }
RTLayoutTest >> testCluster [
	view := RTView new.
	view addAll: ((RTEllipse new size: 10) elementsOn: (Collection withAllSubclasses)).
	RTEdge buildEdgesFromObjects: Collection withAllSubclasses from: #superclass to: #yourself inView: view.
	RTClusterLayout on: view elements edges: view edges.

]

{ #category : #tests }
RTLayoutTest >> testHorizontalLineLayout [

	| answer |
	RTHorizontalLineLayout on: view elements.
	answer := ((Array new: 20) at: 1 put: ((5@5)); at: 2 put: ((20@5)); at: 3 put: ((35@5)); at: 4 put: ((50@5)); at: 5 put: ((65@5)); at: 6 put: ((80@5)); at: 7 put: ((95@5)); at: 8 put: ((110@5)); at: 9 put: ((125@5)); at: 10 put: ((140@5)); at: 11 put: ((155@5)); at: 12 put: ((170@5)); at: 13 put: ((185@5)); at: 14 put: ((200@5)); at: 15 put: ((215@5)); at: 16 put: ((230@5)); at: 17 put: ((245@5)); at: 18 put: ((260@5)); at: 19 put: ((275@5)); at: 20 put: ((290@5)); yourself).
	self assert: (view elements collect: #position) asArray = answer
]

{ #category : #tests }
RTLayoutTest >> testHorizontalLineLayoutWithBox [
	| elHello elWorld elHelloWidth elWorldWidth |
	view := RTView new.
	view addAll: (RTBox new size: 20; elementsOn: {'hola '. 'mundo'}).
	self assert: view elements size = 2.
	elHello := view elementFromModel: 'hola '.
	elWorld := view elementFromModel: 'mundo'.
	elHelloWidth := elHello width.
	elWorldWidth := elWorld width.
	RTHorizontalLineLayout new gapSize: 0; on: view elements.
	"view open."
	
	self assert: elHello width = elHelloWidth.
	self assert: elWorld width = elWorldWidth.
	
	self deny: elHello encompassingRectangle right > elWorld encompassingRectangle left.
	self assert: elHello encompassingRectangle top = elWorld encompassingRectangle top.
	self assert: elHello encompassingRectangle bottom = elWorld encompassingRectangle bottom.
]

{ #category : #tests }
RTLayoutTest >> testHorizontalLineLayoutWithBoxWithoutPadding [
	| models elHello elWorld elHelloWidth elWorldWidth |
	view := RTView new.
	models := { 50. 150 }.
	view addAll: (RTBox new color: (Color blue alpha: 0.2); size: #yourself; elementsOn: models).
	self assert: view elements size = 2.
	elHello := view elementFromModel: models first.
	elWorld := view elementFromModel: models second.
	elHelloWidth := elHello width.
	elWorldWidth := elWorld width.
	RTHorizontalLineLayout new gapSize: 0; padding: 0; on: view elements.
	"view open."
	
	self assert: elHello width = elHelloWidth.
	self assert: elWorld width = elWorldWidth.
	self assert: elHello encompassingRectangle width = elHelloWidth.
	self assert: elWorld encompassingRectangle width = elWorldWidth.
	
	self assert: elHello encompassingRectangle top = elWorld encompassingRectangle top.
	self assert: elHello encompassingRectangle bottom = elWorld encompassingRectangle bottom.
	self assert: elHello encompassingRectangle right <= elWorld encompassingRectangle left.

]

{ #category : #tests }
RTLayoutTest >> testHorizontalLineLayoutWithText [
	| elHello elWorld elHelloWidth elWorldWidth |
	view := RTView new.
	view addAll: (RTLabel elementsOn: {'hola '. 'mundo'}).
	self assert: view elements size = 2.
	elHello := view elementFromModel: 'hola '.
	elWorld := view elementFromModel: 'mundo'.
	elHelloWidth := elHello width.
	elWorldWidth := elWorld width.
	RTHorizontalLineLayout new gapSize: 0; on: view elements.
	"view open."
	
	self assert: elHello width = elHelloWidth.
	self assert: elWorld width = elWorldWidth.
	self assert: elHello encompassingRectangle width = elHelloWidth.
	self assert: elWorld encompassingRectangle width = elWorldWidth.
	
	self assert: elHello encompassingRectangle top = elWorld encompassingRectangle top.
	self assert: elHello encompassingRectangle bottom = elWorld encompassingRectangle bottom.
	self deny: elHello encompassingRectangle right > elWorld encompassingRectangle left.

]

{ #category : #tests }
RTLayoutTest >> testHorizontalLineLayoutWithTextWithoutPadding [
	| elHello elWorld elHelloWidth elWorldWidth |
	view := RTView new.
	view addAll: (RTLabel elementsOn: {'m'. 'm'}).
	self assert: view elements size = 2.
	elHello := view elementFromModel: 'm'.
	elWorld := view elementFromModel: 'm'.
	elHelloWidth := elHello width.
	elWorldWidth := elWorld width.
	RTHorizontalLineLayout new gapSize: 0; padding: 0; on: view elements.
	"view open."
	
	self assert: elHello width = elHelloWidth.
	self assert: elWorld width = elWorldWidth.
	self assert: elHello encompassingRectangle width = elHelloWidth.
	self assert: elWorld encompassingRectangle width = elWorldWidth.
	
	self assert: elHello encompassingRectangle top = elWorld encompassingRectangle top.
	self assert: elHello encompassingRectangle bottom = elWorld encompassingRectangle bottom.
	self assert: elHello encompassingRectangle right <= elWorld encompassingRectangle left.
]

{ #category : #tests }
RTLayoutTest >> testRadialTreelLayout [

	| answer  |
	 
	RTEdge buildEdgesFromObjects: (1 to: 20) from: [ :v | v // 2 ] to: #yourself inView: view.	
	RTRadialTreeLayout on: view elements edges: view edges.

	answer := ((Array new: 20) at: 1 put: ((200@200)); at: 2 put: ((213@214)); at: 3 put: ((185@213)); at: 4 put: ((237@214)); at: 5 put: ((211@238)); at: 6 put: ((182@235)); at: 7 put: ((162@214)); at: 8 put: ((259@205)); at: 9 put: ((247@236)); at: 10 put: ((224@254)); at: 11 put: ((209@259)); at: 12 put: ((180@256)); at: 13 put: ((166@250)); at: 14 put: ((146@227)); at: 15 put: ((141@213)); at: 16 put: ((280@200)); at: 17 put: ((278@214)); at: 18 put: ((267@242)); at: 19 put: ((258@254)); at: 20 put: ((232@273)); yourself).
	self assert: ((view elements collect: #position) collect: #asIntegerPoint) asArray = answer
]

{ #category : #tests }
RTLayoutTest >> testTreeLayoutWithoutSpecificingEdges [

	| v |
	v := RTView new.
	v addAll: (RTBox elementsOn: (1 to: 20)).
	RTEdge buildEdgesFromObjects: (1 to: 20) from: [ :value | value // 2 ] to: #yourself inView: v.
	RTTreeLayout on: v elements.
	
	self assert: (v elements collect: #position) asArray equals: ((Array new: 20) at: 1 put: ((41.0@5)); at: 2 put: ((25.0@30)); at: 3 put: ((65.0@30)); at: 4 put: ((17.0@55)); at: 5 put: ((41.0@55)); at: 6 put: ((57.0@55)); at: 7 put: ((73.0@55)); at: 8 put: ((9.0@80)); at: 9 put: ((25.0@80)); at: 10 put: ((37.0@80)); at: 11 put: ((45.0@80)); at: 12 put: ((53.0@80)); at: 13 put: ((61.0@80)); at: 14 put: ((69.0@80)); at: 15 put: ((77.0@80)); at: 16 put: ((5.0@105)); at: 17 put: ((13.0@105)); at: 18 put: ((21.0@105)); at: 19 put: ((29.0@105)); at: 20 put: ((37.0@105)); yourself)
]

{ #category : #tests }
RTLayoutTest >> testTreelLayout [

	| answer  |
	 
	RTEdge buildEdgesFromObjects: (1 to: 20) from: [ :v | v // 2 ] to: #yourself inView: view.	
	RTTreeLayout on: view elements edges: view edges.

	answer := ((Array new: 20) at: 1 put: ((41.0@5)); at: 2 put: ((25.0@30)); at: 3 put: ((65.0@30)); at: 4 put: ((17.0@55)); at: 5 put: ((41.0@55)); at: 6 put: ((57.0@55)); at: 7 put: ((73.0@55)); at: 8 put: ((9.0@80)); at: 9 put: ((25.0@80)); at: 10 put: ((37.0@80)); at: 11 put: ((45.0@80)); at: 12 put: ((53.0@80)); at: 13 put: ((61.0@80)); at: 14 put: ((69.0@80)); at: 15 put: ((77.0@80)); at: 16 put: ((5.0@105)); at: 17 put: ((13.0@105)); at: 18 put: ((21.0@105)); at: 19 put: ((29.0@105)); at: 20 put: ((37.0@105)); yourself).
	self assert: (view elements collect: #position) asArray = answer
]
