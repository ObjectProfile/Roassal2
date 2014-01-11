Class {
	#name : #RTElement,
	#superclass : #RTShapedObject,
	#instVars : [
		'position',
		'model',
		'connectedEdges',
		'incomingEdges',
		'outgoingEdges'
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
	position := 0 @ 0.

]

{ #category : #testing }
RTElement >> isConnectedTo: anEdge [
	connectedEdges ifNil: [ ^ false ].
	^ connectedEdges anySatisfy: [ :edge | edge == anEdge ]
]

{ #category : #accessing }
RTElement >> model [
	^ model
]

{ #category : #accessing }
RTElement >> model: anObject [
	"anObject could be any Smalltalk object. Shapes are computed based on that object"
	model := anObject
]

{ #category : #accessing }
RTElement >> outgoingEdges [
	connectedEdges ifNil: [ ^ #() ].
	^ self connectedEdges select: [ :e | e from == self ]
]

{ #category : #accessing }
RTElement >> position [
	^ position
]

{ #category : #actions }
RTElement >> remove [
	view removeElement: self.
	view := nil 
]

{ #category : #actions }
RTElement >> translateBy: delta [
	"Translate the element by an incremental step. If I am connected to some edges, the edges are also updated."
	self translateTo: position + delta
]

{ #category : #actions }
RTElement >> translateTo: newPosition [
	"Translate the element to a new position. If I am connected to some edges, the edges are also updated."
	position := newPosition.
	self connectedEdges do: [ :edge | edge update ].
	self update

]

{ #category : #accessing }
RTElement >> width [
	^ trachelShape width
]
