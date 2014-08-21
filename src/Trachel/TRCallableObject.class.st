Class {
	#name : #TRCallableObject,
	#superclass : #TRObject,
	#instVars : [
		'callbacks'
	],
	#category : #'Trachel-Core'
}

{ #category : #callbacks }
TRCallableObject >> addCallback: aCallback [
	callbacks ifNil: [ callbacks := OrderedCollection new ].
	callbacks add: aCallback
]

{ #category : #callbacks }
TRCallableObject >> doWithoutCallbacks: aBlock [
	"Simply evaluate aBlock"
	| oldCallbacks |
	oldCallbacks := callbacks.
	callbacks := #().
	aBlock value.
	callbacks := oldCallbacks
]

{ #category : #callbacks }
TRCallableObject >> removeCallback: aCallback ifAbsent: anErrorBlock [
	callbacks ifNil: [ ^ self ].
	callbacks remove: aCallback ifAbsent: anErrorBlock
]

{ #category : #callbacks }
TRCallableObject >> triggerCallbacksForNewExtent: newExtent oldExtent: oldExtent [ 
	callbacks ifNil: [ ^ self ].
	callbacks do: [ :c | 
		c isExtentCallback ifTrue: [ 
			c shape: self newExtent: newExtent oldExtent: oldExtent ] ]
]

{ #category : #callbacks }
TRCallableObject >> triggerCallbacksForStep: aStep [
	"aStep is a point that represents a translation step"
	callbacks ifNil: [ ^ self ].
	callbacks do: [ :c | 
		c isTranslationCallback ifTrue: [ 
			c shape: self step: aStep ] ]
]

{ #category : #callbacks }
TRCallableObject >> triggerRemoveCallbacks [
	"aStep is a point that represents a translation step"
	callbacks ifNil: [ ^ self ].
	callbacks do: [ :c | 
		c isRemoveCallback ifTrue: [ 
			c removeShape: self ] ]
]
