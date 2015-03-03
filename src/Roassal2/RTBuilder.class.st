Class {
	#name : #RTBuilder,
	#superclass : #RTObject,
	#instVars : [
		'view',
		'interactionBuilder',
		'shapeBuilder',
		'layoutBuilder',
		'title'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #accessing }
RTBuilder class >> nestedElementsAttribute [
	^ #nestedElements
]

{ #category : #public }
RTBuilder >> addElementOn: anObject [
	| element |
	element := self elementOn: anObject.
	view add: element.
	^ element
]

{ #category : #public }
RTBuilder >> build [
	"Simply render the view"
	self renderIn: view.
	^ view
]

{ #category : #public }
RTBuilder >> cleanView [
	view edges copy do: #remove.
	view elements copy do: #remove.
]

{ #category : #hooks }
RTBuilder >> createGlobalBuilder [
	^ RTGlobalBuilder new
]

{ #category : #hooks }
RTBuilder >> createInteractionBuilder [
	^ RTInteractionBuilder new
]

{ #category : #hooks }
RTBuilder >> createShapeBuilder [
	^ RTShapeBuilder new
]

{ #category : #hooks }
RTBuilder >> createView [
	^ RTView new
]

{ #category : #accessing }
RTBuilder >> createdElements [
	^ shapeBuilder createdElements
]

{ #category : #initialization }
RTBuilder >> defaultWindowName [
	^ 'Roassal'
]

{ #category : #public }
RTBuilder >> edgeFrom: source to: target [ 
	"source and target are elements"
	| newEdge |
	newEdge := shapeBuilder edgeFrom: source to: target.
	view add: newEdge.
	^ newEdge
]

{ #category : #protected }
RTBuilder >> elementOn: anObject [
	| element |
	element := shapeBuilder elementOn: anObject.
	interactionBuilder setUpElements: element.
	^ element
]

{ #category : #protected }
RTBuilder >> elementsOn: collectionOfObjects [
	| elements |
	elements := shapeBuilder elementsOn: collectionOfObjects.
	interactionBuilder setUpElements: elements.
	^ elements
]

{ #category : #protected }
RTBuilder >> elementsWithInteractionOn: collectionOfObjects [
	| els |
	els := shapeBuilder elementsOn: collectionOfObjects.
	self setUpInteractionFor: els.
	^ els
]

{ #category : #accessing }
RTBuilder >> globalRule [
	^ RTGlobalRule new view: self view; yourself
]

{ #category : #initialization }
RTBuilder >> initialize [
	super initialize.
	title := self defaultWindowName.
	view := self createView.
	self resetShape.
	self resetInteraction.

]

{ #category : #accessing }
RTBuilder >> interaction [
	^ interactionBuilder
]

{ #category : #accessing }
RTBuilder >> interactionBuilder: anRTInteractionBuilder [
	interactionBuilder := anRTInteractionBuilder
]

{ #category : #accessing }
RTBuilder >> nestedElementsAttribute [
	^ self class nestedElementsAttribute
]

{ #category : #'public-ui' }
RTBuilder >> open [
	^ self openIn: view
]

{ #category : #'public-ui' }
RTBuilder >> openIn: aView [
	self build.
	^ aView openTitled: title
]

{ #category : #copying }
RTBuilder >> postCopy [
	super postCopy.
	shapeBuilder := shapeBuilder copy.
	interactionBuilder := interactionBuilder copy.
]

{ #category : #'public-ui' }
RTBuilder >> render [
	self renderIn: self view
]

{ #category : #hooks }
RTBuilder >> renderIn: aView [
	"You may want to override this method to fill the view"
]

{ #category : #protected }
RTBuilder >> resetCreatedElements [
	shapeBuilder resetCreatedElements
]

{ #category : #resetting }
RTBuilder >> resetInteraction [
	interactionBuilder := self createInteractionBuilder
]

{ #category : #resetting }
RTBuilder >> resetShape [
	shapeBuilder := self createShapeBuilder
]

{ #category : #public }
RTBuilder >> restoreCamera [
	"Reuse a previous camera. This is useful when scripting in a playground"
	self view restoreCamera
]

{ #category : #public }
RTBuilder >> setCurrentShape: aShape [
	shapeBuilder shape: aShape
]

{ #category : #protected }
RTBuilder >> setUpInteractionFor: oneOrMoreElements [
	"This method may be used in subclasses to set up the interaction on the elements provided as argument"
	interactionBuilder setUpElements: oneOrMoreElements asGroup
]

{ #category : #accessing }
RTBuilder >> shape [
	^ shapeBuilder
]

{ #category : #accessing }
RTBuilder >> shapeBuilder: anRTShapeBuilder [

	shapeBuilder := anRTShapeBuilder
]

{ #category : #accessing }
RTBuilder >> title [
	"Return the name of the builder"
	^ title
]

{ #category : #accessing }
RTBuilder >> title: aString [
	"Set the name of the builder. The name is used when opening the builder, in the window"
	title := aString
]

{ #category : #accessing }
RTBuilder >> view [
	^ view
]

{ #category : #accessing }
RTBuilder >> view: aRTView [
	view := aRTView
]
