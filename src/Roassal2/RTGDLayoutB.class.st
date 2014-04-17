Class {
	#name : #RTGDLayoutB,
	#superclass : #RTGDElement,
	#instVars : [
		'layout'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #'as yet unclassified' }
RTGDLayoutB >> circle [
	^ self use: RTCircleLayout new
]

{ #category : #'as yet unclassified' }
RTGDLayoutB >> execute [
	layout 
		on: (self view elements select: [ :e | condition rtValue: e model ]) 
		edges: graphBuilder edgesUsedForLayout

]

{ #category : #'as yet unclassified' }
RTGDLayoutB >> force [
	^ self use: RTForceBasedLayout new
]

{ #category : #'as yet unclassified' }
RTGDLayoutB >> grid [
	^ self use: RTGridLayout new
]

{ #category : #'as yet unclassified' }
RTGDLayoutB >> initialize [
	super initialize.
	self if: true
]

{ #category : #'as yet unclassified' }
RTGDLayoutB >> tree [
	^ self use: RTTreeLayout new
]

{ #category : #'as yet unclassified' }
RTGDLayoutB >> use: aLayout [
	layout := aLayout.
	^ aLayout
]
