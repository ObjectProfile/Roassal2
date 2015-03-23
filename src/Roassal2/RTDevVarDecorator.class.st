Class {
	#name : #RTDevVarDecorator,
	#superclass : #RTAbstractGrapherDecorator,
	#instVars : [
		'desviation',
		'color',
		'points'
	],
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #accessing }
RTDevVarDecorator >> color [
	^ color
]

{ #category : #accessing }
RTDevVarDecorator >> color: aColor [
	color := aColor.
]

{ #category : #accessing }
RTDevVarDecorator >> desviation [
	^ desviation
]

{ #category : #accessing }
RTDevVarDecorator >> desviation: aNumber [
	desviation := aNumber
]

{ #category : #initialization }
RTDevVarDecorator >> initialize [
	super initialize.
	self color: (Color gray alpha: 0.5).
	self desviation: 0.
]

{ #category : #accessing }
RTDevVarDecorator >> points [
	^ points
]

{ #category : #accessing }
RTDevVarDecorator >> points: pts [
	points := pts
]

{ #category : #drawing }
RTDevVarDecorator >> render [
	| dev svg k str index offset |
	dev := points collectWithIndex: [ :p :i | p + (desviation*i). ].
	
	svg := TRSVGPath new.
	svg color: color.
	offset := -0.15.
	k := builder getPixelPositionOf: (1+offset)@dev first.
	str := 'M', k x asString,' ', k y asString.
	(2 to: dev size) do: [ :i| | p |
		p := dev at: i.
		k := builder getPixelPositionOf: (i+offset)@p.
		str := str, 'L', k x asString,' ', k y asString.
		].
	dev := (points collectWithIndex:[:p :i | p - (desviation*i)] ).
	(1 to: dev size) do: [ :i | | p |
		index := dev size - i +1.
		p := dev at: index.
		k := builder getPixelPositionOf: (index+offset)@p.
		str := str, 'L', k x asString,' ', k y asString. ].
	
	str := str, 'Z'.
	svg path: str.
	builder view canvas addShape: svg.
	
]
