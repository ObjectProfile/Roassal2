Class {
	#name : #RTLabelled,
	#superclass : #RTInteraction,
	#instVars : [
		'position',
		'text',
		'color',
		'canvas'
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

	canvas := [ :el | 
		el view ifNil: [ self error: 'You are trying to use RTLabelled on an element before adding the element to the view. Two solutions: (i) specify the view to the RTLabelled (using #view:) or (ii) use RTLabelled after having added the element' ].
		el view canvas ]
]

{ #category : #hooks }
RTLabelled >> initializeElement: element [
	| lbl s t |
	t := text rtValue: element.
	t isNil ifTrue: [ ^ self ].
	
	s := element trachelShape.
	lbl := TRLabelShape new text: t asString.
	lbl color: (color rtValue: element).
	
	"We first get a reference to the canvas, and then we add the shape in it"
	"We are using the variable canvas to let the user specificy the canvas (or the view) before 
	adding the element into it"
	canvas := (canvas rtValue: element).
	canvas addShape: lbl.
	
	"Not really nice. Maybe a different solution could be to have a double dispatch"
	(element isKindOf: RTEdge) 
		ifTrue: [ TRConstraint 
					stick: lbl between: element from trachelShape and: element to trachelShape. 
				  ^ self ].

	
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

{ #category : #accessing }
RTLabelled >> view: aBlockOrValue [
	"aBlock is evaluated against the element to get the canvas"
	canvas := [ :el | (aBlockOrValue rtValue: el) canvas ]
]
