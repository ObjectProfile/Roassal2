Class {
	#name : #RTBuilder,
	#superclass : #RTObject,
	#instVars : [
		'view',
		'interactionBuilder',
		'shapeBuilder'
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

{ #category : #hooks }
RTBuilder >> build [
	"to be overriden"
]

{ #category : #public }
RTBuilder >> cleanView [
	view edges copy do: #remove.
	view elements copy do: #remove.
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
	^ RTView new setDefaultMenu
]

{ #category : #public }
RTBuilder >> edgeFrom: source to: target [ 
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
	interactionBuilder setUpElements: els.
	^ els
]

{ #category : #initialization }
RTBuilder >> initialize [
	super initialize.
	view := self createView.
	shapeBuilder := self createShapeBuilder.
	interactionBuilder := self createInteractionBuilder
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
	self renderIn: aView.
	^ aView open
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

{ #category : #accessing }
RTBuilder >> shape [
	^ shapeBuilder
]

{ #category : #accessing }
RTBuilder >> shapeBuilder: anRTShapeBuilder [

	shapeBuilder := anRTShapeBuilder
]

{ #category : #accessing }
RTBuilder >> view [
	^ view
]

{ #category : #accessing }
RTBuilder >> view: aRTView [
	view := aRTView
]
