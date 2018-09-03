Class {
	#name : #GLMPhlowBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'#entity => GLMPhlowSlot',
		'#titleBrick => GLMPhlowSlot'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #phlow }
GLMPhlowBrick >> display: aBlockOrSymbol [

	self subclassResponsibility
]

{ #category : #phlow }
GLMPhlowBrick >> entity [

	^ entity
]

{ #category : #phlow }
GLMPhlowBrick >> entity: anObject [

	entity := anObject.
	self setTitle: (self titleLogic phlowValue: self entity)
	
]

{ #category : #initialization }
GLMPhlowBrick >> initialize [
	super initialize.
		
	self
		layoutPolicy: GLMBrickVerticalFillProportionalLinearLayout new;
		titleBrick: self newTitleBrick.
		
	self layoutProperties	hSpaceFill; vSpaceFill.
]

{ #category : #'instance creation' }
GLMPhlowBrick >> newTitleBrick [

	^ GLMLabelBrick new
]

{ #category : #accessing }
GLMPhlowBrick >> setTitle: aString [

	self titleBrick text: aString.
	
	titleBrick layoutProperties staticHeight: (
		(aString isEmpty | aString isNil)
			ifFalse: [ 30 ]
			ifTrue: [ 0 ])
]

{ #category : #phlow }
GLMPhlowBrick >> title: anObject [
	
	self setProperty: #phlowTitle toValue: anObject
]

{ #category : #accessing }
GLMPhlowBrick >> titleBrick [
	^ titleBrick
]

{ #category : #accessing }
GLMPhlowBrick >> titleBrick: aBrick [

	titleBrick := aBrick.
	titleBrick textPosition: #center.
	titleBrick layoutProperties staticHeight: 0.
	self addBrickBack: titleBrick
]

{ #category : #accessing }
GLMPhlowBrick >> titleLogic [

	^ self valueOfProperty: #phlowTitle ifAbsent: [ '' ]
]
