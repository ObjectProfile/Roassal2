Class {
	#name : #RTGDGlobalB,
	#superclass : #Object,
	#instVars : [
		'conditionalShapes'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #'as yet unclassified' }
RTGDGlobalB >> executeOn: aView [
	|normalizer |
	
	conditionalShapes do: [ :array|
		"array = {condition. metricBlock . colors}"
		| max min condition metricBlock colors |
		condition := array first.
		metricBlock := array second.
		colors := array third.
		
		min := 1000000.
		max := 0.
		aView elements do: [ :el | 
			| t |
			t := metricBlock rtValue: el model.
			min := min min: t.
			max := max max: t ].
		
		normalizer := RTMultiLinearColor new colors: colors.
		aView elements do: [ :el | 
			(condition rtValue: el model)
				ifTrue: [ el trachelShape color: (normalizer level: (((metricBlock rtValue: el model) - min) / max)) ] ]
		 ]
	
	
]

{ #category : #'as yet unclassified' }
RTGDGlobalB >> for: condition normalizeColor: metricBlock using: colors [
	conditionalShapes add: (Array with: condition with: metricBlock with: colors)
]

{ #category : #'as yet unclassified' }
RTGDGlobalB >> initialize [
	super initialize.
	conditionalShapes := OrderedCollection new
]

{ #category : #'as yet unclassified' }
RTGDGlobalB >> normalizeColor: metricBlock using: colors [
	^ self for: true normalizeColor: metricBlock using: colors
]
