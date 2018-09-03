Class {
	#name : #GLMPhlowTextBrick,
	#superclass : #GLMPhlowBrick,
	#instVars : [
		'#textBrick => GLMPhlowSlot'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #examples }
GLMPhlowTextBrick class >> example [
	
	^ GLMCompositeBrick examplePharoMethod
]

{ #category : #phlow }
GLMPhlowTextBrick >> display: anObject [

	self setProperty: #phlowDisplay toValue: anObject
]

{ #category : #accessing }
GLMPhlowTextBrick >> displayLogic [

	^ self valueOfProperty: #phlowDisplay ifAbsent: [ #yourself ]
]

{ #category : #phlow }
GLMPhlowTextBrick >> entity: anObject [
	super entity: anObject.
	
	self installEntity
]

{ #category : #initialization }
GLMPhlowTextBrick >> initialize [
	super initialize.
	
	self textBrick: self newTextBrick.
]

{ #category : #phlow }
GLMPhlowTextBrick >> installEntity [
	self textBrick setTextWith: (self displayLogic phlowValue: self entity)
	
]

{ #category : #'instance creation' }
GLMPhlowTextBrick >> newTextBrick [

	^ GLMRubScrolledTextBrick new
]

{ #category : #accessing }
GLMPhlowTextBrick >> textBrick [

	^ textBrick
	

]

{ #category : #accessing }
GLMPhlowTextBrick >> textBrick: aBrick [

	textBrick := aBrick.
	self textBrick
		wrapped: true.
		
	self textBrick layoutProperties
		vSpaceFill;
		hSpaceFill.
	self addBrickBack: self textBrick
	

]
