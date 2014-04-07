Class {
	#name : #RTHTMLBuilder,
	#superclass : #RTObject,
	#instVars : [
		'view',
		'interactionBuilder',
		'shapeBuilder',
		'exporter'
	],
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #hooks }
RTHTMLBuilder >> addCustomizations [
	"need to be implemented by subclass."
]

{ #category : #public }
RTHTMLBuilder >> addElementOn: anObject [
	| element |
	element := self elementOn: anObject.
	interactionBuilder setUpElements: element.
	view add: element.
	^ element
]

{ #category : #public }
RTHTMLBuilder >> cleanView [
	view edges copy do: #remove.
	view elements copy do: #remove.
]

{ #category : #hooks }
RTHTMLBuilder >> createInteractionBuilder [
	^ RTHTMLInteractionBuilder new
]

{ #category : #hooks }
RTHTMLBuilder >> createShapeBuilder [
	^ RTShapeBuilder new
]

{ #category : #hooks }
RTHTMLBuilder >> createView [
	^ RTView new
]

{ #category : #public }
RTHTMLBuilder >> edgeFrom: source to: target [ 
	| newEdge |
	newEdge := shapeBuilder edgeFrom: source to: target.
	view add: newEdge.
	^ newEdge
]

{ #category : #protected }
RTHTMLBuilder >> elementOn: anObject [
	^ shapeBuilder elementOn: anObject
]

{ #category : #protected }
RTHTMLBuilder >> elementsOn: collectionOfObjects [
	^ shapeBuilder elementsOn: collectionOfObjects
]

{ #category : #export }
RTHTMLBuilder >> export [
	exporter view: self view.
	self view canvas color: Color white.
	self addCustomizations.
	exporter exportToFile.
]

{ #category : #export }
RTHTMLBuilder >> exportWithTitle: aTitle [
	exporter view: self view.
	self view canvas color: Color white.
	self addCustomizations.
	exporter title: aTitle.
	exporter exportToFile.
]

{ #category : #export }
RTHTMLBuilder >> exportWithTitle: aTitle filename: aName [
	exporter view: self view.
	self view canvas color: Color white.
	self addCustomizations.
	exporter title: aTitle.
	exporter fileName: aName.
	exporter exportToFile.
]

{ #category : #initialization }
RTHTMLBuilder >> initialize [
	super initialize.
	view := self createView.
	shapeBuilder := self createShapeBuilder.
	interactionBuilder := self createInteractionBuilder.
	exporter := RTHTMLExporter new.
]

{ #category : #accessing }
RTHTMLBuilder >> interaction [
	^ interactionBuilder
]

{ #category : #accessing }
RTHTMLBuilder >> interactionBuilder: anRTHTMLInteractionBuilder [
	interactionBuilder := anRTHTMLInteractionBuilder
]

{ #category : #copying }
RTHTMLBuilder >> postCopy [
	super postCopy.
	shapeBuilder := shapeBuilder copy.
	interactionBuilder := interactionBuilder copy.
]

{ #category : #accessing }
RTHTMLBuilder >> shape [
	^ shapeBuilder
]

{ #category : #accessing }
RTHTMLBuilder >> shapeBuilder: anRTShapeBuilder [

	shapeBuilder := anRTShapeBuilder
]

{ #category : #accessing }
RTHTMLBuilder >> view [
	^ view
]

{ #category : #accessing }
RTHTMLBuilder >> view: aRTView [
	view := aRTView
]
