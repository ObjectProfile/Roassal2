Class {
	#name : #TRAbstractMouseEvent,
	#superclass : #TRShapeEvent,
	#category : #'Trachel-Events'
}

{ #category : #testing }
TRAbstractMouseEvent >> isPositionAboveShape [
	^ shape encompassingRectangle containsPoint: self positionFromCamera
]
