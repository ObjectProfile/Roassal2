Class {
	#name : #RTLazyMetricNormalizer,
	#superclass : #RTObject,
	#instVars : [
		'messages',
		'realNormalizer'
	],
	#category : #'Roassal2-ColorNormalizer'
}

{ #category : #'as yet unclassified' }
RTLazyMetricNormalizer >> build [
	messages do: [ :m | m sendTo: realNormalizer ].
	self resetMessages
]

{ #category : #'as yet unclassified' }
RTLazyMetricNormalizer >> doesNotUnderstand: message [
	messages add: message
]

{ #category : #'as yet unclassified' }
RTLazyMetricNormalizer >> elements: someElements [
	realNormalizer elements: someElements
]

{ #category : #'as yet unclassified' }
RTLazyMetricNormalizer >> initialize [
	super initialize.
	realNormalizer := RTMetricNormalizer new.
	self resetMessages
]

{ #category : #'as yet unclassified' }
RTLazyMetricNormalizer >> resetMessages [
	messages := OrderedCollection new
]
