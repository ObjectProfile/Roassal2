Class {
	#name : #RTPunchcard,
	#superclass : #RTBuilder,
	#instVars : [
		'metrics',
		'objects',
		'interactionObject'
	],
	#category : #'Roassal2-Builder-Punchcard'
}

{ #category : #adding }
RTPunchcard >> addMetric: blockOrSymbol [
	self addMetric: blockOrSymbol named: blockOrSymbol asString
]

{ #category : #adding }
RTPunchcard >> addMetric: blockOrSymbol named: aName [
	metrics add: aName -> blockOrSymbol
]

{ #category : #adding }
RTPunchcard >> addObject: anObject [
	objects add: anObject
]

{ #category : #adding }
RTPunchcard >> addObjects: someObjects [
	someObjects do: [ :o | self addObject: o ]
]

{ #category : #hooks }
RTPunchcard >> createShapeBuilder [
	| sb |
	sb := RTShapeBuilder new.
	sb ellipse size: #yourself.
	^ sb
]

{ #category : #hooks }
RTPunchcard >> createView [
	^ super createView @ RTDraggableView; setDefaultMenu; yourself
]

{ #category : #examples }
RTPunchcard >> example01 [
	"
	self new example01
	"

| b |
b := RTPunchcard new.
b addObject: RTPunchcard.
b addObject: RTBox.
b addObject: RTBuilder.
b addMetric: #numberOfMethods named: 'NOM'.
b addMetric: #numberOfVariables named: 'NOA'.
b open
]

{ #category : #examples }
RTPunchcard >> example02 [
	"
	self new example02
	"

| b |

b := RTPunchcard new.
b shape rectangle 
	size: [ :v | v sqrt max: 5 ].
b addObject: RTPunchcard.
b addObject: RTBox.
b addObject: RTBuilder.
b addMetric: #numberOfMethods named: 'NOM'.
b addMetric: #numberOfVariables named: 'NOA'.
b addMetric: #numberOfLinesOfCode named: 'LOC'.

b open
]

{ #category : #examples }
RTPunchcard >> example03 [
	"
	self new example03
	"
| b |
b := RTPunchcard new.
b interaction
	highlightColored: Color red;
	popupText;
	action: #browse.

b shape circle 
	size: [ :v | v sqrt * 2 max: 5 ].

b addObject: RTPunchcard.
b addObject: RTBox.
b addObject: RTBuilder.
b addMetric: #numberOfMethods named: 'NOM'.
b addMetric: #numberOfVariables named: 'NOA'.
b addMetric: #numberOfLinesOfCode named: 'LOC'.
b open
]

{ #category : #examples }
RTPunchcard >> example04 [
	"
	self new example04
	"
| b |
b := RTPunchcard new.
b interaction
	popupText;
	highlightColored: Color red;
	action: #browse.

b global
	normalizeSizeMin: 5 max: 20;
	normalizeColorUsing: (Array with: Color green with: Color red ).

b addObject: RTPunchcard.
b addObject: RTBox.
b addObject: RTBuilder.
b addMetric: #numberOfMethods named: 'NOM'.
b addMetric: #numberOfVariables named: 'NOA'.
b addMetric: #numberOfLinesOfCode named: 'LOC'.
b open
]

{ #category : #initialization }
RTPunchcard >> initialize [
	super initialize.
	objects := OrderedCollection new.
	metrics := OrderedCollection new.
	interactionObject := RTInteractionBuilder new
]

{ #category : #accessing }
RTPunchcard >> interactionObject [
	^ interactionObject
]

{ #category : #hooks }
RTPunchcard >> renderIn: aView [	
	| el |
	aView add: (RTLabel elementsOn: ' ').
	objects do: [ :object | 
		| objElement |
		objElement := RTLabel elementOn: object.
		self setUpInteractionFor: objElement.
		aView add: objElement ].
	
	metrics do: [ :assoc |
		aView add: (RTLabel elementOn: assoc key).
		self resetCreatedElements.
		objects do: [ :object |
			| value |
			value := assoc value rtValue: object.
			el := self elementOn: value.
			aView add: el ].
		globalBuilder executeOn: self createdElements ].		
	RTCellLayout new 
		lineItemsCount: objects size + 1;
		on: aView elements
]

{ #category : #hooks }
RTPunchcard >> renderInOLD: aView [
	| labelClass |
	
	"For the first column"
	aView add: (RTLabel elementOn: ' ').
	
	metrics do: [ :assoc | 
		| metricName el |
		metricName := assoc key.
		el := RTLabel elementOn: metricName.
		aView add: el ].
	
	objects do: [ :obj |
		labelClass := RTLabel elementOn: obj.
		interactionObject setUpElement: labelClass.
		aView add: labelClass.
		shapeBuilder current size: #yourself.
		self resetCreatedElements.
		metrics do: [ :assoc | 
			| aMetric el |
			aMetric := assoc value.
			el := self elementOn: (aMetric rtValue: obj).
			self setUpInteractionFor: el.
			aView add: el
		].
		globalBuilder executeOn: self createdElements.
	].

	
	RTCellLayout new 
		lineItemsCount: metrics size + 1;
		centered;
		on: aView elements
	
]

{ #category : #hooks }
RTPunchcard >> renderInVersion1: aView [	
	aView add: (RTLabel elementsOn: ' ').
	objects 
		do: [ :object | aView add: (RTLabel elementOn: object) ].
	
	metrics do: [ :assoc |
		aView add: (RTLabel elementOn: assoc key).
		objects do: [ :object |
			| value |
			value := assoc value rtValue: object.
			aView add: ((RTEllipse new size: value) element) ] ].		
	RTCellLayout new 
		lineItemsCount: objects size + 1;
		on: aView elements
]

{ #category : #hooks }
RTPunchcard >> renderInVersion2: aView [	
	aView add: (RTLabel elementsOn: ' ').
	objects 
		do: [ :object | aView add: (RTLabel elementOn: object) ].
	
	metrics do: [ :assoc |
		aView add: (RTLabel elementOn: assoc key).
		objects do: [ :object |
			| value |
			value := assoc value rtValue: object.
			aView add: (self elementOn: value) ] ].		
	RTCellLayout new 
		lineItemsCount: objects size + 1;
		on: aView elements
]

{ #category : #hooks }
RTPunchcard >> renderInVersion3: aView [	
	| el |
	aView add: (RTLabel elementsOn: ' ').
	objects do: [ :object | 
		| objElement |
		objElement := RTLabel elementOn: object.
		self setUpInteractionFor: objElement.
		aView add: objElement ].
	
	metrics do: [ :assoc |
		aView add: (RTLabel elementOn: assoc key).
		objects do: [ :object |
			| value |
			value := assoc value rtValue: object.
			el := self elementOn: value.
			aView add: el ] ].		
	RTCellLayout new 
		lineItemsCount: objects size + 1;
		on: aView elements
]

{ #category : #hooks }
RTPunchcard >> renderInVersion4: aView [	
	| el |
	aView add: (RTLabel elementsOn: ' ').
	objects do: [ :object | 
		| objElement |
		objElement := RTLabel elementOn: object.
		self setUpInteractionFor: objElement.
		aView add: objElement ].
	
	metrics do: [ :assoc |
		aView add: (RTLabel elementOn: assoc key).
		self resetCreatedElements.
		objects do: [ :object |
			| value |
			value := assoc value rtValue: object.
			el := self elementOn: value.
			aView add: el ].
		globalBuilder executeOn: self createdElements ].		
	RTCellLayout new 
		lineItemsCount: objects size + 1;
		on: aView elements
]
