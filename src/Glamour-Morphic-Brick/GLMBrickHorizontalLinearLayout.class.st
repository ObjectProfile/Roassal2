"
A GLMBrickHorizontalLinearLayout is Linear layout, where all Bricks are being positioned horizintally in one line. The size of Bricks depends only from each Brick's extent. If any Bricks goes outside of the parent with this layout, outside part will not be drawn.

"
Class {
	#name : #GLMBrickHorizontalLinearLayout,
	#superclass : #GLMBrickLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #examples }
GLMBrickHorizontalLinearLayout class >> example [
	"self example"
	super example
]

{ #category : #testing }
GLMBrickHorizontalLinearLayout >> isHorizontal [
	^ true
]

{ #category : #testing }
GLMBrickHorizontalLinearLayout >> isVertical [
	^ false
]

{ #category : #layouting }
GLMBrickHorizontalLinearLayout >> layout: aBrick in: newBounds [
	|arguments|
	
	arguments := self prepareArgumentsFor: aBrick.
	
	aBrick subbricks
		inject: (self layoutInjection: aBrick withArguments: arguments)
		into: [ :leftOffset :each |
			self prepareLayout: each.
			(self supportsFloating: each layoutProperties floating) ifFalse: [
				|layoutBounds|
			
				layoutBounds := GLMBrickLayoutBounds on: (self boundsOf: each in: aBrick withArguments: arguments) of: each.
				layoutBounds translateBy: (leftOffset@0).
				layoutBounds moveOuterToOrigin.
			
				self setNewBounds: layoutBounds to: each in: aBrick.
			
				leftOffset + layoutBounds outerBounds width ]
			ifTrue: [ leftOffset  + ( self layoutFloating: each in: newBounds withArguments: arguments) ] ]

	
]

{ #category : #scripting }
GLMBrickHorizontalLinearLayout >> setHShrinking: aBrick [
	"my width is the sum of all subbricks width + horizontal padding"
	aBrick width: [ :brick | brick subbricks inject: aBrick layoutProperties horizontalPadding into: [ :width :each | width + each width + each layoutProperties horizontalMargin ] ]
]

{ #category : #scripting }
GLMBrickHorizontalLinearLayout >> setVShrinking: aBrick [
	"my height is the height of the highest subbrick + vertical padding"
	aBrick height: [ ((aBrick subbricks detectMax: [ :each | each height ]) ifNil: [ 0 ] ifNotNil: [ :brick | brick height ])  + aBrick layoutProperties verticalPadding ]
]

{ #category : #bounds }
GLMBrickHorizontalLinearLayout >> translate: aBrick by: anInteger [

	aBrick translateX: anInteger
]
