Class {
	#name : #RTGroupTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Core'
}

{ #category : #tests }
RTGroupTest >> testElementFromModel [
	| group |
	group := RTBox elementsOn: (1 to: 5).
	self assert: (group elementFromModel: 1) == group first.
	self assert: (group elementFromModel: 5) == group last.

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
RTGroupTest >> testGroupTranslation [
	| group |
	group := RTBox elementsOn: (1 to: 5).
	self assert: group class == RTGroup.	
	self assert: (group allSatisfy: [ :el | el position = (0 @ 0) ]).
	group translateBy: 20 @ 30.
	self assert: (group allSatisfy: [ :el | el position = (20 @ 30) ]).
]
