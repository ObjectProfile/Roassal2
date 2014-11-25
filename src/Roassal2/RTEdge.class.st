Class {
	#name : #RTEdge,
	#superclass : #RTShapedObject,
	#instVars : [
		'from',
		'to'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromAssociations: associations inView: view [
	"associations could be {2 -> 5 . 1 -> 5 }.
	 Takes the model of element into account"
	
	^ self buildEdgesFromAssociations: associations using: RTLine inView: view
]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromAssociations: associations using: aLineShape [
	"associations could be {2 -> 5 . 1 -> 5 }.
	 Takes the model of element into account"
	
	^ self buildEdgesFromElements: associations from: #key to: #value using: aLineShape
]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromAssociations: associations using: aLineShape inView: view [
	"associations could be {2 -> 5 . 1 -> 5 }.
	 Takes the model of element into account"
	
	| edges associationsOfElements |
	associationsOfElements := associations collect: [ :assoc | (view elementFromModel: assoc key) -> (view elementFromModel: assoc value) ].
	associationsOfElements isEmpty ifTrue: [ ^ #() ].
	
	edges := OrderedCollection new.
	associationsOfElements do: [ :associationOfTwoElements |
				| edge |
				edge := RTEdge from: associationOfTwoElements key to: associationOfTwoElements value. 
				edge + aLineShape.
				edges add: edge ].
	view addAll: edges.
	^ edges

]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromElements: elements from: fromBlock to: toBlock [
	"Handy method to easily build edges. Return a list of edges"
	"fromBlock and toBlock operates on the model of the elements"

	^ self buildEdgesFromElements: elements from: fromBlock to: toBlock using: RTLine
]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromElements: elements from: fromBlock to: toBlock in: view [
	"Handy method to easily build edges. Return a list of edges"

	^ self buildEdgesFromElements: elements from: fromBlock to: toBlock using: RTLine in: view
]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromElements: elements from: fromBlock to: toBlock inView: view [
	"Handy method to easily build edges. Return a list of edges"

	^ self buildEdgesFromElements: elements from: fromBlock to: toBlock using: RTLine inView: view
]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromElements: elements from: fromBlock to: toBlock using: aLineShape [
	"Handy method to easily build edges. Return a list of edges"
	"fromBlock and toBlock operate on the model of the elements"

	| edges container fromElement toElement elementsWithModels |
	elements isEmpty ifTrue: [ ^ #() ].
	edges := OrderedCollection new.
	elementsWithModels := elements select: [ :el | el model notNil ].
	elementsWithModels do: [ :element |
		container := element parent.
		fromElement := container elementFromModel: (fromBlock rtValue: element model).
		toElement := container elementFromModel: (toBlock rtValue: element model).
		(fromElement notNil and: [ toElement notNil ])
			ifTrue: [  
				| edge |
				edge := RTEdge from: fromElement to: toElement. 
				edge + aLineShape.
				edges add: edge.
				container add: edge ] ].
	^ edges

]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromElements: elements from: fromBlock to: toBlock using: aLineShape inView: view [
	"Handy method to easily build edges. Return a list of edges"
	"fromBlock and toBlock operate on the model of the elements"

	view addAll: (self buildEdgesFromElements: elements from: fromBlock to: toBlock using: aLineShape)
]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromElements: elements from: fromBlock toAll: toBlock inView: view [
	"Handy method to easily build edges. Return a list of edges"
	"fromBlock and toBlock operate on the model of the elements"
	"toBlock should return a collection of models"

	^ self buildEdgesFromElements: elements from: fromBlock toAll: toBlock using: RTLine new inView: view
]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromElements: elements from: fromBlock toAll: toBlock using: aLineShape [
	"Handy method to easily build edges. Return a list of edges"
	"fromBlock and toBlock operate on the model of the elements"
	"toBlock should return a collection of models"

	| edges container fromElement toElements elementsWithModels |
	elements isEmpty ifTrue: [ ^ #() ].
	edges := OrderedCollection new.
	elementsWithModels := elements select: [ :el | el model notNil ].
	
	elementsWithModels do: [ :element |
		container := element view.
		fromElement := container elementFromModel: (fromBlock rtValue: element model).
		
		"We get the list of elements that corresponds to (toBlock roValues: element model)"
		toElements := OrderedCollection new.
		(toBlock rtValue: element model) do: [ :model | 
			| v |
			v := container elementFromModel: model.
			v notNil ifTrue: [ toElements add: v ] ].
		
		
		(fromElement notNil and: [ toElements notEmpty ])
			ifTrue: [  
				toElements do: [ :toElement |
					| edge |
					edge := RTEdge from: fromElement to: toElement. 
					edge + aLineShape.
					edges add: edge.
					container add: edge ] ]  ].
	^ edges

]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromElements: elements from: fromBlock toAll: toBlock using: aLineShape inView: view [
	"Handy method to easily build edges. Return a list of edges"
	"fromBlock and toBlock operate on the model of the elements"
	"toBlock should return a collection of models"

	| es |
	es := self buildEdgesFromElements: elements from: fromBlock toAll: toBlock using: aLineShape.
	view addAll: es.
	^ es
]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromObjects: objects from: fromBlock to: toBlock inView: view [
	"Handy method to easily build edges. Return a list of edges"
	"fromBlock and toBlock operate on the model of the elements"

	^ self buildEdgesFromObjects: objects from: fromBlock to: toBlock using: RTLine inView: view
]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromObjects: objects from: fromBlock to: toBlock inView: view scope: aGroup [
	"Handy method to easily build edges. Return a list of edges"
	"fromBlock and toBlock operate on the model of the elements"

	^ self buildEdgesFromObjects: objects from: fromBlock to: toBlock using: RTLine inView: view scope: aGroup
]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromObjects: objects from: fromBlock to: toBlock scope: aGroup [
	"Handy method to easily build edges. Return a list of edges"
	"fromBlock and toBlock operate on the model of the elements"

	^ self buildEdgesFromObjects: objects from: fromBlock to: toBlock using: RTLine new scope: aGroup
]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromObjects: objects from: fromBlock to: toBlock using: aLineShape inView: view [
	"Handy method to easily build edges. Return a list of edges"
	"fromBlock and toBlock operate on the model of the elements"

	^ self buildEdgesFromObjects: objects from: fromBlock to: toBlock using: aLineShape inView: view scope: (RTGroup withAll: view elements)
]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromObjects: objects from: fromBlock to: toBlock using: aLineShape inView: view scope: aGroup [
	"Handy method to easily build edges. Return a list of edges"
	"fromBlock and toBlock operate on the model of the elements"

	| es |
	es := self buildEdgesFromObjects: objects from: fromBlock to: toBlock using: aLineShape scope: aGroup.
	view addAll: es.
	^ es
]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromObjects: objects from: fromBlock to: toBlock using: aLineShape scope: aGroup [
	"Handy method to easily build edges. Return a list of edges"
	"fromBlock and toBlock operate on the model of the elements"

	| edges fromElement toElement |
	objects isEmpty ifTrue: [ ^ #() ].
	edges := RTGroup new.
	objects do: [ :object |
		fromElement := aGroup elementFromModel: (fromBlock rtValue: object).
		toElement := aGroup elementFromModel: (toBlock rtValue: object).
		(fromElement notNil and: [ toElement notNil ])
			ifTrue: [  
				| edge |
				edge := RTEdge from: fromElement to: toElement. 
				edge model: object.
				edge + aLineShape.
				edges add: edge ] ].
	^ edges

]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromObjects: objects from: fromBlock toAll: toAllBlock inView: view [
	^ self buildEdgesFromObjects: objects from: fromBlock toAll: toAllBlock using: RTLine new inView: view scope: (RTGroup withAll: view elements)
]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromObjects: objects from: fromBlock toAll: toAllBlock scope: aGroup [
	"Handy method to easily build edges. Return a list of edges"
	"fromBlock and toAllBlock operate on the model of the elements"
	^ self buildEdgesFromObjects: objects from: fromBlock toAll: toAllBlock using: RTLine new scope: aGroup
]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromObjects: objects from: fromBlock toAll: toAllBlock using: aLineShape inView: view [ 
	^ self buildEdgesFromObjects: objects from: fromBlock toAll: toAllBlock using: aLineShape inView: view scope: (RTGroup withAll: view elements)
]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromObjects: objects from: fromBlock toAll: toAllBlock using: aLineShape inView: view scope: aGroup [
	"Handy method to easily build edges. Return a list of edges"
	"fromBlock and toAllBlock operate on the model of the elements"

	| edges fromElement toElement |
	edges := RTGroup new.
	objects isEmpty ifTrue: [ ^ edges ].
	objects do: [ :object |
		fromElement := aGroup elementFromModel: (fromBlock rtValue: object).
		(toAllBlock rtValue: object) do: [ :toObject |
			toElement := aGroup elementFromModel: toObject.
			(fromElement notNil and: [ toElement notNil ])
				ifTrue: [  
					(fromElement ~~ toElement) ifTrue: 
						[ | edge |
						edge := RTEdge from: fromElement to: toElement. 
						edge + aLineShape.
						edges add: edge.
						view add: edge ] ] ] ].
	^ edges

]

{ #category : #'public - edge construction' }
RTEdge class >> buildEdgesFromObjects: objects from: fromBlock toAll: toAllBlock using: aLineShape scope: aGroup [
	"Handy method to easily build edges. Return a list of edges"
	"fromBlock and toAllBlock operate on the model of the elements"

	| edges fromElement toElement |
	objects isEmpty ifTrue: [ ^ #() ].
	edges := RTGroup new.
	objects do: [ :object |
		fromElement := aGroup elementFromModel: (fromBlock rtValue: object).
		(toAllBlock rtValue: object) do: [ :toObject |
			toElement := aGroup elementFromModel: toObject.
			(fromElement notNil and: [ toElement notNil ])
				ifTrue: [  
					(fromElement ~~ toElement) ifTrue: 
						[ | edge |
						edge := RTEdge from: fromElement to: toElement. 
						edge + aLineShape.
						edges add: edge.
						 ] ] ] ].
	^ edges

]

{ #category : #public }
RTEdge class >> from: fromElement to: toElement [
	"Takes instances of RTElement as arguments"
	^ self 
		on: fromElement model -> toElement model 
		from: fromElement 
		to: toElement
]

{ #category : #public }
RTEdge class >> from: fromElement toAll: toElementss [
	"Takes instances of RTElement as first argument and a collection of RTElements as second argument"
	^ RTGroup withAll: (toElementss collect: [ :e | self from: fromElement to: e ])
]

{ #category : #public }
RTEdge class >> on: aModel from: fromElement to: toElement [
	^ (self model: aModel) from: fromElement to: toElement; yourself
]

{ #category : #accessing }
RTEdge >> addedIn: aView [
	view := aView.
	view addEdge: self
]

{ #category : #accessing }
RTEdge >> encompassingRectangle [
	"Return the encompassing rectangle of the elements"
	^ Rectangle merging: (Array with: self from encompassingRectangle with: self to encompassingRectangle)
]

{ #category : #accessing }
RTEdge >> from [
	
	^ from
]

{ #category : #accessing }
RTEdge >> from: anElement [
	from ifNotNil: [ :element | element removeConnectedEdge: self ].
	from := anElement.
	anElement addConnectedEdge: self
]

{ #category : #accessing }
RTEdge >> from: fromElement to: toElement [
	self from: fromElement.
	self to: toElement
]

{ #category : #actions }
RTEdge >> moveBehind: elements [
	self trachelShape pushBehindAll: (elements collect: [:each | each trachelShape])
]

{ #category : #actions }
RTEdge >> moveBehindItsExtremities [
	"Make the edge be displayed before its extremities are displayed. This is useful to not have the edge over the extremity nodes"
	self trachelShape pushBehindAll: (Array with: self from trachelShape with: self to trachelShape)
]

{ #category : #actions }
RTEdge >> remove [
	view ifNil: [ self error: 'cannot remove an element that is not part of a view' ].
	(to connectedEdges includes: self) 
		ifTrue: [to connectedEdges remove: self].
	(from connectedEdges includes: self)
		ifTrue: [from connectedEdges remove: self].
	(view isNil)
		ifFalse: [  
			view removeEdge: self.
			view := nil]
]

{ #category : #accessing }
RTEdge >> to [
	
	^ to
]

{ #category : #accessing }
RTEdge >> to: anElement [
	to ifNotNil: [ :element | element removeConnectedEdge: self ].
	to := anElement.
	anElement addConnectedEdge: self
]

{ #category : #actions }
RTEdge >> translateBy: aPoint [
	"do nothing"
]
