"
A RTScrollBarBuilder is a scroll bar that you can add to navigate in your view. More than a Draggable view, it allows to keep a mark about your position in the view and it scale for large views. 

It can be static, movable, in one or two dimentions, navigation using scrollBarType: #isBasic,  #isPad then #isStatic or #isMovable
aving an orientation #vertical or #horizontal.

the default configuration is #isBasic and #isStatic,

the bar shape is defined by #barShape: <#aBox or default value #anEllipse>

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
		'orientation',
		'width',
		'shapes',
		'barShape'
	],
	#category : #'Roassal2-Builder-ScrollBar'
}

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> barShape [
	^ barShape
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> barShape: aSymbol [
	barShape := aSymbol
]

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
"all default values of scroll bar"
	self scrollBarType: #isBasic. 
	self movable: #isMovable.
	self barShape: #anEllipse.
	self fixedPosition:  (self view canvas extent x*3/4)@(self view canvas extent y *3/4).
	self size: 200.
	self width: 20.
	self orientation: #horizontal	
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> fixedPosition [
"get the value of the initial fixed Position, in case of block, evaluation of self"
(self fixedPositionBlock isBlock ) ifTrue: [^ fixedPosition cull: self ]
ifFalse: [ ^ fixedPosition]. 
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> fixedPosition: aPositionOrABlock [
"set the initial position of the scroll bar"
	fixedPosition:= aPositionOrABlock 
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> fixedPositionBlock [
"get the block of the initial fixed Position"
	^ fixedPosition
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> initialize [
	super initialize.
	self configureView: view.
	self defaultScrollBar.

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
	
	
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> orientation [
	^ orientation 
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> orientation: aSymbol [
"set orientation of scroll bar, #horizontal or #vertical"
	orientation := aSymbol.
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
RTScrollBarBuilder >> shapes [
"the shapes used to build the scroll bar"
	^ shapes
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> shapes: aCollection [
"the shapes used to build the scroll bar"
	shapes := aCollection
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> size [
"get the value of the size, in case of block, evaluation of self"
(self sizeBlock isBlock ) ifTrue: [ ^ size cull: self ]
ifFalse: [ ^ size].  
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> size: aSizeOraBlock [
"set the size of scroll bar, it's length"
	size:= aSizeOraBlock.
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> sizeBlock [
"SizeBlock allows to get the block and not the result of the evaluation of the size block on size, obtained by self size"
	^ size.  
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> width [
	^ width
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> width: aSize [
"set width of the scroll bar"
	width := aSize
]
