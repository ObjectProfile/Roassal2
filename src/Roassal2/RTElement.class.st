Class {
	#name : #RTElement,
	#superclass : #RTShapedObject,
	#instVars : [
		'position',
		'model',
		'width',
		'height',
		'incomingEdges',
		'outgoingEdges'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTElement class >> on: anObject [

	^ self new model: anObject; yourself
]

{ #category : #'as yet unclassified' }
RTElement >> addIncomingEdge: anEdge [
	"Method invoked by the class Edge, the user is not supposed to call this method directly.
	We keep a list of incoming and outoing edges because when the element is dragged and dropped, 
	the edges may have to be updated"
	incomingEdges isNil ifTrue: [ incomingEdges := OrderedCollection new ]. 
	incomingEdges add: anEdge
]

{ #category : #'as yet unclassified' }
RTElement >> addOutgoingEdge: anEdge [
	"Method invoked by the class Edge, the user is not supposed to call this method directly.
	We keep a list of incoming and outoing edges because when the element is dragged and dropped, 
	the edges may have to be updated"
	outgoingEdges isNil ifTrue: [ outgoingEdges := OrderedCollection new ]. 
	outgoingEdges add: anEdge
]

{ #category : #'as yet unclassified' }
RTElement >> addedIn: view [
	view addElement: self
]

{ #category : #'as yet unclassified' }
RTElement >> encompassingRectangle [
	^ (self position - ((self width / 2) @ (self height / 2))) extent: (self width @ self height)
]

{ #category : #'as yet unclassified' }
RTElement >> extent [
	^ self encompassingRectangle extent
]

{ #category : #'as yet unclassified' }
RTElement >> height [
	^ trachelShape height
]

{ #category : #'as yet unclassified' }
RTElement >> incomingEdges [
	incomingEdges isNil ifTrue: [ ^ #() ].
	^ incomingEdges
]

{ #category : #'as yet unclassified' }
RTElement >> initialize [
	super initialize.
	position := 0 @ 0.

]

{ #category : #'as yet unclassified' }
RTElement >> model [
	^ model
]

{ #category : #'as yet unclassified' }
RTElement >> model: anObject [
	"anObject could be any Smalltalk object. Shapes are computed based on that object"
	model := anObject
]

{ #category : #'as yet unclassified' }
RTElement >> outgoingEdges [
	outgoingEdges isNil ifTrue: [ ^ #() ].
	^ outgoingEdges
]

{ #category : #'as yet unclassified' }
RTElement >> position [
	^ position
]

{ #category : #'as yet unclassified' }
RTElement >> translateBy: delta [
	self translateTo: position + delta
]

{ #category : #'as yet unclassified' }
RTElement >> translateTo: newPosition [
	position := newPosition.
	self outgoingEdges do: [ :edge | edge update ].
	self incomingEdges do: [ :edge | edge update ].
	self update

]

{ #category : #'as yet unclassified' }
RTElement >> width [
	^ trachelShape width
]
