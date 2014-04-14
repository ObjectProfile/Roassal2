Class {
	#name : #RTGDLayoutB,
	#superclass : #RTGDElement,
	#instVars : [
		'conditionalLayout'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #convenient }
RTGDLayoutB >> cluster [
	^ self use: (RTClusterLayout new)
]

{ #category : #'as yet unclassified' }
RTGDLayoutB >> edgesForLayout [
	^ self graphBuilder edgesForLayout
]

{ #category : #'as yet unclassified' }
RTGDLayoutB >> edgesUsedByLayout [
	^ self graphBuilder edgesUsedByLayout
]

{ #category : #'as yet unclassified' }
RTGDLayoutB >> executeOn: view [
	| condition layout elementsToLayout |
	conditionalLayout do: [ :array |
		condition := array first.
		layout := array second.
		
		elementsToLayout := view elements select: [ :e | condition rtValue: e model ].
		layout on: elementsToLayout edges: self edgesUsedByLayout
		]
]

{ #category : #'as yet unclassified' }
RTGDLayoutB >> for: condition use: aLayout [
	conditionalLayout add: (Array with: condition with: aLayout).
	^ aLayout
]

{ #category : #convenient }
RTGDLayoutB >> grid [
	^ self use: RTGridLayout new
]

{ #category : #'as yet unclassified' }
RTGDLayoutB >> initialize [
	super initialize.
	conditionalLayout := OrderedCollection new
]

{ #category : #'as yet unclassified' }
RTGDLayoutB >> use: aLayout [
	^ self for: true use: aLayout
]
