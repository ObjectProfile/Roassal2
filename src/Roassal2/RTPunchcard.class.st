Class {
	#name : #RTPunchcard,
	#superclass : #RTBuilder,
	#instVars : [
		'metrics',
		'objects'
	],
	#category : #'Roassal2-Builder-Punchcard'
}

{ #category : #'as yet unclassified' }
RTPunchcard >> addMetric: blockOrSymbol [
	self addMetric: blockOrSymbol named: blockOrSymbol asString
]

{ #category : #'as yet unclassified' }
RTPunchcard >> addMetric: blockOrSymbol named: aName [
	metrics add: aName -> blockOrSymbol
]

{ #category : #'as yet unclassified' }
RTPunchcard >> addObject: anObject [
	objects add: anObject
]

{ #category : #'as yet unclassified' }
RTPunchcard >> initialize [
	super initialize.
	objects := OrderedCollection new.
	metrics := OrderedCollection new
]

{ #category : #'as yet unclassified' }
RTPunchcard >> renderIn: aView [
	| value |
	
	"For the first column"
	aView add: (RTLabel elementOn: ' ').
	
	metrics do: [ :assoc | 
		| metricName |
		metricName := assoc key.
		aView add: (RTLabel elementOn: metricName) ].
	
	objects do: [ :obj |
		aView add: (RTLabel elementOn: obj).
		metrics do: [ :assoc | 
			| aMetric |
			aMetric := assoc value.
			value := aMetric rtValue: obj.
			aView add: (RTEllipse new size: value) element
		]
	].

	RTCellLayout new 
		lineItemsCount: metrics size + 1;
		centered;
		on: aView elements
	
]
