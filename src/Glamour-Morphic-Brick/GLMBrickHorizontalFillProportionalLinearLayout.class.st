"
A GLMBrickHorizontalFillProportionalLinearLayout is a slight modification of ProportionalLayout but all elements have the same height and it is the same as parent's
"
Class {
	#name : #GLMBrickHorizontalFillProportionalLinearLayout,
	#superclass : #GLMBrickHorizontalProportionalLinearLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #examples }
GLMBrickHorizontalFillProportionalLinearLayout class >> example [
	"self example"
	super example
]

{ #category : #examples }
GLMBrickHorizontalFillProportionalLinearLayout class >> example2 [
	"self example"
	super example2
]

{ #category : #layouting }
GLMBrickHorizontalFillProportionalLinearLayout >> extentOf: aBrick in: owner withArguments: aHashTable [
	|extent|
	extent := super extentOf: aBrick in: owner withArguments: aHashTable.
	^ (extent x)@(owner innerBounds height - aBrick layoutProperties verticalMargin)
]
