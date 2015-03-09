Class {
	#name : #RTEdgeBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'allowRepetition',
		'elements',
		'elementsToLookup',
		'shouldMoveBehind',
		'shouldNotBeUsedInLayout'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #'public repetition' }
RTEdgeBuilder >> allowRepetition [
	allowRepetition := true
]

{ #category : #public }
RTEdgeBuilder >> connectFrom: aBlockOrASymbol [

	| edges fromElement aModel |
	edges := RTGroup new.
	self elements copy do: [ :e | 
		aModel := aBlockOrASymbol rtValue: e model.
		fromElement := self elementsToLookup elementFromModel: aModel.
		fromElement ifNotNil: [ edges add: (self edgeFrom: fromElement to: e) ] ].
	self moveBehindIfNecessary: edges.
	^ edges
]

{ #category : #public }
RTEdgeBuilder >> connectFrom: aFromBlock ToAll: aBlockOrASymbol [

	| edges toElements fromElement |
	edges := RTGroup new.
	self elements copy do: [ :e | 
		fromElement := self elements elementFromModel: (aFromBlock rtValue: e model). 
		toElements := self elementsToLookup elementsFromModels: (aBlockOrASymbol rtValue: e model).
		toElements ifNotNil: [ 
			toElements do: [ :toE | 
				edges add: (self edgeFrom: fromElement to: toE) ] ] ].
	self moveBehindIfNecessary: edges.
	^ edges
]

{ #category : #public }
RTEdgeBuilder >> connectTo: aBlockOrASymbol [

	| edges toElement |
	edges := RTGroup new.
	self elements copy do: [ :e | 
		toElement := self elementsToLookup elementFromModel: (aBlockOrASymbol rtValue: e model).
		toElement ifNotNil: [ edges add: (self edgeFrom: e to: toElement) ] ].
	self moveBehindIfNecessary: edges.
	^ edges
]

{ #category : #public }
RTEdgeBuilder >> connectToAll: aBlockOrASymbol [

	| edges toElements |
	edges := RTGroup new.
	self elements copy do: [ :e | 
		toElements := self elementsToLookup elementsFromModels: (aBlockOrASymbol rtValue: e model).
		toElements ifNotNil: [ 
			toElements do: [ :toE | 
				edges add: (self edgeFrom: e to: toE) ] ] ].
	self moveBehindIfNecessary: edges.
	^ edges
]

{ #category : #public }
RTEdgeBuilder >> edgeFrom: source to: target [ 
	"source and target are elements"
	| edge |
	edge := super edgeFrom: source to: target.
	shouldNotBeUsedInLayout ifFalse: [ edge notUseInLayout ].
	^ edge
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

{ #category : #accessing }
RTEdgeBuilder >> elementsToLookup [
	"Return the group of elements to look up the ending of edges"
	^ elementsToLookup isNil ifTrue: [ self elements asGroup ] ifFalse: [ elementsToLookup asGroup ]
]

{ #category : #accessing }
RTEdgeBuilder >> elementsToLookup: someElements [
	"Set the group of elements to look up the ending of edges"
	^ elementsToLookup := someElements
]

{ #category : #'public associations' }
RTEdgeBuilder >> fromAssociation: assoc [
	"assoc have to be between model objects"
	self fromAssociations: (Array with: assoc)
]

{ #category : #'public associations' }
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
	allowRepetition := false.
	shouldMoveBehind := false.
	shouldNotBeUsedInLayout := true.
	
	"If nil, then elements will be used to lookup"
	elementsToLookup := nil
]

{ #category : #accessing }
RTEdgeBuilder >> moveBehind [
	"Set the builder as such that edge that are built and added in the view _behind_ the extremities of each edges"
	shouldMoveBehind := true
]

{ #category : #'private - utility' }
RTEdgeBuilder >> moveBehindIfNecessary: someEdges [
	shouldMoveBehind ifFalse: [ ^ self ].
	someEdges pushBack
]

{ #category : #configuration }
RTEdgeBuilder >> notUseInLayout [
	shouldNotBeUsedInLayout := false
]

{ #category : #deprecated }
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
	self moveBehindIfNecessary: edges.
	^ edges

]

{ #category : #accessing }
RTEdgeBuilder >> objects: someObjectsOrABlock [
	"Identify the elements we are considering for the edge building process. Note that the view has to be set beforehand."
	self assert: [ view notNil ] description: 'A view has to be set, please use #view:'.
	 
	(someObjectsOrABlock isCollection and: [ someObjectsOrABlock isSymbol not ])
		ifTrue: [ self elements: (view elementsFromModels: someObjectsOrABlock) ]
		ifFalse: [ self elements: (view elements select: [ :el | someObjectsOrABlock rtValue: el model ]) ]
]

{ #category : #deprecated }
RTEdgeBuilder >> objects: objects from: fromBlock [
	^ self objects: objects from: fromBlock to: #yourself
]

{ #category : #deprecated }
RTEdgeBuilder >> objects: objects from: fromBlock to: toBlock [ 

	^ self objects: objects from: fromBlock to: toBlock scope: self globalScope
]

{ #category : #deprecated }
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
	self moveBehindIfNecessary: edges.
	^ edges

]

{ #category : #deprecated }
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
	self moveBehindIfNecessary: edges.
	^ edges

]

{ #category : #deprecated }
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
	self moveBehindIfNecessary: edges.
	^ edges
]

{ #category : #deprecated }
RTEdgeBuilder >> objects: objects to: toBlock [
	^ self objects: objects from: toBlock to: #yourself
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
