"
A GLMMorphBrick is used as container for morphs to embed them inside bricks

Instance Variables
	morph:		<Morph>

morph
	- xxxxx

"
Class {
	#name : #GLMMorphBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'morph'
	],
	#category : #'Glamour-Morphic-Brick-Morphic'
}

{ #category : #'instance creation' }
GLMMorphBrick class >> on: aMorph [

	^ self new on: aMorph
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> addBrickBack: aBrick [
	|link|
	link := aBrick asDoubleLink.
	aBrick brickDoubleLink: link.
	
	self hasSubbricks ifTrue: [
		self lastSubbrick brickDoubleLink nextLink: link.	
		link previousLink: self lastSubbrick brickDoubleLink.
	].
	
	self privateSubbricks: (self subbricks copyWith: aBrick).
	aBrick privateOwner: self.
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> brickBounds: aRectangle [
	|origin corner newBounds|
	super brickBounds: aRectangle.
	
	origin := self paddingLeft @ self paddingTop.
	corner := self paddingRight @ self paddingBottom.
	newBounds := self globalBounds.
	newBounds := ((newBounds origin + origin) corner: (newBounds corner - corner)).
	
	self morph bounds: newBounds
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> doLayout [
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> drawSubmorphsOn: aCanvas [
	
	self morph fullDrawOn: (aCanvas copy setOrigin: (aCanvas origin + self bounds origin - self morph bounds origin) clipRect: (aCanvas clipRect translateBy: aCanvas origin))
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> morph [

	^ morph
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> on: aMorph [
	
	aMorph layoutProperties ifNil: [ 
		aMorph layoutProperties: GLMBrickLayoutProperties new.
		aMorph layoutProperties
		hSpaceFill;
		vSpaceFill ].
	self layoutProperties: aMorph layoutProperties.

	morph := aMorph.
	morph layoutProperties: (GLMBrickLayoutProperties new).
	morph layoutProperties
		hSpaceFill;
		vSpaceFill.
	self addBrickBack: morph.
	super brickBounds: (0@0 extent: (morph width@morph height)).
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> onRemovedFrom: aBrick [
	
	self removeMorph: self morph
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> onThemerChanged [
	
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> themerChanged [

	self onThemerChanged.
	self morph brickThemerChanged
]
