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

{ #category : #'as yet unclassified' }
RTPunchcard >> createShapeBuilder [
	^ RTShapeBuilder new circle; yourself
]

{ #category : #hooks }
RTPunchcard >> createView [
	^ super createView @ RTDraggableView
]

{ #category : #examples }
RTPunchcard >> example01 [
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
b interaction
		highlight;
		popupText.
b interactionObject
		highlightColored: Color red;
		action: #browse.
		
b addObject: RTPunchcard.
b addObject: RTBox.
b addObject: RTBuilder.
b addMetric: #numberOfMethods named: 'NOM'.
b addMetric: #numberOfVariables named: 'NOA'.

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
		highlight;
		popupText.
		
b interactionObject
		highlightColored: Color red;
		action: #browse.

b global
	normalizeSizeMin: 5 max: 20;
	normalizeColorUsing: { Color green . Color red }.

b addObject: RTPunchcard.
b addObject: RTBox.
b addObject: RTBuilder.
b addMetric: #numberOfMethods named: 'NOM'.
b addMetric: #numberOfVariables named: 'NOA'.
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
		highlight;
		popupText.
		
b interactionObject
		highlightColored: Color red;
		action: #browse.

b global
	normalizeSizeMin: 5 max: 20;
	normalizeColorUsing: { Color green . Color red }.

b addObjects: RTShape withAllSubclasses.
b addMetric: #numberOfMethods named: 'NOM'.
b addMetric: #numberOfVariables named: 'NOA'.
b addMetric: #numberOfLinesOfCode named: 'LOC'.
b addMetric: [ :c | c allSubclasses size ] named: 'DIT'.
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
