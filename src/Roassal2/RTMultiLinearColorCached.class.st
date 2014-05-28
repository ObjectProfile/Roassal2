Class {
	#name : #RTMultiLinearColorCached,
	#superclass : #RTMultiLinearColor,
	#instVars : [
		'cache',
		'sizeBeforeReset'
	],
	#category : #'Roassal2-ColorNormalizer'
}

{ #category : #'as yet unclassified' }
RTMultiLinearColorCached >> initialize [
	super initialize.
	self resetCache.
	sizeBeforeReset := 800
]

{ #category : #'as yet unclassified' }
RTMultiLinearColorCached >> level: f [
	cache size >= sizeBeforeReset ifTrue: [ self resetCache ].
	^ cache at: f ifAbsentPut: [ super level: f ]
]

{ #category : #'as yet unclassified' }
RTMultiLinearColorCached >> resetCache [
	cache := Dictionary new
]
