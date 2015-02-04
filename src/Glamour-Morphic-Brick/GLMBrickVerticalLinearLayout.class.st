"
A GLMBrickVerticalLinearLayout is Linear layout, where all Bricks are being positioned vertically in one line. The size of Bricks depends only from each Brick's extent. If any Bricks goes outside of the parent with this layout, outside part will not be drawn.

"
Class {
	#name : #GLMBrickVerticalLinearLayout,
	#superclass : #GLMBrickLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #examples }
GLMBrickVerticalLinearLayout class >> example [
	"self example"
	super example
]

{ #category : #testing }
GLMBrickVerticalLinearLayout >> isHorizontal [
	^ false
]

{ #category : #testing }
GLMBrickVerticalLinearLayout >> isVertical [
	^ true
]

{ #category : #layouting }
GLMBrickVerticalLinearLayout >> layout: aBrick in: newBounds [
	|arguments|
	arguments := self prepareArgumentsFor: aBrick.
	
	aBrick subbricks
		inject: (self layoutInjection: aBrick withArguments: arguments)
		into: [ :topOffset :each |
			self prepareLayout: each.
			
			(self supportsFloating: each layoutProperties floating) ifFalse: [
				|layoutBounds|
			
				layoutBounds := GLMBrickLayoutBounds on: (self boundsOf: each in: aBrick withArguments: arguments) of: each.
				layoutBounds translateBy: (0@topOffset).
				layoutBounds moveOuterToOrigin.
			
				self setNewBounds: layoutBounds to: each in: aBrick.
			
				topOffset + layoutBounds outerBounds height ]
			ifTrue: [ topOffset + (self layoutFloating: each in: newBounds withArguments: arguments) ] ]
]

{ #category : #scripting }
GLMBrickVerticalLinearLayout >> setHShrinking: aBrick [
	"my width is the width of the widest subbrick  + horizontal padding"
	aBrick width: [ ((aBrick subbricks detectMax: [ :each | each width ]) ifNil: [ 0 ] ifNotNil: [ :brick | brick width ]) + aBrick layoutProperties horizontalPadding ]
]

{ #category : #scripting }
GLMBrickVerticalLinearLayout >> setVShrinking: aBrick [
	"my height is the sum of all subbricks height  + vertical padding"
	aBrick height: [ :brick | brick subbricks inject: aBrick layoutProperties verticalPadding into: [ :height :each | height + each height + each layoutProperties verticalMargin ] ]
]

{ #category : #bounds }
GLMBrickVerticalLinearLayout >> translate: aBrick by: anInteger [

	aBrick translateY: anInteger
]
