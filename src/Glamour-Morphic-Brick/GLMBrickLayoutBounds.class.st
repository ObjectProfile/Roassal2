Class {
	#name : #GLMBrickLayoutBounds,
	#superclass : #Object,
	#instVars : [
		'outerBounds',
		'bounds',
		'innerBounds'
	],
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #'instance creation' }
GLMBrickLayoutBounds class >> on: aRectangle of: aBrick [

	^ self new on: aRectangle of: aBrick
]

{ #category : #accessing }
GLMBrickLayoutBounds >> bounds [
	^ bounds ifNil: [ bounds := 0@0 extent: 0@0 ]
]

{ #category : #accessing }
GLMBrickLayoutBounds >> innerBounds [
	^ innerBounds ifNil: [ innerBounds := 0@0 extent: 0@0 ]
]

{ #category : #actions }
GLMBrickLayoutBounds >> makeBoundsAsOuter [

	bounds := outerBounds
]

{ #category : #actions }
GLMBrickLayoutBounds >> makeBoundsFitWidth: anInteger [
	|delta|
	
	delta := bounds width - anInteger.
	outerBounds := outerBounds withRight: (outerBounds right - delta).
	innerBounds := innerBounds withRight: (innerBounds right - delta).
	bounds := bounds withRight: (bounds right - delta).
	
]

{ #category : #actions }
GLMBrickLayoutBounds >> makeOuterBoundsFit: aRectangle [
	|originDelta cornerDelta|
	
	originDelta := aRectangle origin - outerBounds origin.
	cornerDelta := aRectangle corner - outerBounds corner.
	
	outerBounds := aRectangle.
	bounds := (bounds origin + originDelta) corner: (bounds corner + cornerDelta).
	innerBounds :=  (innerBounds origin + originDelta) corner: (innerBounds corner + cornerDelta).
	
]

{ #category : #actions }
GLMBrickLayoutBounds >> makeOuterBoundsFitWidth: anInteger [
	|delta|
	
	delta := outerBounds width - anInteger.
	outerBounds := outerBounds withRight: (outerBounds right - delta).
	innerBounds := innerBounds withRight: (innerBounds right - delta).
	bounds := bounds withRight: (bounds right - delta).
	
]

{ #category : #actions }
GLMBrickLayoutBounds >> moveOuterToOrigin [

	self translateBy: (self bounds origin - self outerBounds origin).
]

{ #category : #construction }
GLMBrickLayoutBounds >> on: aRectangle of: aBrick [
	|left top right bottom|
	
	aRectangle ifNil: [ ^ self ].
	
	bounds := aRectangle.
	
	left := bounds origin x.
	top := bounds origin y.
	right := bounds corner x.
	bottom := bounds corner y.
	
	innerBounds := ((left + aBrick paddingLeft)@(top + aBrick paddingTop)) corner: ((right - aBrick paddingRight)@(bottom - aBrick paddingBottom)).
	outerBounds := ((left - aBrick marginLeft)@(top - aBrick marginTop)) corner: ((right + aBrick marginRight)@(bottom + aBrick marginBottom)).
]

{ #category : #accessing }
GLMBrickLayoutBounds >> outerBounds [
	^ outerBounds ifNil: [ outerBounds := 0@0 extent: 0@0 ]
]

{ #category : #actions }
GLMBrickLayoutBounds >> translateBy: aPoint [

	bounds := self bounds translateBy: aPoint.
	innerBounds := self innerBounds translateBy: aPoint.
	outerBounds := self outerBounds translateBy: aPoint.
]
