"
A RTScrollBarBasic is the classic scrollBar for moving the view in the width, with scalability. See comments in RTScrollBarBuilder

"
Class {
	#name : #RTScrollBarBasic,
	#superclass : #RTScrollBarBuilder,
	#category : #'Roassal2-Builder-ScrollBar'
}

{ #category : #'as yet unclassified' }
RTScrollBarBasic class >> fromBuilder: b [

	 ^ self new view: b view; objects: b objects; size: b sizeBlock; movable: b movable; fixedPosition: b fixedPositionBlock; scrollBarType: b scrollBarType; orientation: b orientation; barShape: b barShape; barSpecific: b barSpecific.
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> addAnimations [
	"add animations on the bar, to make the scroll bar movable or not etc.."
	| bar start stop surroundingRectangle margeRectangle |

	bar := self shapes last.
	start := self shapes first.
	stop := self shapes second.
	surroundingRectangle := self shapes third.
	margeRectangle := self shapes fourth.


	(self orientation = #horizontal) ifTrue: [ 
		bar when: TRMouseDragging do: [ :evt |
			
			(self view canvas camera encompassingRectangle containsPoint: (self view canvas camera position)) ifFalse: [ (self view canvas camera) translateTo:  ((self view canvas camera encompassingRectangle) pointNearestTo: (self view canvas camera position))  ].
			
			(margeRectangle includesPoint: (bar position + ((evt step x)@0))) & (surroundingRectangle includesPoint: (evt position x)@(bar position y)) ifTrue: [  
				bar translateBy: (evt step x)@0.
				self view canvas camera translateBy: (self translationHorizontal: evt).
				].
			self view signalUpdate.
			]
		].

	(self orientation = #vertical) ifTrue: [ 
		bar when: TRMouseDragging do: [ :evt |
			
			(self view canvas camera encompassingRectangle containsPoint: (self view canvas camera position)) ifFalse: [ (self view canvas camera) translateTo:  ((self view canvas camera encompassingRectangle) pointNearestTo: (self view canvas camera position))  ].
			
			(margeRectangle includesPoint: (bar position + (0@(evt step y)))) & (surroundingRectangle includesPoint: (bar position x)@(evt position y)) ifTrue: [  
				bar translateBy: 0@(evt step y).
				self view canvas camera translateBy: (self translationVertical: evt).
				].
			self view signalUpdate.
			]
		].
	
	(self movable = #isMovable) ifTrue: [
		surroundingRectangle when: TRMouseDragging do: [ :evt |
			self shapes do: [ :s | s translateBy: (evt step) ].
			self view signalUpdate.
			]
		].
	
	self view when: TRMouseDragging do: [ :evt | 
		| translation |

			(self orientation = #horizontal) ifTrue: [
				translation := (self reverseTranslationHorizontal: evt).
				].
			(self orientation = #vertical) ifTrue: [
				translation := (self reverseTranslationVertical: evt).
				].
			((margeRectangle includesPoint: (bar position + translation)) & ((self view canvas camera encompassingRectangleOf: self objects) containsPoint: (self view canvas camera position))) ifTrue: [ 
				shapes last translateBy: translation.
				self signalUpdate
				
			]. 
		].
	
	objects when: TRMouseDragging do: [ :evt |	self signalUpdate.].
	self view when: TRResizeCanvasEvent do: [ :evt | self signalUpdate].
	self view canvas camera addCallback: (TRCameraScaleCallback new block: [ self signalUpdate. ]).
	self view canvas camera addCallback: (TRTranslationCallback new block: [ self signalUpdate. ]).



	
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> defineShapes [
"define shapes if scrollBar is horizontal vertical..."
	| start stop bar surroundingRectangle margeRectangle |
	
	
	"set bar shape"	
	(self barShape = #aBox) ifTrue: [ bar := TRBoxShape new ] ifFalse: [ bar := TREllipseShape new ].
	
	"bar is the shape to drag and drop, start ad stop are made to show the border of scroll Bar"
	(self orientation = #horizontal) ifTrue: [ 
		
		bar height: self width; width: self barWidth; color: (Color lightGray);  position: self fixedPosition; strokePaint: nil.
		start := TRBoxShape new color: Color lightGray; height:self width; width:2; position: (self fixedPosition x - (self size / 2) + 1)@(self fixedPosition y); strokePaint: nil.
		stop := TRBoxShape new color: Color lightGray; height:self width; width:2; position: (self fixedPosition x + (self size / 2) - 1)@(self fixedPosition y); strokePaint: nil. 
		
		"This shape is the the fill of the scroll bar"
		surroundingRectangle := TRBoxShape new fromRectangle: (Rectangle origin: (start encompassingRectangle origin) corner:(stop encompassingRectangle corner)); color: (Color gray alpha: 0.1); strokePaint: nil.
		"the margeRectangle handle the width/2 of the bar"
		margeRectangle := TRBoxShape new fromRectangle: (Rectangle origin: (surroundingRectangle encompassingRectangle origin + ((bar width /2)@0))corner: (surroundingRectangle encompassingRectangle corner - ((bar width /2)@0))); color: (Color gray alpha:0); strokePaint: nil .

	].

(self orientation = #vertical) ifTrue: [ 
		
		bar height: self barHeight; width: self width; color: (Color lightGray);  position: self fixedPosition; strokePaint: nil.
		start := TRBoxShape new color: Color lightGray; width:self width; height:2; position: (self fixedPosition x )@(self fixedPosition y - (self size / 2) + 1); strokePaint: nil.
		stop := TRBoxShape new color: Color lightGray; width:self width; height:2; position: (self fixedPosition x )@(self fixedPosition y + (self size / 2) - 1); strokePaint: nil.
		
		"This shape is the the fill of the scroll bar"
		surroundingRectangle := TRBoxShape new fromRectangle: (Rectangle origin: (start encompassingRectangle origin) corner:(stop encompassingRectangle corner)); color: (Color gray alpha: 0.1); strokePaint: nil.

		"the margeRectangle handle the width/2 of the bar"
		margeRectangle := TRBoxShape new fromRectangle: (Rectangle origin: (surroundingRectangle encompassingRectangle origin + (0@(bar height /2)))corner: (surroundingRectangle encompassingRectangle corner - (0@(bar height /2)))); color: (Color gray alpha:0); strokePaint: nil.
	].

	
	
	self shapes add: start; add: stop; add: surroundingRectangle; add: margeRectangle; add: bar.
	
	
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> initialize [
	super initialize.
	self shapes: OrderedCollection new.
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> renderIn: aView [

	(self objects isNil) ifTrue:[self defaultObjects].
	self assert: (objects isNotEmpty).
	self defineShapes.
	self addShapesToView.
	self addAnimations.
	self signalUpdate.


	
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> reverseTranslationHorizontal: evt [
	| t |

	t := ((evt step x)  / ((self view canvas camera fromSpaceToPixelForRectangle: (self view canvas camera encompassingRectangleOf: self objects)) width )) * (self size - self shapes last width).
		
	^ (t negated)@0
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> reverseTranslationVertical: evt [
	| t |

	t := ((evt step y)  / ((self view canvas camera fromSpaceToPixelForRectangle: (self view canvas camera encompassingRectangleOf: self objects)) height)) * (self size - self shapes last height).
		
	^ 0@(t negated)
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> signalUpdatePosition [

	| pr pos|
	
	pos := self fixedPosition.
	
	(self movable = #isMovable) ifFalse: [ 
		(self orientation = #horizontal) ifTrue: [
		
				pr := ((self shapes last position x)-(self shapes third encompassingRectangle origin x)) / (self shapes third encompassingRectangle width) * self size.		
				
				self shapes third position: self fixedPosition.
				
				self shapes first position: (self fixedPosition x - (self size / 2) +1)@(self shapes third position y).
				self shapes second position: (self fixedPosition x + (self size / 2) -1)@(self shapes third position y).
				
				self shapes last position: (pr + (self shapes first encompassingRectangle origin x))@(self fixedPosition y).	
				
				
				].
			
			(self orientation = #vertical) ifTrue: [
				
				pr := ((self shapes last position y)-(self shapes third encompassingRectangle origin y)) / (self shapes third encompassingRectangle height) * self size.
								
				self shapes third position: self fixedPosition.
				
				self shapes first position: (self shapes third position x)@(self fixedPosition y - (self size / 2) +1).
				self shapes second position: (self shapes third position x)@(self fixedPosition y + (self size / 2) -1).
				
				self shapes last position: (self fixedPosition x)@(pr + (self shapes first encompassingRectangle origin y)).

			].
			
		self shapes fourth position: self fixedPosition.	
		].
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> signalUpdateSize [



	(self orientation = #horizontal) ifTrue: [

				self shapes third width: self size.
				self shapes first position: (self shapes third position x - (self size /2) +1)@(self shapes third position y).
				self shapes second position: (self shapes third position x + (self size /2) -1)@(self shapes third position y).
				self shapes fourth width: (self size - (self shapes last width)).		
				self shapes last width: self barWidth.
				
				((self shapes last position x - (self barWidth / 2)) < (self shapes first position x)) ifTrue: [ self shapes last translateTo: (self shapes first position x + (self barWidth / 2))@(self shapes first position y)].
				((self shapes last position x + (self barWidth / 2)) > (self shapes second position x)) ifTrue: [ self shapes last translateTo: (self shapes second position x - (self barWidth / 2))@(self shapes first position  y)].
				
				].
			(self orientation = #vertical) ifTrue: [
				
				self shapes third height: self size.
				self shapes first position: (self shapes third position x)@(self shapes third position y - (self size / 2) +1).
				self shapes second position: (self shapes third position x)@(self shapes third position y + (self size / 2) -1).
				self shapes fourth height: (self size - (self shapes last height)).
				self shapes last height: self barHeight.
				
				((self shapes last position y - (self barHeight / 2)) < (self shapes first position y)) ifTrue: [ self shapes last translateTo: (self shapes first position  x)@(self shapes first position y + (self barHeight / 2))].
				((self shapes last position y + (self barHeight / 2)) > (self shapes second position y)) ifTrue: [ self shapes last translateTo: (self shapes first position  x)@(self shapes second position y - (self barHeight / 2))].
				].
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> translationHorizontal: evt [
	| t |

	t := ((evt step x) / (self size  - self shapes last width)) * (((self view canvas camera fromSpaceToPixelForRectangle: (self view canvas camera encompassingRectangleOf: self objects)) width) / self view canvas camera scale).
	
	^ t@0
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> translationVertical: evt [
	| t |

	t := ((evt step y) / (self size  - self shapes last height)) * (((self view canvas camera fromSpaceToPixelForRectangle: (self view canvas camera encompassingRectangleOf: self objects)) height) / self view canvas camera scale).
	
	^ 0@t
]
