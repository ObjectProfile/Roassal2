Class {
	#name : #RTLayerBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'objectLayers',
		'verticalGap',
		'horizontalGap'
	],
	#category : #'Roassal2-Builder-Layer'
}

{ #category : #adding }
RTLayerBuilder >> addLayer: objects [
	objectLayers add: objects
]

{ #category : #examples }
RTLayerBuilder >> example01 [
	"self new example01"

	| b |
	b := RTLayerBuilder new.
	b addLayer: 'ABC'.
	b addLayer: 'BCA'.
	b addLayer: 'DEFA'.
	b open
]

{ #category : #examples }
RTLayerBuilder >> example02 [
	"self new example02"

	| b |
	b := RTLayerBuilder new.
	b shape circle 
		size: 20; withText;
		if: [ :o | o = $A ] fillColor: Color red;
		if: [ :o | o = $C ] fillColor: Color blue.
	b verticalGap: 30.
	b horizontalGap: 40.
	b addLayer: 'ABC'.
	b addLayer: 'BCA'.
	b addLayer: 'DEFA'.
	b open
]

{ #category : #examples }
RTLayerBuilder >> example03 [
	"self new example03"

	| b |
	b := RTLayerBuilder new.
	b shape circle 
		size: 20; withText.
	b verticalGap: 30.
	b horizontalGap: 40.
	b addLayer: 'ABC'.
	b addLayer: 'BCA'.
	b addLayer: 'DEFA'.
	b open
]

{ #category : #accessing }
RTLayerBuilder >> horizontalGap [
	^ horizontalGap
]

{ #category : #accessing }
RTLayerBuilder >> horizontalGap: anObject [
	horizontalGap := anObject
]

{ #category : #initialization }
RTLayerBuilder >> initialize [
	super initialize.
	objectLayers := OrderedCollection new.
	verticalGap := 5.
	horizontalGap := 5
]

{ #category : #hooks }
RTLayerBuilder >> renderIn: aView [
	| elementsLayer topLayer currentLayer |
	"We draw the nodes"
	elementsLayer := objectLayers collect: [ :objects | self elementsWithInteractionOn: objects ].
	elementsLayer do: [ :l | RTHorizontalLineLayout new horizontalGap: horizontalGap; on: l. aView addAll: l ].
	RTVerticalLineLayout new verticalGap: verticalGap; alignCenter; on: elementsLayer.

	"We draw the edges from one layer to the layer above"
	2 to: elementsLayer size do: [ :i |
		topLayer := elementsLayer at: (i - 1).
		currentLayer := elementsLayer at: i.
		currentLayer do: [ :currentElement | 
			| aboveElements |
			aboveElements := topLayer select: [ :el | el model = currentElement model ].
			view addAll: (RTLine edgesFrom: currentElement toAll: aboveElements) ]
	]
]

{ #category : #accessing }
RTLayerBuilder >> verticalGap [
	^ verticalGap
]

{ #category : #accessing }
RTLayerBuilder >> verticalGap: anObject [
	verticalGap := anObject
]
