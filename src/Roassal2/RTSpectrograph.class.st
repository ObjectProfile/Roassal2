Class {
	#name : #RTSpectrograph,
	#superclass : #RTBuilder,
	#instVars : [
		'objects',
		'lineBlock',
		'pointSize',
		'highlightBlock'
	],
	#category : #'Roassal2-Builder-Spectrograph'
}

{ #category : #'as yet unclassified' }
RTSpectrograph >> createShapeBuilder [
	^ super createShapeBuilder rectangle
]

{ #category : #'as yet unclassified' }
RTSpectrograph >> createView [
	^ super createView @ RTDraggableView
]

{ #category : #'as yet unclassified' }
RTSpectrograph >> highlight: aBlockOrValue [
	^ self highlight: aBlockOrValue color: Color red
]

{ #category : #'as yet unclassified' }
RTSpectrograph >> highlight: aBlockOrValue color: aColor [
	shapeBuilder
		if: [ :v | aBlockOrValue value: v first value: v second ] fillColor: aColor.

]

{ #category : #'as yet unclassified' }
RTSpectrograph >> initialize [
	super initialize.
]

{ #category : #accessing }
RTSpectrograph >> lineBlock [
	^ lineBlock
]

{ #category : #accessing }
RTSpectrograph >> lineBlock: anObject [
	lineBlock := anObject
]

{ #category : #accessing }
RTSpectrograph >> objects [
	^ objects
]

{ #category : #accessing }
RTSpectrograph >> objects: anObject [
	objects := anObject
]

{ #category : #accessing }
RTSpectrograph >> pointSize: anObject [
	shapeBuilder current size: pointSize 
]

{ #category : #'as yet unclassified' }
RTSpectrograph >> renderIn: aView [

	| rowsOfElements es interaction |
	interaction := RTPopup new.
	rowsOfElements := OrderedCollection new.
	
	objects do: [ :o | 	
		es := shapeBuilder elementsOn: ((lineBlock rtValue: o) collect: [ :computedObject | { o . computedObject } ]).
		
		RTVerticalLineLayout new gapSize: 0; on: es.
		rowsOfElements add: es.
		aView addAll: es.
		interactionBuilder setUpElements: es
	].
	RTHorizontalLineLayout new alignBottom; gapSize: 0; on: rowsOfElements.
	
	
]
