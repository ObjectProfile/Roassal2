"
A GLMBrickHorizontalFillLinearLayout is Linear layout, where all Bricks are being positioned horizontally in one line. The size of Bricks depends only from each Brick's extent. If any Bricks goes outside of the parent with this layout, outside part will not be drawn. The height of all elements in this layout is the same
"
Class {
	#name : #GLMBrickHorizontalFillLinearLayout,
	#superclass : #GLMBrickHorizontalLinearLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #examples }
GLMBrickHorizontalFillLinearLayout class >> example [
	"self example"
	super example
]

{ #category : #layouting }
GLMBrickHorizontalFillLinearLayout >> extentOf: aBrick in: owner withArguments: aHashTable [
	
	^ (self originalWidthOf: aBrick)@(owner innerBounds height - aBrick layoutProperties verticalMargin)
]
