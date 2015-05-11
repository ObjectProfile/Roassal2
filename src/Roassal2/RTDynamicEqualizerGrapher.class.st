Class {
	#name : #RTDynamicEqualizerGrapher,
	#superclass : #RTAbstractGrapher,
	#instVars : [
		'metrics',
		'lastObject'
	],
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #'public - metrics' }
RTDynamicEqualizerGrapher >> addName: aString metric: aBlockClosureOrSymbol [ 
	metrics add: (Array with: aString with: aBlockClosureOrSymbol)
]

{ #category : #'as yet unclassified' }
RTDynamicEqualizerGrapher >> example01 [
	"
	self new example01
	"
	| b |
	b := RTDynamicEqualizerGrapher new. 
	b maxY: 20.
	b minY: 20.
	b addName: 'X1' metric: [ :anArray | anArray first ].
	b addName: 'Y1' metric: [ :anArray | anArray second ].
	b addName: 'Z1' metric: [ :anArray | anArray third ].
	b addName: 'X2' metric: [ :anArray | anArray fourth ].
	b addName: 'Y2' metric: [ :anArray | anArray fifth ].
	b addName: 'Z2' metric: [ :anArray | anArray sixth ].

	b view addMenu: 'Generate' callback: [ b object: ((1 to: 6) collect: [ :ii | 40 atRandom - 20]) ].
	^ b
]

{ #category : #'as yet unclassified' }
RTDynamicEqualizerGrapher >> initialize [
	super initialize.
	metrics := OrderedCollection new
]

{ #category : #'as yet unclassified' }
RTDynamicEqualizerGrapher >> numberOfMetrics [
	^ metrics size
]

{ #category : #'as yet unclassified' }
RTDynamicEqualizerGrapher >> renderIn: aView [

	^ super renderIn: aView
	
]
