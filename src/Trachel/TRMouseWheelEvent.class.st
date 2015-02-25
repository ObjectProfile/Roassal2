"
I'm a mouse wheel scrolling event.

"
Class {
	#name : #TRMouseWheelEvent,
	#superclass : #TRAbstractMouseEvent,
	#instVars : [
		'direction'
	],
	#category : #'Trachel-Core'
}

{ #category : #'instance creation' }
TRMouseWheelEvent class >> fromDirection: aDirection position: aPoint [
	^ self new
		position: aPoint;
		unifyDirection: aDirection;
		yourself
]

{ #category : #accessing }
TRMouseWheelEvent >> direction [
	^ direction
]

{ #category : #accessing }
TRMouseWheelEvent >> direction: anObject [
	direction := anObject
]

{ #category : #testing }
TRMouseWheelEvent >> isDown [
	^ direction = Character arrowDown
]

{ #category : #testing }
TRMouseWheelEvent >> isLeft [
	^ direction = Character arrowLeft
]

{ #category : #testing }
TRMouseWheelEvent >> isRight [
	^ direction = Character arrowRight
]

{ #category : #testing }
TRMouseWheelEvent >> isUp [
	^ direction = Character arrowUp
]

{ #category : #accessing }
TRMouseWheelEvent >> unifyDirection: anObject [
	"sets direction according to both Pharo 4 and Pharo 3 MouseWheelEvent direction implementation.
	Pharo 3 uses #up, Pharo 4 uses Character arrowUp"

	| mapping |
	direction := anObject.
	mapping := Dictionary
		newFrom:
			{(#up -> Character arrowUp).
			(#down -> Character arrowDown).
			(#left -> Character arrowLeft).
			(#right -> Character arrowRight)}.
	direction := mapping at: anObject ifAbsent: [ anObject ]
]
