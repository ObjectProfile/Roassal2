Class {
	#name : #GLMPhlowPharoMethodBrick,
	#superclass : #GLMPhlowTextBrick,
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #phlow }
GLMPhlowPharoMethodBrick >> installEntity [
	self textBrick classOrMetaClass: (self smalltalkClassLogic phlowValue: self entity).
	self textBrick setTextWith: (self displayLogic phlowValue: self entity)
]

{ #category : #phlow }
GLMPhlowPharoMethodBrick >> smalltalkClass: anObject [
	
	self setProperty: #phlowSmalltalkClass toValue: anObject
]

{ #category : #accessing }
GLMPhlowPharoMethodBrick >> smalltalkClassLogic [

	^ self valueOfProperty: #phlowSmalltalkClass ifAbsent: [ #yourself ]
]

{ #category : #accessing }
GLMPhlowPharoMethodBrick >> textBrick: aBrick [

	super textBrick: aBrick.
	self textBrick beForSmalltalkCode.
]
