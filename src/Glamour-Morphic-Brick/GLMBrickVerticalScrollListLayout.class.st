Class {
	#name : #GLMBrickVerticalScrollListLayout,
	#superclass : #GLMBrickVerticalFillLinearLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #'as yet unclassified' }
GLMBrickVerticalScrollListLayout >> layoutInjection: aBrick withArguments: arguments [

	^ aBrick hasSubbricks
		ifFalse: [ 0 ]
		ifTrue: [ aBrick firstSubbrick brickBounds top ]
]
