"
A RTScrollBarBuilder is a scroll bar that you can add to navigate in your view. More than a Draggable view, it allows to keep a mark about your position in the view and it scale for large views. 

It can be static, movable, in one or two dimentions, navigation using scrollBarType: #isBasic,  #isPad then #isStatic or #isMovable
aving an orientation #vertical or #horizontal.

the default configuration is #isBasic and #isStatic,

the bar shape is defined by #barShape: <#aBox or default value #anEllipse>
the bar can have a specificity like #scalable, so it give an idea of the size of the view

Size or fixedPosition can be defined as blocks


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
		'barShape',
		'barSpecific',
		'objectsRectangle',
		'objectsFromSpaceToPixelForRectangle'
	],
	#category : #'Roassal2-Builder-ScrollBar'
}

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> addObject: anElement [
	"Add a new element to react with the scrollBar, for example in RTExploraBuilder"
	self objects add: anElement.
	anElement addCallback: (TRTranslationCallback new block: [ self objectsRectangleUpdate. self objectsFromSpaceToPixelForRectangleUpdate. self signalUpdate.]).
	
	
	
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> addObjects: anRTGroup [
	"Add new elements to react with the scrollBar"
	self objects addAll: anRTGroup.
	anRTGroup do: [:e | e addCallback: (TRTranslationCallback new block: [ self objectsRectangleUpdate. self objectsFromSpaceToPixelForRectangleUpdate. self signalUpdate.])].
	
	
	
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> addShapesToView [
	
	self shapes collection do: [ :s | self view canvas addFixedShape: s ].
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> barHeight [
 "This method is used to get the height of the bar from a scroll bar builder only, depending on the specificity of the bar"
	(self barSpecific = #scalable) ifTrue: [
		| max min s |
		
		max := self size -50.
		min := 10.
			
		s := (self size * (self view canvas extent y) / (self objectsFromSpaceToPixelForRectangle height) / self view canvas camera scale).
		
		(s > max) ifTrue: [ ^max ].
		(s < min) ifTrue: [ ^min ].
		^ s.
		
		] ifFalse: [ ^ self width]
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> barShape [
	^ barShape
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> barShape: aSymbol [
	barShape := aSymbol
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> barSpecific [
	^ barSpecific 
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> barSpecific: aSymbol [
	barSpecific := aSymbol 
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> barWidth [
 "This method is used to get the width of the bar from a scroll bar builder only, depending on the specificity of the bar"
	(self barSpecific = #scalable) ifTrue: [
		| max min s |
		
		max := self size -50.
		min := 10.
		
		s := (self size * (self view canvas extent x) / (self objectsFromSpaceToPixelForRectangle width) / self view canvas camera scale).
		
		(s > max) ifTrue: [ ^max ].
		(s < min) ifTrue: [ ^min ].
		^ s.
		] ifFalse: [ ^ self width]
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> configureView: aView [
	aView.
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> defaultObjects [
	self objects: self view elements.
	(self objects isEmpty) ifTrue: [ 
		self objectsRectangle: (Rectangle origin: 0@0 corner:10@10). 
		self objectsFromSpaceToPixelForRectangle: (self view canvas camera fromSpaceToPixelForRectangle: (self objectsRectangle))
		]
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> defaultScrollBar [
"all default values of scroll bar"
	self scrollBarType: #isBasic. 
	self movable: #isMovable.
	self barShape: #anEllipse.
	self fixedPosition:  [ :v | (v view canvas extent x /2)@(v view canvas extent y  * 3 / 4)].
	self size: 200.
	self width: 20.
	self orientation: #horizontal	
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> fixedPosition [
"get the value of the initial fixed Position, in case of block, evaluation of self"
	^ (fixedPosition rtValue: self).
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> fixedPosition: aPositionOrABlock [
"set the initial position of the scroll bar, if a block, the block will be evaluated with 'cull self'. For example a block [:v | v view canvas extent] will set the position to canvas extent, just as [<myBuilder> view canvas extent]. If you want the scrollBar to be fully free and movable without reset position, set a point for fixedPosition."
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
	self objectsRectangle: (self view canvas camera encompassingRectangleOf: self objects).
	self objectsFromSpaceToPixelForRectangle: (self view canvas camera fromSpaceToPixelForRectangle: (self objectsRectangle))
	
	
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> objectsFromSpaceToPixelForRectangle [
	^ objectsFromSpaceToPixelForRectangle 
	
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> objectsFromSpaceToPixelForRectangle: aRectangle [
	"encompassing rectangles of objects in the view, taking care of scale"
	objectsFromSpaceToPixelForRectangle := aRectangle
	
	
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> objectsFromSpaceToPixelForRectangleUpdate [
	"used by the full signalUpdate"
	self objectsFromSpaceToPixelForRectangle: (self view canvas camera fromSpaceToPixelForRectangle: (self objectsRectangle))
	
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> objectsRectangle [
	"encompassing rectangles of objects in the view"
	^ objectsRectangle
	
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> objectsRectangle: aRectangle [
	"encompassing rectangles of objects in the view"
	objectsRectangle := aRectangle
	
	
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> objectsRectangleUpdate [
	"used by the full signalUpdate"
	self objectsRectangle: (self view canvas camera encompassingRectangleOf: self objects).
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
RTScrollBarBuilder >> shapes: aRTScrollBarShapes [
"the shapes used to build the scroll bar"
	shapes := aRTScrollBarShapes
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> signalUpdate [
	
	"this method is used to increase the size of the shapes composing the scroll bar when the size is defined by a Block, for example to follow the size of the windows
	Or if the position is fixed on the border on the widows, the scroll bar should follow the windows border at signal updates"

	self assert: (self shapes isNotNil).

	(self shapes collection) ifNotEmpty: [ 

		(self fixedPositionBlock isBlock) ifTrue: [ 
			self signalUpdatePosition.				
			].
	
		(self sizeBlock isBlock) ifTrue: [  
			self signalUpdateSize.
			] ifFalse: [ 
				(self orientation = #horizontal) ifTrue: [
						self positionOnBorderHorizontal.
					] ifFalse: [ 
						self positionOnBorderVertical.
					 ]
				]
			 ].
	self view signalUpdate. 
	
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> size [
"get the value of the size, in case of block, evaluation of self"
	^ size rtValue: self 
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilder >> size: aSizeOraBlock [
"set the size of scroll bar, it's length. If a block, the block will be evaluated with 'cull self'. For example a block [ :v | v view canvas extent x] will set the size to canvas width, just as [<myBuilder> view canvas extent x]"
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
