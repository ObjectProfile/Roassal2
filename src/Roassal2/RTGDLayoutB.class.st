Class {
	#name : #RTGDLayoutB,
	#superclass : #Object,
	#instVars : [
		'conditionalLayout'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #'as yet unclassified' }
RTGDLayoutB >> executeOn: view [
	| condition layout elementsToLayout |
	conditionalLayout do: [ :array |
		condition := array first.
		layout := array second.
		
		elementsToLayout := view elements select: [ :e | condition rtValue: e model ].
		layout on: elementsToLayout edges: view edges.
		]
]

{ #category : #'as yet unclassified' }
RTGDLayoutB >> for: condition use: aLayout [
	conditionalLayout add: (Array with: condition with: aLayout)
]

{ #category : #'as yet unclassified' }
RTGDLayoutB >> initialize [
	super initialize.
	conditionalLayout := OrderedCollection new
]
