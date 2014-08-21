Class {
	#name : #RTInteractionTest,
	#superclass : #RTTest,
	#instVars : [
		'view',
		'ui'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTInteractionTest >> setUp [
	super setUp.
	view := RTView new.
]

{ #category : #'as yet unclassified' }
RTInteractionTest >> tearDown [
	super tearDown.
	ui ifNotNil: [ :aUI | ui := nil. aUI delete. ].
]

{ #category : #'as yet unclassified' }
RTInteractionTest >> testMouseHoverZoom [
	| element interaction |
	element := RTBox new size: #yourself; elementOn: 30.
	interaction := RTMouseHoverZoom new.
	interaction desiredExtent: 60 @ 60; simple.
	element @ interaction.
	view add: element.
	self assert: element extent equals: 30 @ 30.
	element testCaseAnnounce: TRMouseEnter.
	self assert: element extent equals: 60 @ 60.
	element testCaseAnnounce: TRMouseLeave.
	self assert: element extent equals: 30 @ 30.
	
]
