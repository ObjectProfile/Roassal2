"
A RTScrollBarBasic is the classic scrollBar for moving the view in the width, with scalability

"
Class {
	#name : #RTScrollBarBasic,
	#superclass : #RTScrollBarBuilder,
	#category : #'Roassal2-Builder-ScrollBar'
}

{ #category : #'as yet unclassified' }
RTScrollBarBasic class >> fromBuilder: b [

	 ^ self new view: b view; objects: b objects; size: b size; movable: b movable; fixedPosition: b fixedPosition; elementsRectangleBounds: b elementsRectangleBounds; scrollBarType: b scrollBarType.
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> addShapes: aView [
	| start stop bar surroundingRectangle |
	
	"bar is the shape to drag and drop"
	bar := TREllipseShape new size: 20; color: (Color lightGray);  position: self fixedPosition; strokePaint: nil.
	start := TRBoxShape new color: Color lightGray; height:20; width:2; position: (self fixedPosition x - (self size / 2))@(self fixedPosition y); strokePaint: nil.
	stop := TRBoxShape new color: Color lightGray; height:20; width:2; position: (self fixedPosition x + (self size / 2))@(self fixedPosition y); strokePaint: nil. 

	surroundingRectangle := TRBoxShape new fromRectangle: (Rectangle origin: (start encompassingRectangle origin) corner:(stop encompassingRectangle corner)); color: (Color gray alpha: 0.1); strokePaint: nil.
	
	aView canvas addFixedShape: surroundingRectangle; addFixedShape: start; addFixedShape: stop; addFixedShape: bar.
	
	bar when: TRMouseDragging do: [ :evt |
		"conditions for a classic scrollbar"
		(((bar position x) + (evt step x) + (bar width /2) < (stop position x)) & ((bar position x) + (evt step x) - (bar width /2) > (start position x))) & 
		(start position x < evt position x) & 
		(stop position x > evt position x) ifTrue: [  
			bar translateBy: (evt step x)@0.
			aView canvas camera translateBy: (self translation: evt).
			].
		aView signalUpdate.
		].
	
	(self movable = #isMovable) ifTrue: [
		surroundingRectangle when: TRMouseDragging do: [ :evt |
			bar translateBy: (evt step).
			surroundingRectangle translateBy: (evt step).
			start translateBy: (evt step).
			stop translateBy: (evt step).
			aView signalUpdate.
			]
		].

]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> initialize [
	super initialize.
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> renderIn: aView [

(self objects isNil) ifTrue:[self defaultObjects].
	self assert: (objects isNotEmpty).
	
	self addShapes: aView.




	
]

{ #category : #'as yet unclassified' }
RTScrollBarBasic >> translation: evt [
	| t |

	t := (evt step x ) / self size * self elementsRectangleBounds width.
	
	^ t@0
]
