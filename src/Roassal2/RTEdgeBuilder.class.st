Class {
	#name : #RTEdgeBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'allowRepetition',
		'elements'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #'public repetition' }
RTEdgeBuilder >> allowRepetition [
	allowRepetition := true
]

{ #category : #public }
RTEdgeBuilder >> connectFrom: aBlockOrASymbol [

	| edges fromElement |
	edges := OrderedCollection new.
	self elements copy do: [ :e | 
		fromElement := self elements elementFromModel: (aBlockOrASymbol rtValue: e model).
		fromElement ifNotNil: [ edges add: (self edgeFrom: fromElement to: e) ] ].
	^ edges
]

{ #category : #public }
RTEdgeBuilder >> connectTo: aBlockOrASymbol [

	| edges toElement |
	edges := OrderedCollection new.
	self elements copy do: [ :e | 
		toElement := self elements elementFromModel: (aBlockOrASymbol rtValue: e model).
		toElement ifNotNil: [ edges add: (self edgeFrom: e to: toElement) ] ].
	^ edges
]

{ #category : #public }
RTEdgeBuilder >> connectToAll: aBlockOrASymbol [

	| edges toElements |
	edges := OrderedCollection new.
	self elements copy do: [ :e | 
		toElements := self elements elementsFromModels: (aBlockOrASymbol rtValue: e model).
		toElements ifNotNil: [ 
			toElements do: [ :toE | 
				edges add: (self edgeFrom: e to: toE) ] ] ].
	^ edges
]

{ #category : #accessing }
RTEdgeBuilder >> elements [
	elements ifNil: [ ^ self view elements ].
	^ elements
]

{ #category : #accessing }
RTEdgeBuilder >> elements: someElements [
	elements := someElements
]

{ #category : #public }
RTEdgeBuilder >> fromAssociations: associations [
	"associations have to be between model objects"
	^ self objects: associations from: #key to: #value
]

{ #category : #'public associations' }
RTEdgeBuilder >> fromElementAssociations: associationsBetweenElements [
	associationsBetweenElements do: [ :assoc |
		self edgeFrom: assoc key to: assoc value ]
]

{ #category : #accessing }
RTEdgeBuilder >> globalScope [
	^ RTGroup withAll: (self view elements collect: #model)
]

{ #category : #initialization }
RTEdgeBuilder >> initialize [
	super initialize.
	allowRepetition := false
]

{ #category : #public }
RTEdgeBuilder >> object: object fromAll: fromBlock to: toBlock [
	"aGroup is a group of objects"

	| edges fromElement toElement |
	edges := RTGroup new.
		toElement := self view elementFromModel: (toBlock rtValue: object).
		(fromBlock rtValue: object) do: [ :fromObject |
			fromElement := self view elementFromModel: fromObject.
			(fromElement notNil and: [ toElement notNil ])
				ifTrue: [  
					(self shouldCreateEdgeFrom: fromElement to: toElement) ifTrue: 
						[ | edge |
						edge := self edgeFrom: fromElement to: toElement. 
						edges add: edge ] ] ].
	^ edges

]

{ #category : #public }
RTEdgeBuilder >> objects: objects from: fromBlock [
	^ self objects: objects from: fromBlock to: #yourself
]

{ #category : #public }
RTEdgeBuilder >> objects: objects from: fromBlock to: toBlock [ 

	^ self objects: objects from: fromBlock to: toBlock scope: self globalScope
]

{ #category : #public }
RTEdgeBuilder >> objects: objects from: fromBlock to: toBlock scope: aGroup [

	| edges fromElement toElement fromObject toObject |
	objects isEmpty ifTrue: [ ^ #() ].
	edges := RTGroup new.
	objects do: [ :object |
		fromObject := fromBlock rtValue: object.
		toObject := toBlock rtValue: object.
		((aGroup includes: fromObject) and: [ aGroup includes: toObject ]) ifTrue: [  
				fromElement := self view elementFromModel: (fromBlock rtValue: object).
				toElement := self view elementFromModel: (toBlock rtValue: object).
				(self shouldCreateEdgeFrom: fromElement to: toElement)
					ifTrue: [   
						edges add: (self edgeFrom: fromElement to: toElement) ] ] ].
	^ edges

]

{ #category : #public }
RTEdgeBuilder >> objects: objects from: fromBlock toAll: toAllBlock [
	"aGroup is a group of objects"

	| edges fromElement toElement |
	edges := RTGroup new.
	objects isEmpty ifTrue: [ ^ edges ].
	objects do: [ :object |
		fromElement := self view elementFromModel: (fromBlock rtValue: object).
		(toAllBlock rtValue: object) do: [ :toObject |
			toElement := self view elementFromModel: toObject.
			(fromElement notNil and: [ toElement notNil ])
				ifTrue: [  
					(self shouldCreateEdgeFrom: fromElement to: toElement) ifTrue: 
						[ | edge |
						edge := self edgeFrom: fromElement to: toElement. 
						edges add: edge ] ] ] ].
	^ edges

]

{ #category : #public }
RTEdgeBuilder >> objects: objects fromAll: fromBlock to: toBlock [
	"aGroup is a group of objects"

	| edges fromElement toElement |
	edges := RTGroup new.
	objects isEmpty
		ifTrue: [ ^ edges ].
	
	objects
		do: [ :object | 
			toElement := self view elementFromModel: (toBlock rtValue: object).
			(fromBlock rtValue: object)
				do: [ :fromObject | 
					fromElement := self view elementFromModel: fromObject.		
											 
					(self shouldCreateEdgeFrom: fromElement to: toElement)
						ifTrue: [ 
							| edge |
							edge := self edgeFrom: fromElement to: toElement.
							edges add: edge ] ] ].
	^ edges
]

{ #category : #'public repetition' }
RTEdgeBuilder >> shouldAllowRepetition [
	^ allowRepetition
]

{ #category : #testing }
RTEdgeBuilder >> shouldCreateEdgeFrom: fromElement to: toElement [
	"Return true if an edge has to be created"
	fromElement == toElement ifTrue: [ ^ false ].
	(fromElement isNil or: [ toElement isNil ]) ifTrue: [ ^ false ].
	allowRepetition ifFalse: [ ^ fromElement outgoingEdges noneSatisfy: [ :edge | edge to == toElement ] ].
	^ true
]
