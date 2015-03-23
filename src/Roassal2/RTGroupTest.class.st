Class {
	#name : #RTGroupTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Core'
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
