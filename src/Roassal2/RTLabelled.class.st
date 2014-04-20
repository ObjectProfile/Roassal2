Class {
	#name : #RTLabelled,
	#superclass : #RTInteraction,
	#instVars : [
		'position',
		'text'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTLabelled >> below [
	position := #below
]

{ #category : #'as yet unclassified' }
RTLabelled >> initialize [
	super initialize.
	text := #model.
	self top
]

{ #category : #'as yet unclassified' }
RTLabelled >> initializeElement: element [
	| lbl s t |
	t := text rtValue: element.
	t isNil ifTrue: [ ^ self ].
	s := element trachelShape.
	lbl := TRLabelShape new text: t asString.
	element view canvas addShape: lbl.
	self isTop ifTrue: [ TRConstraint stick: lbl above: s ]. 
	self isBelow ifTrue: [ TRConstraint stick: lbl below: s ].
	self isLeft ifTrue: [ TRConstraint stick: lbl onTheLeftOf: s ].
	self isRight ifTrue: [ TRConstraint stick: lbl onTheRightOf: s ].
]

{ #category : #'as yet unclassified' }
RTLabelled >> isBelow [
	^ position = #below
]

{ #category : #'as yet unclassified' }
RTLabelled >> isLeft [
	^ position = #left
]

{ #category : #'as yet unclassified' }
RTLabelled >> isRight [
	^ position = #right
]

{ #category : #'as yet unclassified' }
RTLabelled >> isTop [
	^ position = #top
]

{ #category : #'as yet unclassified' }
RTLabelled >> left [
	position := #left
]

{ #category : #'as yet unclassified' }
RTLabelled >> right [
	position := #right
]

{ #category : #'as yet unclassified' }
RTLabelled >> text: aTextOrBlock [
	text := aTextOrBlock
]

{ #category : #'as yet unclassified' }
RTLabelled >> top [
	position := #top
]
