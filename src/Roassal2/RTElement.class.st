Class {
	#name : #RTElement,
	#superclass : #RTShapedObject,
	#instVars : [
		'position',
		'connectedEdges'
	],
	#category : #'Roassal2-Core'
}

{ #category : #public }
RTElement class >> forCollection: aCollection [ 
	^ (aCollection collect: [ :v | self on: v ]) asArray
]

{ #category : #public }
RTElement class >> on: anObject [

	^ self new model: anObject; yourself
]

{ #category : #visitor }
RTElement >> accept: aVisitor [
	aVisitor visitElement: self
]

{ #category : #initialization }
RTElement >> addConnectedEdge: anEdge [
	[  anEdge class == RTEdge ] assert.
	self connectedEdges add: anEdge
]

{ #category : #adding }
RTElement >> addedIn: aView [
	view := aView.
	view addElement: self
]

{ #category : #initialization }
RTElement >> connectedEdges [
	connectedEdges ifNil: [ connectedEdges := OrderedCollection new ].
	^ connectedEdges
]

{ #category : #accessing }
RTElement >> encompassingRectangle [
	"Return the encompassing rectangle of the element"
	^ trachelShape encompassingRectangle

]

{ #category : #accessing }
RTElement >> extent [
	"Returns a point, describing the extent of the encompassing rectangle of myself"
	^ self encompassingRectangle extent
]

{ #category : #accessing }
RTElement >> height [
	^ trachelShape height
]

{ #category : #accessing }
RTElement >> incomingEdges [
	connectedEdges ifNil: [ ^ #() ].
	^ self connectedEdges select: [ :e | e to == self ]
]

{ #category : #initialization }
RTElement >> initialize [
	super initialize.

]

{ #category : #testing }
RTElement >> isConnectedTo: anEdge [
	connectedEdges ifNil: [ ^ false ].
	^ connectedEdges anySatisfy: [ :edge | edge == anEdge ]
]

{ #category : #accessing }
RTElement >> outgoingEdges [
	connectedEdges ifNil: [ ^ #() ].
	^ self connectedEdges select: [ :e | e from == self ]
]

{ #category : #accessing }
RTElement >> position [
	^ trachelShape position
	
]

{ #category : #actions }
RTElement >> remove [
	view ifNil: [ self error: 'cannot remove an element that is not part of a view' ].
	view removeElement: self.
	view := nil 
]

{ #category : #actions }
RTElement >> translateBy: delta [
	"Translate the element by an incremental step. If I am connected to some edges, the edges are also updated."
	self translateTo: self position + delta
]

{ #category : #actions }
RTElement >> translateTo: newPosition [
	"Translate the element to a new position. If I am connected to some edges, the edges are also updated."
	trachelShape translateTo: newPosition.
	
	self connectedEdges do: [ :edge | edge update ].
	trachelShape resetPath
]

{ #category : #accessing }
RTElement >> width [
	^ trachelShape width
]
