Class {
	#name : #RTLabelled,
	#superclass : #RTInteraction,
	#instVars : [
		'position',
		'text',
		'color'
	],
	#category : #'Roassal2-Core'
}

{ #category : #accessing }
RTLabelled >> below [
	position := #below
]

{ #category : #accessing }
RTLabelled >> center [
	position := #center		
]

{ #category : #accessing }
RTLabelled >> color [
	^ color
]

{ #category : #accessing }
RTLabelled >> color: aBlockOrColor [
	color := aBlockOrColor
]

{ #category : #initialization }
RTLabelled >> initialize [
	super initialize.
	text := #model.
	self top.
	color := Color gray.
]

{ #category : #hooks }
RTLabelled >> initializeElement: element [
	| lbl s t |
	t := text rtValue: element.
	t isNil ifTrue: [ ^ self ].
	s := element trachelShape.
	lbl := TRLabelShape new text: t asString.
	lbl color: (color rtValue: element).
	element view canvas addShape: lbl.
	self isTop ifTrue: [ TRConstraint stick: lbl above: s ]. 
	self isBelow ifTrue: [ TRConstraint stick: lbl below: s ].
	self isLeft ifTrue: [ TRConstraint stick: lbl onTheLeftOf: s ].
	self isRight ifTrue: [ TRConstraint stick: lbl onTheRightOf: s ].
	self isCenter ifTrue: [ TRConstraint stick: lbl onTheCenterOf: s ].
]

{ #category : #testing }
RTLabelled >> isBelow [
	^ position = #below
]

{ #category : #testing }
RTLabelled >> isCenter [
	^ position = #center		
]

{ #category : #testing }
RTLabelled >> isLeft [
	^ position = #left
]

{ #category : #testing }
RTLabelled >> isRight [
	^ position = #right
]

{ #category : #testing }
RTLabelled >> isTop [
	^ position = #top
]

{ #category : #accessing }
RTLabelled >> left [
	position := #left
]

{ #category : #accessing }
RTLabelled >> right [
	position := #right
]

{ #category : #accessing }
RTLabelled >> text: aTextOrBlock [
	text := aTextOrBlock
]

{ #category : #accessing }
RTLabelled >> top [
	position := #top
]
