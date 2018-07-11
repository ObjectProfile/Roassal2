Class {
	#name : #RTInteractiveComposer,
	#superclass : #RTObject,
	#instVars : [
		'rules'
	],
	#category : #'Roassal2-InteractiveComposer'
}

{ #category : #'as yet unclassified' }
RTInteractiveComposer >> for: aClass do: oneArgBlock [
	self if: [ :obj | obj class inheritsFrom: aClass ] do: oneArgBlock
]

{ #category : #'as yet unclassified' }
RTInteractiveComposer >> forCollectionOf: aClass do: oneArgBlock [
	self if: [ :obj | (obj isCollection and: [ obj notEmpty ]) and: [ obj anyOne class inheritsFrom: aClass ] ] do: oneArgBlock
]

{ #category : #'as yet unclassified' }
RTInteractiveComposer >> if: aPredicateAsOneArgBlock do: oneArgBlock [
	rules add: (aPredicateAsOneArgBlock -> oneArgBlock).
]

{ #category : #'as yet unclassified' }
RTInteractiveComposer >> initialize [
	super initialize.
	rules := OrderedCollection new
]

{ #category : #'as yet unclassified' }
RTInteractiveComposer >> openOn: anObject [
	| r builderOrView |
	r := (self ruleFor: anObject).
	builderOrView := (r value rtValue: anObject).
	self prepareForInteraction: builderOrView.
	builderOrView open
]

{ #category : #'as yet unclassified' }
RTInteractiveComposer >> prepareForInteraction: aViewOrBuilder [
	| view |
	aViewOrBuilder build.
	view := aViewOrBuilder view.
	 
	view elements when: TRMouseClick do: [ :evt |
		self openOn: evt element model
	]
]

{ #category : #'as yet unclassified' }
RTInteractiveComposer >> ruleFor: anObject [
	^ rules detect: [ :assoc | assoc key value: anObject ]
]
