Class {
	#name : #RTPunchcard,
	#superclass : #RTBuilder,
	#instVars : [
		'metrics',
		'objects'
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
		
b addObject: RTPunchcard.
b addObject: RTBox.
b addObject: RTBuilder.
b addMetric: #numberOfMethods named: 'NOM'.
b addMetric: #numberOfVariables named: 'NOA'.

b open
]

{ #category : #initialization }
RTPunchcard >> initialize [
	super initialize.
	objects := OrderedCollection new.
	metrics := OrderedCollection new
]

{ #category : #hooks }
RTPunchcard >> renderIn: aView [
	|  |
	
	"For the first column"
	aView add: (RTLabel elementOn: ' ').
	
	metrics do: [ :assoc | 
		| metricName |
		metricName := assoc key.
		aView add: (RTLabel elementOn: metricName) ].
	
	objects do: [ :obj |
		aView add: (RTLabel elementOn: obj).
		metrics do: [ :assoc | 
			| aMetric el |
			aMetric := assoc value.
			el := (RTEllipse new size: #yourself) elementOn: (aMetric rtValue: obj).
			self setUpInteractionFor: el.
			aView add: el
		]
	].

	RTCellLayout new 
		lineItemsCount: metrics size + 1;
		centered;
		on: aView elements
	
]
