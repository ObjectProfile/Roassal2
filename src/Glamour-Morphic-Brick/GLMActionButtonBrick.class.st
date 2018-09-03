"
A GLMActionButtonBrick is a button for Glamour actions, used in Tabbed presentations

Instance Variables
	action:		<Object>

action
	- xxxxx

"
Class {
	#name : #GLMActionButtonBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'action'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #accessing }
GLMActionButtonBrick >> action: anAction [

	action := anAction.
	
	self normalImage: action icon.
	self pressedColor: Color veryVeryLightGray
]

{ #category : #adding }
GLMActionButtonBrick >> addUpAction: anActionOrBlock [

	anActionOrBlock isBlock
		ifTrue: [ action := anActionOrBlock ]
		ifFalse: [ self action: anActionOrBlock ]
]

{ #category : #actions }
GLMActionButtonBrick >> click: evt [
	
	action ifNil: [ ^ false ].
	action isBlock
		ifTrue: [ action value ]
		ifFalse: [ action performOn: self data ].
	
	^ true
]

{ #category : #accessing }
GLMActionButtonBrick >> icon: anImage [

	self normalImage: anImage.
]

{ #category : #initialization }
GLMActionButtonBrick >> initialize [
	super initialize.
	
	self enable.
]
