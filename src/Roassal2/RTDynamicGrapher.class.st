Class {
	#name : #RTDynamicGrapher,
	#superclass : #RTAbstractGrapher,
	#instVars : [
		'x',
		'y'
	],
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #'as yet unclassified' }
RTDynamicGrapher >> add: anObject [
	| positionInView el |
	positionInView := self getPixelPositionOf: (x rtValue: anObject) @ (y rtValue: anObject).
	el := shapeBuilder elementOn: anObject.
	el translateTo: positionInView.
	view add: el.
	view signalUpdate.
	^ el
]

{ #category : #'as yet unclassified' }
RTDynamicGrapher >> addAll: someObjects [
	^ someObjects collect: [ :o | self add: o ]
	
]

{ #category : #hooks }
RTDynamicGrapher >> createView [
	^ RTView new
]

{ #category : #'as yet unclassified' }
RTDynamicGrapher >> example01 [

	"
	self new example01
	"

	| b |
	b := RTDynamicGrapher new.
	b minX: -2; maxX: 2.
	b minY: 0; maxY: 2.

	b x: #x; y: #y.
	 
	b shape circle color: (Color red alpha: 0.3).
	b view addMenu: '+ 1' callback: [ b add: 4 atRandom - 2 @ 2 atRandom ].
	^ b  
]

{ #category : #'as yet unclassified' }
RTDynamicGrapher >> example02 [

	"
	self new example02
	"

	| b |
	b := RTDynamicGrapher new.
	b maxX: 100.
	b maxY: 100.

	b x: #x; y: #y.
	 
	b shape circle color: (Color red alpha: 0.3).
	b view addMenu: '+ 10' callback: [ 
			b addAll: ((1 to: 10) collect: [ :i | (100 atRandom @ 100 atRandom) ]) ].
	^ b  
]

{ #category : #'as yet unclassified' }
RTDynamicGrapher >> initialize [
	super initialize.
	x := #yourself.
	y := #yourself
]

{ #category : #'as yet unclassified' }
RTDynamicGrapher >> renderIn: aView [

	self defineAxesIfNecessary.
	self renderAxis.

]

{ #category : #accessing }
RTDynamicGrapher >> x [
	^ x
]

{ #category : #accessing }
RTDynamicGrapher >> x: anObject [
	x := anObject
]

{ #category : #accessing }
RTDynamicGrapher >> y [
	^ y
]

{ #category : #accessing }
RTDynamicGrapher >> y: anObject [
	y := anObject
]
