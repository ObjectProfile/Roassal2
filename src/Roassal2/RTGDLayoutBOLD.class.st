Class {
	#name : #RTGDLayoutBOLD,
	#superclass : #RTGDElement,
	#instVars : [
		'conditionalLayout'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #convenient }
RTGDLayoutBOLD >> cluster [
	^ self use: (RTClusterLayout new)
]

{ #category : #'as yet unclassified' }
RTGDLayoutBOLD >> edgesForLayout [
	^ self graphBuilder edgesForLayout
]

{ #category : #'as yet unclassified' }
RTGDLayoutBOLD >> edgesUsedByLayout [
	^ self graphBuilder edgesUsedByLayout
]

{ #category : #'as yet unclassified' }
RTGDLayoutBOLD >> executeOn: view [
	| condition layout elementsToLayout |
	conditionalLayout do: [ :array |
		condition := array first.
		layout := array second.
		
		elementsToLayout := view elements select: [ :e | condition rtValue: e model ].
		layout on: elementsToLayout edges: self edgesUsedByLayout
		]
]

{ #category : #'as yet unclassified' }
RTGDLayoutBOLD >> for: condition use: aLayout [
	conditionalLayout add: (Array with: condition with: aLayout).
	^ aLayout
]

{ #category : #convenient }
RTGDLayoutBOLD >> forceBased [
	^ self use: RTForceBasedLayout new
]

{ #category : #convenient }
RTGDLayoutBOLD >> grid [
	^ self use: RTGridLayout new
]

{ #category : #'as yet unclassified' }
RTGDLayoutBOLD >> initialize [
	super initialize.
	conditionalLayout := OrderedCollection new
]

{ #category : #'as yet unclassified' }
RTGDLayoutBOLD >> use: aLayout [
	^ self for: true use: aLayout
]
