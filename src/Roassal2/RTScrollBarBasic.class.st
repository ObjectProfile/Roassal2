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

	 ^ self new view: b view; encompassingRectangle: b encompassingRectangle; encompassingRectangleFromSpaceToPixel: b encompassingRectangleFromSpaceToPixel; size: b sizeBlock; movable: b movable; fixedPosition: b fixedPositionBlock; scrollBarType: b scrollBarType; orientation: b orientation; barShape: b barShape; barSpecific: b barSpecific.
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> addAnimations [
	"add animations on the bar, to make the scroll bar movable or not etc.."
	| bar start stop surroundingRectangle margeRectangle |

	bar := self shapes bar.
	start := self shapes start.
	stop := self shapes stop.
	surroundingRectangle := self shapes surroundingRectangle.
	margeRectangle := self shapes margeRectangle.


	(self orientation = #horizontal) ifTrue: [ 
		bar when: TRMouseDragging do: [ :evt |
			
			(self encompassingRectangle containsPoint: (self view canvas camera position)) ifFalse: [ (self view canvas camera) translateTo:  ((self encompassingRectangle) pointNearestTo: (self view canvas camera position))  ].
			
			(margeRectangle includesPoint: (bar position + ((evt step x)@0))) & (surroundingRectangle includesPoint: (evt position x)@(bar position y)) ifTrue: [  
				bar translateBy: (evt step x)@0.
				self view canvas camera translateBy: (self translationHorizontal: evt).
				].
			self view signalUpdate.
			]
		].

	(self orientation = #vertical) ifTrue: [ 
		bar when: TRMouseDragging do: [ :evt |
			
			(self encompassingRectangle containsPoint: (self view canvas camera position)) ifFalse: [ (self view canvas camera) translateTo:  ((self encompassingRectangle) pointNearestTo: (self view canvas camera position))  ].
			
			(margeRectangle includesPoint: (bar position + (0@(evt step y)))) & (surroundingRectangle includesPoint: (bar position x)@(evt position y)) ifTrue: [  
				bar translateBy: 0@(evt step y).
				self view canvas camera translateBy: (self translationVertical: evt).
				].
			self view signalUpdate.
			]
		].
	
	(self movable = #isMovable) ifTrue: [
		surroundingRectangle when: TRMouseDragging do: [ :evt |
			self shapes collection do: [ :s | s translateBy: (evt step) ].
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
			((margeRectangle includesPoint: (bar position + translation))) ifTrue: [ 
				shapes bar translateBy: translation.
				self view signalUpdate
			]. 
		].
	
	self view elements do: [:e | e addCallback: (TRTranslationCallback new block: [
			self encompassingRectangleUpdate. self encompassingRectangleFromSpaceToPixelUpdate. self signalUpdate.])
		].
	
	self view when: TRResizeCanvasEvent do: [ :evt | self signalUpdate].
	
	self view canvas camera addCallback: (TRCameraScaleCallback new block: [ self encompassingRectangleFromSpaceToPixelUpdate. self signalUpdate. ]).



	
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

	self shapes start: start; stop: stop; surroundingRectangle: surroundingRectangle; margeRectangle: margeRectangle; bar: bar.
	
	
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> initialize [
	super initialize.
	self shapes: RTScrollBarShapes new.
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> positionOnBorderHorizontal [
	((self shapes bar position x - (self barWidth / 2)) < (self shapes start position x)) ifTrue: [ self shapes bar translateTo: (self shapes start position x + (self barWidth / 2))@(self shapes start position y)].
	((self shapes bar position x + (self barWidth / 2)) > (self shapes stop position x)) ifTrue: [ self shapes bar translateTo: (self shapes stop position x - (self barWidth / 2))@(self shapes start position  y)].
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> positionOnBorderVertical [
	((self shapes bar position y - (self barHeight / 2)) < (self shapes start position y)) ifTrue: [ self shapes bar translateTo: (self shapes start position  x)@(self shapes start position y + (self barHeight / 2))].
	((self shapes bar position y + (self barHeight / 2)) > (self shapes stop position y)) ifTrue: [ self shapes bar translateTo: (self shapes start position  x)@(self shapes stop position y - (self barHeight / 2))].

]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> renderIn: aView [

	(self view elements isEmpty) ifTrue: [self defaultEncompassingRectangle] ifFalse: [ self encompassingRectangleUpdate ].
	self encompassingRectangleFromSpaceToPixelUpdate.

	self defineShapes.
	self addShapesToView.
	self addAnimations.
	self signalUpdate.


	
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> reverseTranslationHorizontal: evt [
	| t |

	t := ((evt step x)  / (self encompassingRectangleFromSpaceToPixel width )) * (self size - self shapes bar width).
		
	^ (t negated)@0
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> reverseTranslationVertical: evt [
	| t |

	t := ((evt step y)  / (self encompassingRectangleFromSpaceToPixel height)) * (self size - self shapes bar height).
		
	^ 0@(t negated)
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> signalUpdatePosition [

	| pr pos sizeNow |
	
	pos := self fixedPosition.
	sizeNow := self size.
		
			(self orientation = #horizontal) ifTrue: [
				
				pr := (((self view canvas camera position x) - (self encompassingRectangle origin x)) / (self encompassingRectangle width)) * sizeNow.
	
				self shapes surroundingRectangle position: pos.
				
				self shapes start position: (pos x - (sizeNow / 2) +1)@(self shapes surroundingRectangle position y).
				self shapes stop position: (pos x + (sizeNow / 2) -1)@(self shapes surroundingRectangle position y).
				
				self shapes bar position: (pr + (self shapes start position x - 1))@(pos y).	
				
				].
			
			(self orientation = #vertical) ifTrue: [
					
				pr := (((0@(self view canvas camera position y)) dist: (0@(self encompassingRectangle origin y))) / (self encompassingRectangle height)) * (self shapes surroundingRectangle height).
								
				self shapes surroundingRectangle position: pos.
				
				self shapes start position: (self shapes surroundingRectangle position x)@(pos y - (sizeNow / 2) +1).
				self shapes stop position: (self shapes surroundingRectangle position x)@(pos y + (sizeNow / 2) -1).
				
				self shapes bar position: (pos x)@(pr + (self shapes start position y - 1)).

			].
			
		self shapes margeRectangle position: pos.	
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> signalUpdateSize [
	| sizeNow |

	sizeNow := self size.
	(self orientation = #horizontal) ifTrue: [

				self shapes surroundingRectangle width: sizeNow.
				self shapes start position: (self shapes surroundingRectangle position x - (sizeNow /2) +1)@(self shapes surroundingRectangle position y).
				self shapes stop position: (self shapes surroundingRectangle position x + (sizeNow /2) -1)@(self shapes surroundingRectangle position y).
				self shapes margeRectangle width: (sizeNow - self barWidth).		
				self shapes bar width: self barWidth.
				
				self positionOnBorderHorizontal.
				
				].
	(self orientation = #vertical) ifTrue: [
				
				self shapes surroundingRectangle height: sizeNow.
				self shapes start position: (self shapes surroundingRectangle position x)@(self shapes surroundingRectangle position y - (sizeNow / 2) +1).
				self shapes stop position: (self shapes surroundingRectangle position x)@(self shapes surroundingRectangle position y + (sizeNow / 2) -1).
				self shapes margeRectangle height: (sizeNow - (self barHeight)).
				self shapes bar height: self barHeight.
				
				self positionOnBorderVertical.
				
				].
				
				
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> translationHorizontal: evt [
	| t |

	t := ((evt step x) / (self size  - self shapes bar width)) * ((self encompassingRectangleFromSpaceToPixel width) / self view canvas camera scale).
	
	^ t@0
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> translationVertical: evt [
	| t |

	t := ((evt step y) / (self size  - self shapes bar height)) * ((self encompassingRectangleFromSpaceToPixel height) / self view canvas camera scale).
	
	^ 0@t
]
