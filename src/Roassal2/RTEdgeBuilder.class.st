"
RTEdgeBuilder offers an API to easily build edges.

Here is an example:
[ [ [ 
	| v es |
	v := RTView new.

	es := (RTEllipse new size: 20) elementsOn: (1 to: 20).
	v addAll: es.

	RTEdgeBuilder new
		view: v;
		objects: (1 to: 20);
		connectFrom: [ :value | value // 2 ].

	es @ RTPopup @ RTDraggable.
	RTTreeLayout on: es.
	v ] ] ]
"
Class {
	#name : #RTEdgeBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'allowRepetition',
		'fromElements',
		'toElements',
		'shouldMoveBehind',
		'shouldNotBeUsedInLayout',
		'createdEdges',
		'viewHasBeenManuallySet'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #'public repetition' }
RTEdgeBuilder >> allowRepetition [
	allowRepetition := true
]

{ #category : #public }
RTEdgeBuilder >> connectFrom: aBlockOrASymbol [
	| fromElement aModel |
	self resetCreatedEdges.
	self toElements copy
		do: [ :e | 
			aModel := aBlockOrASymbol rtValue: e model.
			fromElement := self fromElements elementFromModel: aModel.
			fromElement ifNotNil: [ self createEdgeIfNecessaryFrom: fromElement to: e ] ].
	self moveBehindIfNecessary: createdEdges.
	^ createdEdges
]

{ #category : #public }
RTEdgeBuilder >> connectFrom: aFromBlock to: aBlockOrASymbol [
	| toElement fromElement |
	self resetCreatedEdges.
	self fromElements copy
		do: [ :e | 
			fromElement := self fromElements elementFromModel: (aFromBlock rtValue: e model).
			toElement := self toElements elementFromModel: (aBlockOrASymbol rtValue: e model).
			toElement ifNotNil: [ self createEdgeIfNecessaryFrom: fromElement to: toElement ] ].
	self moveBehindIfNecessary: createdEdges.
	^ createdEdges
]

{ #category : #public }
RTEdgeBuilder >> connectFrom: aFromBlock toAll: aBlockOrASymbol [

	| fromElement tes |
	self resetCreatedEdges.
	self fromElements copy do: [ :e | 
		fromElement := self fromElements elementFromModel: (aFromBlock rtValue: e model).
		tes := self toElements elementsFromModels: (aBlockOrASymbol rtValue: e model).
		tes ifNotNil: [ 
			tes do: [ :toE | 
				self createEdgeIfNecessaryFrom: fromElement to: toE ] ] ].
	self moveBehindIfNecessary: createdEdges.
	^ createdEdges 
]

{ #category : #public }
RTEdgeBuilder >> connectFromAll: aFromBlockOrSymbol to: aBlockOrASymbol [

	| toElement tfromElements |
	self resetCreatedEdges.
	self fromElements copy do: [ :e | 
		tfromElements := self fromElements elementsFromModels: (aFromBlockOrSymbol rtValue: e model). 
		toElement := self toElements elementFromModel: (aBlockOrASymbol rtValue: e model).
		tfromElements ifNotNil: [ 
			tfromElements do: [ :fromElement | 
				self createEdgeIfNecessaryFrom: fromElement to: toElement ] ] ].
	self moveBehindIfNecessary: createdEdges.
	^ createdEdges
]

{ #category : #public }
RTEdgeBuilder >> connectTo: aBlockOrASymbol [
	"Should this method use connectFrom:To: ?????"
	| toElement |
	self resetCreatedEdges.
	self fromElements copy do: [ :e | 
		toElement := self toElements elementFromModel: (aBlockOrASymbol rtValue: e model).
		toElement ifNotNil: [ 
			self createEdgeIfNecessaryFrom: e to: toElement ] ].
	self moveBehindIfNecessary: createdEdges.
	^ createdEdges
]

{ #category : #public }
RTEdgeBuilder >> connectToAll: aBlockOrASymbol [
	"Should this method use connectFrom:ToAll: ?????"
	| tmptoElements |
	self resetCreatedEdges.
	self fromElements copy do: [ :e | 
		tmptoElements := self toElements elementsFromModels: (aBlockOrASymbol rtValue: e model).
		tmptoElements ifNotNil: [ 
			tmptoElements do: [ :toE | 
				self createEdgeIfNecessaryFrom: e to: toE ] ] ].
	self moveBehindIfNecessary: createdEdges.
	^ createdEdges
]

{ #category : #'private - utility' }
RTEdgeBuilder >> createEdgeIfNecessaryFrom: fromElement to: toElement [
	(self shouldCreateEdgeFrom: fromElement to: toElement)
		ifTrue: [ createdEdges add: (self edgeFrom: fromElement to: toElement) ]
]

{ #category : #'private - utility' }
RTEdgeBuilder >> edgeFrom: source to: target [ 
	"source and target are elements"
	| edge |
	edge := super edgeFrom: source to: target.
	shouldNotBeUsedInLayout ifFalse: [ edge notUseInLayout ].
	^ edge
]

{ #category : #accessing }
RTEdgeBuilder >> elements: someElements [
	self toElements: someElements.
	self fromElements: someElements
]

{ #category : #'public associations' }
RTEdgeBuilder >> fromAssociation: assoc [
	"assoc have to be between model objects"
	self fromAssociations: (Array with: assoc)
]

{ #category : #'public associations' }
RTEdgeBuilder >> fromAssociations: associations [
	"associations have to be between model objects"
	
	| edges fromElement toElement |
	edges := RTGroup new.
	associations do: [ :assoc |
		fromElement := self fromElements elementFromModel: assoc key.
		toElement := self toElements elementFromModel: assoc value.
		edges add: (self edgeFrom: fromElement to: toElement) ].
	self moveBehindIfNecessary: edges.
	^ edges
]

{ #category : #'public associations' }
RTEdgeBuilder >> fromElementAssociations: associationsBetweenElements [
	associationsBetweenElements do: [ :assoc |
		self edgeFrom: assoc key to: assoc value ]
]

{ #category : #accessing }
RTEdgeBuilder >> fromElements [
	fromElements ifNil: [ ^ self view elements ].
	^ fromElements
]

{ #category : #accessing }
RTEdgeBuilder >> fromElements: someElements [
	fromElements := someElements
]

{ #category : #accessing }
RTEdgeBuilder >> fromObjects: someObjectsOrABlock [
	"Identify the elements we are considering for the edge building process. Note that the view has to be set beforehand."
	self assert: [ viewHasBeenManuallySet ] description: 'A view has to be set, please use #view:'.
	 
	(someObjectsOrABlock isCollection and: [ someObjectsOrABlock isSymbol not ])
		ifTrue: [ self fromElements: (view elementsFromModels: someObjectsOrABlock) ]
		ifFalse: [ self fromElements: (view elements select: [ :el | someObjectsOrABlock rtValue: el model ]) ]
]

{ #category : #initialization }
RTEdgeBuilder >> initialize [
	super initialize.
	self noRepetition.
	shouldMoveBehind := false.
	shouldNotBeUsedInLayout := true.
	
	"The view has to be explicitely set by the end-user"
	viewHasBeenManuallySet := false
]

{ #category : #'private - utility' }
RTEdgeBuilder >> linkElements: someElements [
	"Link the first element to the second, the second to the third and so on"
	| head |
	head := someElements first.
	someElements allButFirst do: [ :e |
		self edgeFrom: head to: e.
		head := e.
		]
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

{ #category : #initialization }
RTEdgeBuilder >> noRepetition [
	allowRepetition := false
]

{ #category : #configuration }
RTEdgeBuilder >> notUseInLayout [
	shouldNotBeUsedInLayout := false
]

{ #category : #accessing }
RTEdgeBuilder >> object: anObject [
	^ self objects: (Array with: anObject)
]

{ #category : #accessing }
RTEdgeBuilder >> objects: someObjectsOrABlock [
	"Identify the elements we are considering for the edge building process. Note that the view has to be set beforehand."
	self assert: [ viewHasBeenManuallySet ] description: 'A view has to be set, please use #view:'.
	self toObjects: someObjectsOrABlock.
	self fromObjects: someObjectsOrABlock.
]

{ #category : #'private - utility' }
RTEdgeBuilder >> resetCreatedEdges [
	createdEdges := RTGroup new
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

{ #category : #accessing }
RTEdgeBuilder >> toElements [
	toElements ifNil: [ ^ self view elements ].
	^ toElements
]

{ #category : #accessing }
RTEdgeBuilder >> toElements: someElements [
	toElements := someElements
]

{ #category : #accessing }
RTEdgeBuilder >> toObject: anObject [
	^ self toObjects: (Array with: anObject)
]

{ #category : #accessing }
RTEdgeBuilder >> toObjects: someObjectsOrABlock [
	"Identify the elements we are considering for the edge building process. Note that the view has to be set beforehand."
	self assert: [ viewHasBeenManuallySet ] description: 'A view has to be set, please use #view:'.
	 
	(someObjectsOrABlock isCollection and: [ someObjectsOrABlock isSymbol not ])
		ifTrue: [ self toElements: (view elementsFromModels: someObjectsOrABlock) ]
		ifFalse: [ self toElements: (view elements select: [ :el | someObjectsOrABlock rtValue: el model ]) ]
]

{ #category : #accessing }
RTEdgeBuilder >> view: aView [
	viewHasBeenManuallySet := true.
	super view: aView
]
