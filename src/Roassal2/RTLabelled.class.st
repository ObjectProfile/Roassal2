"
A RTLabelled  adds a label above an element. The label may be particularized using #text: in the default string representation is not sufficient. Consider:

E.g., 
v := RTView new.
e := (RTEllipse new size: 30) elementOn: 42.
v add: e.
e @ (RTLabelled new text: [ :value | 'My value is ', value asString ]).
v

Instance Variables
	canvas:		<Object>
	color:		<Object>
	highlightable:		<Object>
	lowColor:		<Object>
	offsetOnEdge:		<Object>
	position:		<Object>
	text:		<Object>

canvas
	- xxxxx

color
	- xxxxx

highlightable
	- xxxxx

lowColor
	- xxxxx

offsetOnEdge
	- xxxxx

position
	- xxxxx

text
	- xxxxx

"
Class {
	#name : #RTLabelled,
	#superclass : #RTInteraction,
	#instVars : [
		'position',
		'text',
		'color',
		'lowColor',
		'canvas',
		'offsetOnEdge',
		'highlightable',
		'lbl'
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
	lowColor := Color veryVeryLightGray.
	
	highlightable := false. 
	offsetOnEdge := 0.5.

	canvas := [ :el | 
		el view ifNil: [ self error: 'You are trying to use RTLabelled on an element before adding the element to the view. Two solutions: (i) specify the view to the RTLabelled (using #view:) or (ii) use RTLabelled after having added the element' ].
		el view canvas ]
]

{ #category : #hooks }
RTLabelled >> initializeElement: element [
	| s t callback |
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
	
	self make: lbl highlightableIfNecessaryBy: element.
	
	"Make sure that if we remove the element, the trachel shape is also removed"
	callback := TRRemoveCallback new block: [ :shape | lbl remove ].
	element trachelShape addCallback: callback.
	element 
		attributeAt: #RTLabelledCallback put: callback;
		attributeAt: #RTLabelledLabel put: lbl.
	
	"Not really nice. Maybe a different solution could be to have a double dispatch"
	(element isKindOf: RTEdge) 
		ifTrue: [ TRConstraint 
							stick: lbl 
							between: element from trachelShape 
							and: element to trachelShape
							offset: offsetOnEdge. 
				  ^ lbl ].

	
	self isTop ifTrue: [ TRConstraint stick: lbl above: s ]. 
	self isBelow ifTrue: [ TRConstraint stick: lbl below: s ].
	self isLeft ifTrue: [ TRConstraint stick: lbl onTheLeftOf: s ].
	self isRight ifTrue: [ TRConstraint stick: lbl onTheRightOf: s ].
	self isCenter ifTrue: [ TRConstraint stick: lbl onTheCenterOf: s ].
	^ lbl.
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
RTLabelled >> lbl [
	^ lbl
]

{ #category : #accessing }
RTLabelled >> left [
	position := #left
]

{ #category : #accessing }
RTLabelled >> lowColor [
	^ lowColor
]

{ #category : #accessing }
RTLabelled >> lowColor: aBlockOrColor [
	lowColor := aBlockOrColor
]

{ #category : #utility }
RTLabelled >> make: lbl highlightableIfNecessaryBy: element [
	"Do nothing if there is no need to"
	highlightable ifFalse: [ ^ self ].
	
	lbl color: lowColor.
	element when: TRMouseEnter do: [ :evt | lbl color: color. lbl pushFront. evt signalUpdate ].
	element when: TRMouseLeave do: [ :evt | lbl color: lowColor. evt signalUpdate ].
]

{ #category : #accessing }
RTLabelled >> offsetOnEdge [
	^ offsetOnEdge
]

{ #category : #accessing }
RTLabelled >> offsetOnEdge: aFloat [
	"aFloat is between 0.0 and 1.0. With a value of 1.0, the label is close to the starting extremity"
	offsetOnEdge := aFloat
]

{ #category : #public }
RTLabelled >> removeLabelFrom: aRTElement [ 
	| callback label |
	callback := aRTElement attributeAt: #RTLabelledCallback ifAbsent: [ ^ self ].
	aRTElement trachelShape removeCallback: callback ifAbsent: [ ].
	label := aRTElement attributeAt: #RTLabelledLabel ifAbsent: [ ^ self ].
	label remove.
	aRTElement
		removeAttributeAt: #RTLabelledCallback;
		removeAttributeAt: #RTLabelledLabel.
]

{ #category : #accessing }
RTLabelled >> right [
	position := #right
]

{ #category : #'public configuration' }
RTLabelled >> setAsHighlightable [
	"Make the label highlightable by moving the mouse over the element"
	highlightable := true
]

{ #category : #accessing }
RTLabelled >> text: aValueOrAOneArgBlock [
	"aValueOrAOneArgBlock is applied on the object model"
	self textElement: [ :anElement | aValueOrAOneArgBlock rtValue: anElement model ]
]

{ #category : #accessing }
RTLabelled >> textElement: aTextOrBlock [
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
