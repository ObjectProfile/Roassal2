"
A GLMBrickRenderer is most simple separate renderer of Bricks. It support only borders

"
Class {
	#name : #GLMBrickRenderer,
	#superclass : #Object,
	#category : #'Glamour-Morphic-Brick-Renderer'
}

{ #category : #'private-shadow' }
GLMBrickRenderer >> bottomLeftCornerShadowOf: aBrick on: aCanvas [
	|gradient width|
	width := aBrick shadowWidth.
	"draw top left corner"
	gradient := (self shadowGradientFor: aBrick)
		origin: aBrick brickBounds bottomLeft + (width@width negated);
		direction: (width negated@width)/1.4;
		radial: true;
		yourself.
	aCanvas fillRectangle: (aBrick brickBounds bottomLeft - (0@width) corner: (aBrick brickBounds bottomLeft + (width@0))) fillStyle: gradient.
]

{ #category : #'private-shadow' }
GLMBrickRenderer >> bottomRightCornerShadowOf: aBrick on: aCanvas [
	|gradient width|
	width := aBrick shadowWidth.
	"draw top right corner"
	gradient := (self shadowGradientFor: aBrick)
		origin: aBrick brickBounds corner  - (width@width);
		direction: (width@width)/1.4;
		radial: true;
	yourself.
	
	aCanvas fillRectangle: (aBrick brickBounds corner  - (width@width) corner: (aBrick brickBounds corner)) fillStyle: gradient.
]

{ #category : #'private-shadow' }
GLMBrickRenderer >> bottomShadowOf: aBrick on: aCanvas [
	|gradient width|
	width := aBrick shadowWidth.
	"draw bottom shadow"
	gradient := (self shadowGradientFor: aBrick)
		origin: aBrick brickBounds bottomCenter - (0@width);
		direction: (0@width);
		yourself.
	aCanvas fillRectangle: ((aBrick brickBounds bottomLeft + (width@width negated)) corner: (aBrick brickBounds bottomLeft - (width @width) + (aBrick brickBounds width @ width))) fillStyle: gradient.
]

{ #category : #'private-shadow' }
GLMBrickRenderer >> leftShadowOf: aBrick on: aCanvas [
	|gradient width|
	width := aBrick shadowWidth.
	"draw left shadow"
	gradient := (self shadowGradientFor: aBrick)
		origin: aBrick brickBounds leftCenter + (width@0);
		direction: (width@0)negated;
		yourself.
	aCanvas fillRectangle: ((aBrick brickBounds origin + (0@width)) corner: (aBrick brickBounds origin + (width@width negated) + (0@ aBrick brickBounds height))) fillStyle: gradient.
]

{ #category : #rendering }
GLMBrickRenderer >> render: aBrick on: aCanvas [
	
	self
		renderBackgroundColorOf: aBrick on: aCanvas;
		renderShadowOf: aBrick on: aCanvas;
		renderBorderOf: aBrick on: aCanvas
]

{ #category : #rendering }
GLMBrickRenderer >> renderBackgroundColorOf: aBrick on: aCanvas [

	aCanvas fillRectangle: (aBrick brickBounds expandBy: aBrick shadowWidth negated) color: aBrick color.
]

{ #category : #rendering }
GLMBrickRenderer >> renderBorderOf: aBrick on: aCanvas [
	|rect|
	
	rect := (aBrick brickBounds origin - (aBrick paddingLeft @ aBrick paddingTop)) corner: (aBrick brickBounds corner + (aBrick paddingRight @ aBrick paddingBottom)).
	aCanvas frameRectangle: rect width: aBrick borderWidth color: aBrick borderColor
]

{ #category : #rendering }
GLMBrickRenderer >> renderShadowOf: aBrick on: aCanvas [

	"no need to even try drawing if shadow width is zero"
	aBrick shadowWidth = 0 ifTrue: [ ^ self ].
	
	self
		topLeftCornerShadowOf: aBrick on: aCanvas;
		topRightCornerShadowOf: aBrick on: aCanvas;
		bottomRightCornerShadowOf: aBrick on: aCanvas;
		bottomLeftCornerShadowOf: aBrick on: aCanvas;
		leftShadowOf: aBrick on: aCanvas;
		topShadowOf: aBrick on: aCanvas;
		rightShadowOf: aBrick on: aCanvas;
		bottomShadowOf: aBrick on: aCanvas

]

{ #category : #'private-shadow' }
GLMBrickRenderer >> rightShadowOf: aBrick on: aCanvas [
	|gradient width|
	width := aBrick shadowWidth.
	"draw top shadow"
	gradient := (self shadowGradientFor: aBrick)
		origin: aBrick brickBounds rightCenter - (width@0);
		direction: (width@0);
		yourself.
	aCanvas fillRectangle: ((aBrick brickBounds topRight + (width negated@width)) corner: (aBrick brickBounds corner + (width@width negated))) fillStyle: gradient.
]

{ #category : #'private-shadow' }
GLMBrickRenderer >> shadowGradientFor: aBrick [

	^ GradientFillStyle ramp: { 0.0 -> (aBrick shadowColor) . 1.0 -> (aBrick shadowColor alpha: 0)}
]

{ #category : #'private-shadow' }
GLMBrickRenderer >> topLeftCornerShadowOf: aBrick on: aCanvas [
	|gradient width|
	width := aBrick shadowWidth.
	"draw top left corner"
	gradient := (self shadowGradientFor: aBrick)
		origin: aBrick brickBounds origin + (width@width);
		direction: (width@width)/1.4 negated;
		radial: true;
		yourself.
	aCanvas fillRectangle: (aBrick brickBounds origin corner: (aBrick brickBounds origin + (width@width))) fillStyle: gradient.
]

{ #category : #'private-shadow' }
GLMBrickRenderer >> topRightCornerShadowOf: aBrick on: aCanvas [
	|gradient width|
	width := aBrick shadowWidth.
	"draw top right corner"
	gradient := (self shadowGradientFor: aBrick)
		origin: aBrick brickBounds topRight  - (width@width negated);
		direction: (width@width negated)/1.4;
		radial: true;
	yourself.
	
	aCanvas fillRectangle: (aBrick brickBounds topRight - (width@0) corner: (aBrick brickBounds topRight + (0@width))) fillStyle: gradient.
]

{ #category : #'private-shadow' }
GLMBrickRenderer >> topShadowOf: aBrick on: aCanvas [
	|gradient width|
	width := aBrick shadowWidth.
	"draw top shadow"
	gradient := (self shadowGradientFor: aBrick)
		origin: aBrick brickBounds topCenter + (0@width);
		direction: (0@width)negated;
		yourself.
		
	aCanvas fillRectangle: ((aBrick brickBounds origin + (width@0)) corner: (aBrick brickBounds origin - (width@0) + (aBrick brickBounds width @ width))) fillStyle: gradient.
]
