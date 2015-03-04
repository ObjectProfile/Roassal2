"
A RTScrollBarBuilder is a scroll bar that you can add to navigate in your view. More than a Draggable view, it allows to keep a mark about your position in the view and it scale for large views. 

It can be static, movable, in one or two dimentions, navigation using scrollBarType: #isBasic,  #isPad then #isStatic or #isMovable.

the default configuration is #isBasic and #isStatic

Instance Variables
	objects:		<Object>
	scrollBarType:		<Object>
	size:		<Object>

objects
	- xxxxx

scrollBarType
	- xxxxx

size
	- xxxxx

"
Class {
	#name : #RTScrollBarBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'objects',
		'fixedPosition',
		'size',
		'scrollBarType',
		'movable',
		'elementsRectangleBounds'
	],
	#category : #'Roassal2-Builder-ScrollBar'
}

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> configureView: aView [
	aView.
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> defaultObjects [
	self objects: self view elements.
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> defaultScrollBar [
	self scrollBarType: #isBasic. 
	self movable: #isMovable.	
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> defaultSizeAndPosition [

	self fixedPosition:  (self view canvas extent x*3/4)@(self view canvas extent y *3/4).
	self size: 200.
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> elementsRectangleBounds [
	^ elementsRectangleBounds
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> elementsRectangleBounds: aRectangle [
	elementsRectangleBounds := aRectangle
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> fixedPosition [
	^ fixedPosition.
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> fixedPosition: aPosition [
	fixedPosition:= aPosition
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> initialize [
	super initialize.
	self configureView: view.
	self defaultScrollBar.
	self defaultSizeAndPosition.

]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> movable [
	^ movable
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> movable: aSymbol [
	movable := aSymbol
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> objects [
	^ objects
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> objects: anRTGroup [
	"can be specified if you don't want all the elements of the view to move"
	objects := anRTGroup.
	self setElementsBounds.
	
	
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> renderIn: aView [

	(self objects isNil) ifTrue:[self defaultObjects].
	self assert: (objects isNotEmpty).
	
	(self scrollBarType = #isBasic) ifTrue: [ 
		self becomeForward: (RTScrollBarBasic fromBuilder: self).
		self build.
		 ].
	
	(self scrollBarType = #isPad) ifTrue: [ 
		self becomeForward: (RTScrollPad fromBuilder: self).
		self build.
		 ].
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> scrollBarType [
	^ scrollBarType. 	
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> scrollBarType: aSymbol [
	scrollBarType := aSymbol. 	
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> setElementsBounds [
	| minX maxX minY maxY |
	"set a Rectangle that will include the objects sizes and positions. This rectangle will be used by the scrollBar to scale and normalize"
	
	minX := (self objects collect: [:o | (o position x) - (o width /2 )]) min.
	maxX := (self objects collect: [:o | (o position x) + (o width /2 )]) max.
	
	minY := (self objects collect: [:o | (o position y) - (o height /2 )]) min.
	maxY := (self objects collect: [:o | (o position y) + (o height /2 )]) max.
	
	self elementsRectangleBounds: (Rectangle origin: minX@minY corner:maxX@maxY).
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> size [
	^ size.
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> size: aSize [
	size:= aSize.
]
