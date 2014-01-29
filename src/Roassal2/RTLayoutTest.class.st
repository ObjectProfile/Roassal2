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
	answer := (((Array new: 20) at: 1 put: (((5/2)@(5/2))); at: 2 put: (((35/2)@(5/2))); at: 3 put: (((65/2)@(5/2))); at: 4 put: (((95/2)@(5/2))); at: 5 put: (((125/2)@(5/2))); at: 6 put: (((155/2)@(5/2))); at: 7 put: (((185/2)@(5/2))); at: 8 put: (((215/2)@(5/2))); at: 9 put: (((245/2)@(5/2))); at: 10 put: (((275/2)@(5/2))); at: 11 put: (((305/2)@(5/2))); at: 12 put: (((335/2)@(5/2))); at: 13 put: (((365/2)@(5/2))); at: 14 put: (((395/2)@(5/2))); at: 15 put: (((425/2)@(5/2))); at: 16 put: (((455/2)@(5/2))); at: 17 put: (((485/2)@(5/2))); at: 18 put: (((515/2)@(5/2))); at: 19 put: (((545/2)@(5/2))); at: 20 put: (((575/2)@(5/2))); yourself)).
	self assert: (view elements collect: #position) asArray = answer
	
]

{ #category : #tests }
RTLayoutTest >> testHorizontalLineLayoutWithBox [
	| models elHello elWorld elHelloWidth elWorldWidth |
	view := RTView new.
	models := { 50. 150 }.
	view addAll: (RTBox new color: (Color blue alpha: 0.2); size: #yourself; elementsOn: models).
	self assert: view elements size = 2.
	elHello := view elementFromModel: models first.
	elWorld := view elementFromModel: models second.
	elHelloWidth := elHello width.
	elWorldWidth := elWorld width.
	RTHorizontalLineLayout new gapSize: 0; on: view elements.
	"view open."
	
	self assert: elHello width = elHelloWidth.
	self assert: elWorld width = elWorldWidth.
	self assert: elHello encompassingRectangle width = elHelloWidth.
	self assert: elWorld encompassingRectangle width = elWorldWidth.
	
	self assert: elHello encompassingRectangle top = elWorld encompassingRectangle top.
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
RTLayoutTest >> testHorizontalTreeLayout [
| v els el30 el50 el80 |
v := RTView new.
els := RTBox new size: #yourself; color: (Color green alpha: 0.3); elementsOn: #(30 50 80).
els @ RTDraggable.
v addAll: els.
RTEdge buildEdgesFromAssociations: { 30 -> 50. 30 -> 80. } inView: v.
RTHorizontalTreeLayout new 
	isLayered: false; leftGap: 0; topGap: 0; verticalGap: 0; horizontalGap: 0; on: els.
el30 := els first.
el50 := els second.
el80 := els third.
self assert: el30 encompassingRectangle right equals: el50 encompassingRectangle left.
self assert: el30 encompassingRectangle right equals: el80 encompassingRectangle left.
self assert: el50 encompassingRectangle bottom equals: el80 encompassingRectangle top.

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

{ #category : #tests }
RTLayoutTest >> testVerticalLineLayoutOnElements [
	| el1 el2 |
	view := RTView new.
	el1 := RTBox new size: #yourself; elementOn: 30.
	el2 := RTBox new size: #yourself; elementOn: 50.
	view add: el1; add: el2.
	self assert: view elements size equals: 2.
	RTVerticalLineLayout new 
		gapSize: 0; 
		on: view elements.
	self assert: el1 height equals: 30.
	self assert: el2 height equals: 50.
	self assert: el1 position equals: 15 @ 15.
	self assert: el2 position equals: 25 @ 55.
	self assert: el1 encompassingRectangle left equals: el2 encompassingRectangle left.
	self assert: el1 encompassingRectangle bottom <= el2 encompassingRectangle top.
]

{ #category : #tests }
RTLayoutTest >> testVerticalLineLayoutOnGroups [
	| line1 line2 el1 el2 |
	view := RTView new.
	line1 := RTBox new size: #yourself; elementsOn: {30}.
	line2 := RTBox new size: #yourself; elementsOn: {50}.
	view addAll: line1; addAll: line2.
	self assert: view elements size equals: 2.
	RTVerticalLineLayout new 
		gapSize: 0; 
		on: (Array with: line1 with: line2).
	el1 := line1 first.
	el2 := line2 first.
	
	self assert: el1 height equals: 30.
	self assert: el2 height equals: 50.
	self assert: el1 position equals: 15 @ 15.
	self assert: el2 position equals: 25 @ 55.
	self assert: el1 encompassingRectangle left equals: el2 encompassingRectangle left.
	self assert: el1 encompassingRectangle bottom <= el2 encompassingRectangle top.
]
