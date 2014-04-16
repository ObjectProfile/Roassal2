Class {
	#name : #RTMouseHoverZoom,
	#superclass : #RTInteraction,
	#instVars : [
		'desiredExtent',
		'resizeStrategy'
	],
	#category : #'Roassal2-Core'
}

{ #category : #public }
RTMouseHoverZoom >> animated [
	self animatedDuring: 0.3
]

{ #category : #public }
RTMouseHoverZoom >> animatedDuring: seconds [
	resizeStrategy := [ :anElement :newExtent :afterBlock |
		anElement view addAnimation: (RTResizeMove new
			toExtent: newExtent during: seconds on: anElement;
			after: afterBlock) ].
]

{ #category : #private }
RTMouseHoverZoom >> attributeSymbol [
	^ #automaticZoomExtent
]

{ #category : #public }
RTMouseHoverZoom >> desiredExtent: anExtentOrOneArgBlock [
	desiredExtent := anExtentOrOneArgBlock.
]

{ #category : #private }
RTMouseHoverZoom >> doZoomEfect: anElement [
	(anElement hasAttribute: self attributeSymbol) ifTrue: [ ^ self ].
	anElement attributeAt: self attributeSymbol put: anElement extent.
	self setExtent: (desiredExtent rtValue: anElement) for: anElement after: [].
]

{ #category : #initialization }
RTMouseHoverZoom >> initialize [
	super initialize.
	desiredExtent := [ :anElement | anElement extent * 1.3 ].
	self animated.
]

{ #category : #hooks }
RTMouseHoverZoom >> initializeElement: element [
	element when: TRMouseEnter do: [ :anEvent |
		self doZoomEfect: element.
		"anEvent signalUpdate." ].
	element when: TRMouseLeave do: [ :anEvent |
		self undoZoomEfect: element.
		"anEvent signalUpdate." ]
]

{ #category : #private }
RTMouseHoverZoom >> setExtent: newExtent for: anElement after: aBlock [
	resizeStrategy cull: anElement cull: newExtent cull: aBlock
]

{ #category : #public }
RTMouseHoverZoom >> simple [
	resizeStrategy := [ :anElement :newExtent :afterBlock |
		anElement extent: newExtent.
		afterBlock value.
		anElement signalUpdate. ].
]

{ #category : #private }
RTMouseHoverZoom >> undoZoomEfect: anElement [
	| previousExtent |
	previousExtent := anElement attributeAt: self attributeSymbol ifAbsent: [ ^ self ].
	self setExtent: previousExtent for: anElement after: [ anElement removeAttributeAt: self attributeSymbol ifAbsent: [ nil ] ]

]
