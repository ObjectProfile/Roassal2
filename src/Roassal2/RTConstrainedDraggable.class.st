Class {
	#name : #RTConstrainedDraggable,
	#superclass : #RTAbstractDraggable,
	#instVars : [
		'rectangle'
	],
	#category : #'Roassal2-Core'
}

{ #category : #hooks }
RTConstrainedDraggable >> constraintIfNecessary: anElement [
	| p newX newY rec |
	p := anElement position.
	rec := rectangle rtValue: anElement.
	(rec containsPoint: p)
		ifFalse: [ 
			newX := p x.
			newY := p y.
			(p x > rec right) ifTrue: [ newX := rec right ].
			(p x < rec left) ifTrue: [ newX := rec left ].

			(p y < rec top) ifTrue: [ newY := rec top ].
			(p y > rec bottom) ifTrue: [ newY := rec bottom ].

			anElement translateTo: newX @ newY ]
]

{ #category : #'as yet unclassified' }
RTConstrainedDraggable >> initialize [
	super initialize.
	rectangle := (-5 @ -5) extent: (10 @ 10)
]

{ #category : #accessing }
RTConstrainedDraggable >> rectangle [
	^ rectangle
]

{ #category : #accessing }
RTConstrainedDraggable >> rectangle: anObject [
	rectangle := anObject
]

{ #category : #hooks }
RTConstrainedDraggable >> transformDistance: distanceAsPoint forElement: anElement [
	^ distanceAsPoint
"Transcript show: distanceAsPoint printString; cr.
	^ (rectangle containsPoint: distanceAsPoint + anElement position)
		ifTrue: [ distanceAsPoint ]
		ifFalse: [ 0 @ 0 ]"
]
