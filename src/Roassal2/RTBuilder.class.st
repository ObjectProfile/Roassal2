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

{ #category : #public }
RTBuilder >> addElementOn: anObject [
	| element |
	element := self elementOn: anObject.
	interactionBuilder setUpElements: element.
	view add: element.
	^ element
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
	^ shapeBuilder elementOn: anObject
]

{ #category : #protected }
RTBuilder >> elementsOn: collectionOfObjects [
	^ shapeBuilder elementsOn: collectionOfObjects
]

{ #category : #initialization }
RTBuilder >> initialize [
	super initialize.
	view := RTView new.
	shapeBuilder := RTShapeBuilder new.
	interactionBuilder := RTInteractionBuilder new.
]

{ #category : #accessing }
RTBuilder >> interaction [
	^ interactionBuilder
]

{ #category : #accessing }
RTBuilder >> interactionBuilder: anRTInteractionBuilder [
	interactionBuilder := anRTInteractionBuilder
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
