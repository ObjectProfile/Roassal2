Class {
	#name : #TRAbstractMouseEvent,
	#superclass : #TRShapeEvent,
	#category : #'Trachel-Core'
}

{ #category : #testing }
TRAbstractMouseEvent >> isPositionAboveShape [
	^ shape encompassingRectangle containsPoint: self positionFromCamera
]
