"
A GLMBrickVerticalFillProportionalLinearLayout is a slight modification of VerticalProportionalLayout but all elements have the same width and it is the same as parent's
"
Class {
	#name : #GLMBrickVerticalFillProportionalLinearLayout,
	#superclass : #GLMBrickVerticalProportionalLinearLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #examples }
GLMBrickVerticalFillProportionalLinearLayout class >> example [
	"self example"
	super example
]

{ #category : #layouting }
GLMBrickVerticalFillProportionalLinearLayout >> extentOf: aBrick in: owner withArguments: aHashTable [
	|extent|
	extent := super extentOf: aBrick in: owner withArguments: aHashTable.
	^ (owner innerBounds width - aBrick layoutProperties horizontalMargin)@(extent y)
]
