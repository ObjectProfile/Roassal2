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
RTLayoutTest >> testCellLayout [
| v els el30 el50 el80 |
v := RTView new.
els := RTBox new size: #yourself; color: (Color green alpha: 0.3); elementsOn: #(30 50 80).
els @ RTDraggable.
v addAll: els.
RTEdge buildEdgesFromAssociations: { 30 -> 50. 30 -> 80. } inView: v.
RTCellLayout new 
	gapSize: 0; on: els.
el30 := els first.
el50 := els second.
el80 := els third.
self assert: el30 encompassingRectangle bottom + 20 equals: el80 encompassingRectangle top.
self assert: el30 encompassingRectangle right + 50 equals: el50 encompassingRectangle left.
self assert: el50 encompassingRectangle bottom equals: el80 encompassingRectangle top.

]

{ #category : #tests }
RTLayoutTest >> testCircleLayout [

	| answer |
	RTCircleLayout on: view elements.
	answer :=  {(442@222). (431@290). (400@351). (351@400). (290@431). (222@442). (154@431). (93@400). (44@351). (13@290). (2@222). (13@154). (44@93). (93@44). (154@13). (222@2). (290@13). (351@44). (400@93). (431@154)}.
	self assert: ((view elements collect: #position) collect: #asIntegerPoint) asArray = answer
	
]

{ #category : #tests }
RTLayoutTest >> testCircleLayoutOnEmpty [

	RTCircleLayout new doExecute: #()
]

{ #category : #tests }
RTLayoutTest >> testCluster [
	view := RTView new.
	view addAll: ((RTEllipse new size: 10) elementsOn: (Collection withAllSubclasses)).
	RTEdge buildEdgesFromObjects: Collection withAllSubclasses from: #superclass to: #yourself inView: view.
	RTClusterLayout on: view elements edges: view edges.

]

{ #category : #tests }
RTLayoutTest >> testForce [
	| v es layout |
	v := RTView new.
	es := RTBox elementsOn: (1 to: 2).
	v addAll: es.
	RTEdge buildEdgesFromObjects: (1 to: 2) from: #yourself toAll:  [:value | {value -1  . value + 1 . value + 2} ] inView: v.
	
	layout := RTForceBasedLayout new. 
	layout on: es edges: #().
	
	self assert: layout userDefinedEdges isEmpty.
]

{ #category : #tests }
RTLayoutTest >> testForceDefault [

	| l |
	l := RTForceBasedLayout new.
	self assert: l edges isEmpty.
	self assert: l nodes isEmpty.
]

{ #category : #tests }
RTLayoutTest >> testForceWithForeinEdges [
	| v es layout edges |
	v := RTView new.
	es := RTBox elementsOn: (1 to: 3).
	v addAll: (es copyFrom: 1 to: 3).
	edges :=
		RTEdge 
			buildEdgesFromObjects: (1 to: 3) 
			from: #yourself 
			toAll: [:value | Array with: value -1 with: value + 1 ] 
			inView: v.
	
	"We give to the layout node 1 and 2, and some edges that refer to 3"
	layout := RTForceBasedLayout new. 
	"No error should be raised"
	layout on: es allButLast edges: edges allButFirst.
	
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

	answer := {(202@202). (216@217). (187@215). (239@217). (213@240). (184@238). (165@216). (262@208). (250@239). (226@257). (212@261). (182@259). (169@252). (149@230). (144@216). (282@202). (281@217). (270@245). (261@257). (234@275)}.
	self assert: ((view elements collect: #position) collect: #asIntegerPoint) asArray = answer
]

{ #category : #tests }
RTLayoutTest >> testTreeLayoutWithoutSpecificingEdges [

	| v |
	v := RTView new.
	v addAll: (RTBox elementsOn: (1 to: 20)).
	RTEdge buildEdgesFromObjects: (1 to: 20) from: [ :value | value // 2 ] to: #yourself inView: v.
	RTTreeLayout on: v elements.
	
	self assert: (v elements collect: #position) asArray equals: {(43.5@(15/2)). (27.5@(65/2)). (67.5@(65/2)). (19.5@(115/2)). (43.5@(115/2)). (59.5@(115/2)). (75.5@(115/2)). (11.5@(165/2)). (27.5@(165/2)). (39.5@(165/2)). (47.5@(165/2)). (55.5@(165/2)). (63.5@(165/2)). (71.5@(165/2)). (79.5@(165/2)). (7.5@(215/2)). (15.5@(215/2)). (23.5@(215/2)). (31.5@(215/2)). (39.5@(215/2))}
]

{ #category : #tests }
RTLayoutTest >> testTreelLayout [

	| answer  |
	 
	RTEdge buildEdgesFromObjects: (1 to: 20) from: [ :v | v // 2 ] to: #yourself inView: view.	
	RTTreeLayout on: view elements edges: view edges.

	answer :=  {(43.5@(15/2)). (27.5@(65/2)). (67.5@(65/2)). (19.5@(115/2)). (43.5@(115/2)). (59.5@(115/2)). (75.5@(115/2)). (11.5@(165/2)). (27.5@(165/2)). (39.5@(165/2)). (47.5@(165/2)). (55.5@(165/2)). (63.5@(165/2)). (71.5@(165/2)). (79.5@(165/2)). (7.5@(215/2)). (15.5@(215/2)). (23.5@(215/2)). (31.5@(215/2)). (39.5@(215/2))}.
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

{ #category : #tests }
RTLayoutTest >> testVerticalTreeLayout [
| v els el30 el50 el80 |
v := RTView new.
els := RTBox new size: #yourself; color: (Color green alpha: 0.3); elementsOn: #(30 50 80).
els @ RTDraggable.
v addAll: els.
RTEdge buildEdgesFromAssociations: { 30 -> 50. 30 -> 80. } inView: v.
RTTreeLayout new 
	isLayered: false; leftGap: 0; topGap: 0; verticalGap: 0; horizontalGap: 0; on: els.
el30 := els first.
el50 := els second.
el80 := els third.
self assert: el30 encompassingRectangle bottom equals: el50 encompassingRectangle top.
self assert: el30 encompassingRectangle bottom equals: el80 encompassingRectangle top.
self assert: el50 encompassingRectangle right equals: el80 encompassingRectangle left.

]
