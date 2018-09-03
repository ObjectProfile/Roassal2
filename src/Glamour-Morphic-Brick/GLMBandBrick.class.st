"
A GLMBandBrick is a simple Brick with height and bounds to fit all subbricks.
Usually used within scroll panes

"
Class {
	#name : #GLMBandBrick,
	#superclass : #GLMBrick,
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #'layout brick' }
GLMBandBrick >> doLayout [
	
	self layoutChildren.

	self subbricks do: [ :each | each isBrick ifTrue: [ each doLayout ] ]
]

{ #category : #initialization }
GLMBandBrick >> initialize [
	super initialize.
	
	self layoutPolicy: GLMBrickVerticalFillLinearLayout new.
	self layoutProperties vShrinkWrap
]

{ #category : #'layout brick' }
GLMBandBrick >> layoutChildren [
	|mBounds mOwner|
	"most of the time you don't want to call this method manually"
	"nice example to check is GLMLabelBrick>>doLayout"
	
	mOwner := self owner ifNil: [ self ] ifNotNil: [ self owner ].
	mBounds := mOwner isBrick ifTrue: [ mOwner globalInnerBounds ] ifFalse: [ mOwner globalBounds ].
	
	^ self layoutPolicy layout: self in: mBounds.
]
