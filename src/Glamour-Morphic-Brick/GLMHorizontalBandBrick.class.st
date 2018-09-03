"
A GLMHorizontalBandBrick is a simple Brick with width and bounds to fit all subbricks.
Usually used within horizontal scroll panes
"
Class {
	#name : #GLMHorizontalBandBrick,
	#superclass : #GLMBrick,
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #'layout brick' }
GLMHorizontalBandBrick >> doLayout [
	
	self layoutChildren.

	self subbricks do: [ :each | each isBrick ifTrue: [ each doLayout ] ]
]

{ #category : #initialization }
GLMHorizontalBandBrick >> initialize [
	super initialize.
	
	self layoutPolicy: GLMBrickHorizontalFillLinearLayout new.
]

{ #category : #'layout brick' }
GLMHorizontalBandBrick >> layoutChildren [

	|mBounds mOwner|
	"most of the time you don't want to call this method manually"
	"nice example to check is GLMLabelBrick>>doLayout"
	
	mOwner := self owner ifNil: [ self ] ifNotNil: [ self owner ].
	mBounds := mOwner isBrick ifTrue: [ mOwner globalInnerBounds ] ifFalse: [ mOwner globalBounds ].
	
	^ self layoutPolicy layout: self in: mBounds.
]

{ #category : #geometry }
GLMHorizontalBandBrick >> width [
	|width|
	self widthBlock ifNotNil: [ ^ self widthBlock cull: self ].
		
	width := self layoutProperties horizontalPadding.
	self subbricks do: [ :each | width := width + each width + each layoutProperties horizontalMargin ].
	^ width
]
