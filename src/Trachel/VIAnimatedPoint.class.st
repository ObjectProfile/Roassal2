Class {
	#name : #VIAnimatedPoint,
	#superclass : #TRObject,
	#instVars : [
		'x',
		'y'
	],
	#category : #'Trachel-Viva'
}

{ #category : #'as yet unclassified' }
VIAnimatedPoint >> + anotherPoint [
	^ VIAnimatedPoint new 
		x: [ self x value + (anotherPoint x) ];
		y: [ self y value + (anotherPoint y) ];
		yourself
		
"	^ VIAnimatedPoint new 
		x: [ :time | (self x value: time) + (anotherPoint x value: time) ];
		y: [ :time | (self y value: time) + (anotherPoint y value: time) ];
		yourself"
]

{ #category : #'as yet unclassified' }
VIAnimatedPoint >> - anotherPoint [
	^ VIAnimatedPoint new 
		x: [ self x value - (anotherPoint x) ];
		y: [ self y value - (anotherPoint y) ];
		yourself
		
"	^ VIAnimatedPoint new 
		x: [ :time | (self x value: time) + (anotherPoint x value: time) ];
		y: [ :time | (self y value: time) + (anotherPoint y value: time) ];
		yourself"
]

{ #category : #initialization }
VIAnimatedPoint >> initialize [
	super initialize.
	x := 0.
	y := 0.
]

{ #category : #accessing }
VIAnimatedPoint >> x [
	^ x
]

{ #category : #accessing }
VIAnimatedPoint >> x: anObject [
	x := anObject
]

{ #category : #accessing }
VIAnimatedPoint >> y [
	^ y
]

{ #category : #accessing }
VIAnimatedPoint >> y: anObject [
	y := anObject
]
