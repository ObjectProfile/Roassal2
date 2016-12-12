Class {
	#name : #RTGroupTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Core-Tests'
}

{ #category : #tests }
RTGroupTest >> testAttributeAt [

	| g |
	g := RTGroup new.
	self assert: (g attributeAt: #foo ifAbsent: [10]) equals: 10.
	self deny: (g hasAttribute: #foo)
]

{ #category : #tests }
RTGroupTest >> testAttributeAtPresent [

	| g |
	g := RTGroup new.
	g attributeAt: #foo ifAbsentPut: 20.
	self assert: (g attributeAt: #foo) equals: 20.
	self assert: (g hasAttribute: #foo)
]

{ #category : #tests }
RTGroupTest >> testAttributeAtput [
	"
	self debug: #testAttributeAtput
	"

	| g |
	g := RTGroup new.
	g attributeAt: #foo put: 10.
	self assert: (g attributeAt: #foo ifAbsent: [20]) equals: 10.
	self assert: (g hasAttribute: #foo)
]

{ #category : #tests }
RTGroupTest >> testElementFromModel [
	| group |
	group := RTBox elementsOn: (1 to: 5).
	self assert: (group elementFromModel: 1) == group first.
	self assert: (group elementFromModel: 5) == group last.

]

{ #category : #tests }
RTGroupTest >> testGroup [
	| group |
	group := RTBox elementsOn: (1 to: 5).
	self assert: group class == RTGroup.	
]

{ #category : #tests }
RTGroupTest >> testGroup2 [
	| group |
	group := RTBox new elementsOn: (1 to: 5).
	self assert: group class == RTGroup.	
]

{ #category : #tests }
RTGroupTest >> testGroupTranslation [
	| group |
	group := RTBox elementsOn: (1 to: 5).
	self assert: group class == RTGroup.	
	self assert: (group allSatisfy: [ :el | el position = (0 @ 0) ]).
	group translateBy: 20 @ 30.
	self assert: (group allSatisfy: [ :el | el position = (20 @ 30) ]).
]

{ #category : #tests }
RTGroupTest >> testGroupTranslation02 [
	| v center elements firstPos |
	v := RTView new.

	center := (RTEllipse new size: 8; color: Color blue) element.
	v add: center.
	center translateBy: 80 @ 60.

	elements := (RTEllipse new size: 5; color: Color red) elementsOn: (1 to: 20).
	v addAll: elements.
	RTCircleLayout on: elements.
	
	firstPos := elements first position.
	elements translateBy: 80 @ 60.
	self assert: elements first position = (firstPos + (80 @ 60)).

	
]

{ #category : #tests }
RTGroupTest >> testIncomingEdges [

	| v e1 e2 |
	v := RTView new.
	e1 := RTBox element.
	e2 := RTBox element.
	v add: e1; add: e2.
	v add: (RTLine edgeFrom: e1 to: e2).
	
	self assert: (RTGroup with: e1) outgoingEdges size equals: 1. 
	self assert: (RTGroup with: e1) incomingEdges size equals: 0.
	
	self assert: (RTGroup with: e2) incomingEdges size equals: 1. 
	self assert: (RTGroup with: e2) outgoingEdges size equals: 0.
	
]

{ #category : #tests }
RTGroupTest >> testRemovingGroup [

	| els view |
	els := RTBox new elementsOn: (1 to: 5).
	view := RTView new.
	view addAll: els.
	self assert: view numberOfElements equals: 5.
	
	els remove.
	self assert: view numberOfElements equals: 0.
]

{ #category : #resizing }
RTGroupTest >> testResizing [

	| e1 e2 g |
	e1 := (RTBox new width: 30; height: 20) element.
	e2 := (RTEllipse new width: 30; height: 20) element.
	g := RTGroup new.
	g add: e1; add: e2.
	TRConstraint move: e2 below: e1.
	
	self assert: g encompassingRectangle extent equals: ((30.0 @ 40.0)).
	self assert: g encompassingRectangle equals: ((-15.0 @ -10.0) corner: (15.0 @ 30.0)).
	
	"We resize the group"
	g width: 15.
	self assert: g encompassingRectangle extent equals: ((15 @ 40.0)).
	self assert: g encompassingRectangle equals: ((-15.0 @ -10.0) corner: (0 @ 30.0)).
	
	g width: 30.
	self assert: g encompassingRectangle extent equals: ((30.0 @ 40.0)).
	self assert: g encompassingRectangle equals: ((-15.0 @ -10.0) corner: (15.0 @ 30.0)).
	
]

{ #category : #resizing }
RTGroupTest >> testResizingAndMinimumSize [

	| e1 e2 g |
	e1 := (RTBox new width: 30; height: 20) element.
	e2 := (RTEllipse new width: 30; height: 20) element.
	g := RTGroup new.
	g add: e1; add: e2.
	TRConstraint move: e2 below: e1.
	
	"We resize the group"
	g width: -4.
	self assert: g encompassingRectangle extent equals: ((1 @ 40.0)).

]

{ #category : #tests }
RTGroupTest >> testSignalUpdate [
	"Should not raise an error"
	RTGroup new signalUpdate.
 
]

{ #category : #tests }
RTGroupTest >> testView [
	| group |
	group := RTBox elementsOn: (1 to: 5).
	self assert: group view equals: group first view
]

{ #category : #tests }
RTGroupTest >> testViewWhenAddedToView [
	| group v |
	group := RTBox elementsOn: (1 to: 5).	
	v := RTView new.
	v addAll: group.
	self assert: group view equals: group first view
]

{ #category : #tests }
RTGroupTest >> testgroupsOfConnectedElements [
	| b groups |
	b := RTMondrian new.
	b nodes: (5 to: 20).
	b edges connectFrom: [ :v | v // 2 ].
	b layout tree.
	b normalizer distinctColorForGroup.
	b build.
	
	groups := b view elements groupsOfConnectedElements.
	self assert: groups size equals: 5.
	self assert: (groups allButFirst allSatisfy: [ :g | g size = 3 ]).
	self assert: groups first size equals: 4
]
