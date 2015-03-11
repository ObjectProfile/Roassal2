"
A RTScrollPad is a scrollable pad to drag the view in 2D with scalability. See comments in RTScrollBarBuilder

"
Class {
	#name : #RTScrollPad,
	#superclass : #RTScrollBarBuilder,
	#category : #'Roassal2-Builder-ScrollBar'
}

{ #category : #'as yet unclassified' }
RTScrollPad class >> fromBuilder: b [

	 ^ self new view: b view; objects: b objects; size: b sizeBlock; movable: b movable; fixedPosition: b fixedPositionBlock; scrollBarType: b scrollBarType; barShape: b barShape.
]

{ #category : #'as yet unclassified' }
RTScrollPad >> addAnimations [

	self shapes last when: TRMouseDragging do: [ :evt |
		(self shapes second includesPoint: (self shapes last position + evt step)) & (self shapes first includesPoint: evt position) ifTrue: [  
			self shapes last translateBy: evt step.
			self view canvas camera translateBy: (self translation: evt).
		].
		self view signalUpdate.
		].
	
	(self movable = #isMovable) ifTrue: [
		self shapes first when: TRMouseDragging do: [ :evt |
			self shapes do: [ :s | s translateBy: (evt step) ].
			self view signalUpdate.
			]
		].
		
		self view when: TRResizeCanvasEvent do: [ :evt | self signalUpdate].


	
]

{ #category : #'as yet unclassified' }
RTScrollPad >> defineShapes [
	|  bar surroundingRectangle margeRectangle |
	
	
	"set bar shape"	
	(self barShape = #aBox) ifTrue: [ bar := TRBoxShape new ] ifFalse: [ bar := TREllipseShape new ].
	
	"bar is the shape to drag and drop"
	bar size: self width; color: (Color lightGray);  position: self fixedPosition; strokePaint: nil.
		
	"This shape is the the fill of the scroll pad"
	surroundingRectangle := TRBoxShape new fromRectangle: (Rectangle origin: (self fixedPosition x - (self size / 2)) @ (self fixedPosition y - (self size / 2)) corner:(self fixedPosition x + (self size / 2)) @ (self fixedPosition y + (self size / 2))); color: (Color gray alpha: 0.1); strokePaint: nil.
	
	"the margeRectangle handle the width/2 of the bar"
	margeRectangle := TRBoxShape new fromRectangle: (Rectangle origin: (surroundingRectangle encompassingRectangle origin + (bar width /2))corner: (surroundingRectangle encompassingRectangle corner - (bar width /2))); color: (Color gray alpha:0); strokePaint: nil .

	self shapes add: surroundingRectangle; add: margeRectangle; add: bar.
	
	
]

{ #category : #'as yet unclassified' }
RTScrollPad >> initialize [
	super initialize.
	self shapes: OrderedCollection new.
]

{ #category : #'as yet unclassified' }
RTScrollPad >> renderIn: aView [
	
	(self objects isNil) ifTrue:[self defaultObjects].
	self assert: (objects isNotEmpty).
	self defineShapes.
	self addShapesToView.
	self addAnimations.





	
]

{ #category : #'as yet unclassified' }
RTScrollPad >> signalUpdatePosition [

	| prx pry  org|
		
	prx := ((self shapes last position x)-(self shapes first encompassingRectangle origin x)) / (self shapes first encompassingRectangle width) * self size.
	pry := ((self shapes last position y)-(self shapes first encompassingRectangle origin y)) / (self shapes first encompassingRectangle height) * self size.
				
	self shapes first position: self fixedPosition.
	self shapes second position: self fixedPosition.
	
	org := (self fixedPosition x - (self size / 2) )@(self fixedPosition y - (self size / 2) ).
				
	self shapes last position: (prx + org x)@((pry + org y)).
]

{ #category : #'as yet unclassified' }
RTScrollPad >> signalUpdateSize [
				
			self shapes first width: self size.
			self shapes first height: self size.
			self shapes second width: (self size - (self shapes last width)).
			self shapes second height: (self size - (self shapes last height))				
			
	
]

{ #category : #'as yet unclassified' }
RTScrollPad >> translation: evt [
	| tx ty |
	
	tx := (evt step x) / self size * ((self view canvas camera fromSpaceToPixelForRectangle: (self view canvas camera encompassingRectangleOf: self objects)) width) / self view canvas camera scale.
	ty := (evt step y) / self size * ((self view canvas camera fromSpaceToPixelForRectangle: (self view canvas camera encompassingRectangleOf: self objects)) height) / self view canvas camera scale.
	
	^ tx@ty
]
