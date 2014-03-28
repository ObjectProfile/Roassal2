Class {
	#name : #RTGDNodeB,
	#superclass : #Object,
	#instVars : [
		'conditionalShapes'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #accessing }
RTGDNodeB >> conditionalShapes [
	"Return a collection of arrays. Each array has a size of 2. First is a condition, second is a shape"
	^ conditionalShapes
]

{ #category : #hooks }
RTGDNodeB >> createElementFor: object [
	| shape |
	shape := (conditionalShapes detect: [ :arr | arr first rtValue: object ]) second.
	^ shape elementOn: object
	
]

{ #category : #public }
RTGDNodeB >> if: condition shape: aShape [
	conditionalShapes add: (Array with: condition with: aShape)
]

{ #category : #initialization }
RTGDNodeB >> initialize [
	super initialize.
	conditionalShapes := OrderedCollection new
]
