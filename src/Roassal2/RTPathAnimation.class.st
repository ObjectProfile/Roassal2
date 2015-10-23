"
I am a class to move elements position in a SVG path
"
Class {
	#name : #RTPathAnimation,
	#superclass : #RTAnimation,
	#instVars : [
		'curves',
		'animatedValue',
		'index',
		'during'
	],
	#category : #'Roassal2-Animation'
}

{ #category : #'as yet unclassified' }
RTPathAnimation class >> on: element path: aString seconds: seconds [
	^ self new
		element: element;
		path: aString;
		seconds: seconds
]

{ #category : #refreshing }
RTPathAnimation >> cubic: prev to: current at: t [
	| c0 c1 c2 c3 cp cx cy bx by ax ay tSquared tCubed x y|
	cp := (curves at: index) value.
	c0 := prev.
	c1 := cp second.
	c2 := cp third.
	c3 := current.
	
	cx := 3.0 * (c1 x - c0 x).
	bx := (3.0 * (c2 x - c1 x)) - cx.
	ax := c3 x - c0 x - cx - bx.
	
	cy := 3.0 * (c1 y - c0 y).
	by := (3.0* (c2 y - c1 y)) - cy.
	ay := c3 y - c0 y - cy - by.
	tSquared := t*t.
	tCubed := tSquared * t.
	x := (ax * tCubed) + (bx * tSquared) + (cx * t) + c0 x.
	y := (ay * tCubed) + (by * tSquared) + (cy * t) + c0 y.
	^ x@y
]

{ #category : #'as yet unclassified' }
RTPathAnimation >> duringDo: aBlock [
	during := aBlock.
]

{ #category : #accessing }
RTPathAnimation >> element: el [
	element := el.
	el attributes at: #op put: el position.
]

{ #category : #testing }
RTPathAnimation >> hasCompleted [
	^ animatedValue hasCompleted
]

{ #category : #'as yet unclassified' }
RTPathAnimation >> initialize [
	super initialize.
	during := [  ].
]

{ #category : #refreshing }
RTPathAnimation >> linear: prev to: current at: t [
	^ prev interpolateTo: current at: t .
]

{ #category : #accessing }
RTPathAnimation >> path: aString [
	
	curves := TRSVGPath new path: aString; curves.
	
]

{ #category : #accessing }
RTPathAnimation >> position: index [
	| r |
	r := (curves at: index) value.
	^ r first.
]

{ #category : #refreshing }
RTPathAnimation >> refresh [
	| t prev current key position |
	curves ifEmpty: [ ^ self ].
	t := animatedValue value.
	index := (t * curves size) ceiling.
	index <= 0 ifTrue: [ index := 1 ].
	current := self position: index.
	t := (t  - ((index - 1) / curves size)) / (1 / curves size).
	index = 1
		ifTrue: [ prev := element attributes at: #op  ]
		ifFalse: [ prev := self position: index- 1 ].
	key := (curves at: index) key.
	position := nil.
	((key = #m) or: [ key = #l. ])
		ifTrue: [ 
			position := self
				linear: prev
				to: current
				at: t ].
	key = #c
		ifTrue: [ position := self 
			cubic: prev 
			to: current
			at: t
			 ].
	position notNil ifTrue:[
		element translateTo: position.
		during rtValue: element.
		element signalUpdate.
		].
	
]

{ #category : #accessing }
RTPathAnimation >> repeat [
	animatedValue timer repeat.
]

{ #category : #private }
RTPathAnimation >> seconds: seconds [
	animatedValue := VIAnimatedValue new
		evaluator: [ :t | t ];
		timer: (VITimer new cycleLength: seconds);
		yourself.
	


]

{ #category : #actions }
RTPathAnimation >> start [
	animatedValue start
]
