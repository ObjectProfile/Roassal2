"
A RTEllipse is an ellipse. e.g., RTEllipse new width: 10; height: 20


| v |
v := RTView new.
v add: (RTEllipse new width: 10; height: 20) element.
v open
"
Class {
	#name : #RTEllipse,
	#superclass : #RTAbstractElementShape,
	#category : #'Roassal2-Core-Shapes'
}

{ #category : #visitor }
RTEllipse >> accept: aVisitor [
	aVisitor visitEllipse: self
]

{ #category : #accessing }
RTEllipse >> geometryFor: anElement [
	| rect e p |
	rect := anElement encompassingRectangle.
	e := rect extent / 2.
	p := anElement position.
	e = (0@0) ifTrue: [ ^ p asGPoint ].
	^ GEllipse 
		center: p asGPoint
		vertex: (p + (e x@ 0)) asGPoint
		coVertex: (p + (0@ e y)) asGPoint
]

{ #category : #initialization }
RTEllipse >> initialize [
	super initialize.
	color := self defaultColor.
	self borderWidth: self trachelShapeClass defaultStrokeWidth
]

{ #category : #hooks }
RTEllipse >> trachelShapeClass [
	^ TREllipseShape

]

{ #category : #rendering }
RTEllipse >> updateFor: anElement trachelShape: trachelShape [
	| ex rec |
	trachelShape isNil ifTrue: [ ^ self ].
	ex := (self widthFor: anElement) @ (self heightFor: anElement).
	rec := (anElement position - (ex / 2)) extent: ex.
	
	trachelShape 
		fromRectangle: rec color: (self colorFor: anElement);
		strokeWidth: (self borderWidthFor: anElement);
		strokePaint: (self borderColorFor: anElement);
		rotateByDegrees: (self rotationFor: anElement);
		scaleBy: (self scaleFor: anElement).
	^ trachelShape
	
]
