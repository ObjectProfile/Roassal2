"
A RTScrollPad is a scrollable pad to drag the view in 2D with scalability.

"
Class {
	#name : #RTScrollPad,
	#superclass : #RTScrollBarBuilder,
	#category : #'Roassal2-Builder-ScrollBar'
}

{ #category : #'as yet unclassified' }
RTScrollPad class >> fromBuilder: b [

	 ^ self new view: b view; objects: b objects; size: b size; movable: b movable; fixedPosition: b fixedPosition; elementsRectangleBounds: b elementsRectangleBounds; scrollBarType: b scrollBarType.
]

{ #category : #'as yet unclassified' }
RTScrollPad >> addShapes: aView [
	| bar surroundingRectangle margeRectangle  |
	
	"bar is the shape to drag and drop"
	bar := TREllipseShape new size: 20; color: (Color lightGray);  position: self fixedPosition; strokePaint: nil.

	surroundingRectangle := TRBoxShape new fromRectangle: (Rectangle origin: (bar position x - (self size / 2)) @ (bar position y - (self size / 2)) corner:(bar position x + (self size / 2)) @ (bar position y + (self size / 2))); color: (Color gray alpha: 0.1); strokePaint: nil.
	
	aView canvas addFixedShape: surroundingRectangle; addFixedShape: bar.
	
	"the margeRectangle handle the width/2 of the bar"
	margeRectangle := TRBoxShape new fromRectangle: (Rectangle origin: surroundingRectangle encompassingRectangle origin + (bar width /2) corner: surroundingRectangle encompassingRectangle corner - (bar width /2)).
	
	bar when: TRMouseDragging do: [ :evt |
		(margeRectangle includesPoint: (bar position + evt step)) & (surroundingRectangle includesPoint: evt position) ifTrue: [  
			bar translateBy: evt step.
			aView canvas camera translateBy: (self translation: evt).
		].
		aView signalUpdate.
		].
	
	(self movable = #isMovable) ifTrue: [
		surroundingRectangle when: TRMouseDragging do: [ :evt |
			bar translateBy: (evt step).
			surroundingRectangle translateBy: (evt step).
			margeRectangle translateBy: (evt step).
			aView signalUpdate.
			]
		].

]

{ #category : #'as yet unclassified' }
RTScrollPad >> initialize [
	super initialize.
]

{ #category : #'as yet unclassified' }
RTScrollPad >> renderIn: aView [
	
	(self objects isNil) ifTrue:[self defaultObjects].
	self assert: (objects isNotEmpty).
	self addShapes: aView.




	
]

{ #category : #'as yet unclassified' }
RTScrollPad >> translation: evt [
	| tx ty |
	
	tx := (evt step x) / self size * self elementsRectangleBounds width.
	ty := (evt step y) / self size * self elementsRectangleBounds height.
	
	^ tx@ty
]
