Class {
	#name : #TRAbstractMouseEvent,
	#superclass : #TRShapeEvent,
	#category : #'Trachel-Core'
}

{ #category : #'as yet unclassified' }
TRAbstractMouseEvent >> isPositionAboveShape [
	^ shape encompassingRectangle containsPoint: self positionFromCamera
]
