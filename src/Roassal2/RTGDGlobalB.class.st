Class {
	#name : #RTGDGlobalB,
	#superclass : #Object,
	#instVars : [
		'conditionalShapes',
		'minSize',
		'maxSize'
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
		
		"We get the min and the max of the metric for all the elements"
		min := 1000000.
		max := 0.
		aView elements do: [ :el | 
			| t |
			t := metricBlock rtValue: el model.
			min := min min: t.
			max := max max: t ].
		
		normalizer := RTMultiLinearColor new colors: colors.
		aView elements do: [ :el | 
				"We set the color"
				(condition rtValue: el model)
					ifTrue: [ el trachelShape color: (normalizer level: (((metricBlock rtValue: el model) - min) / max)) ].

				"Set the min and max size"
				self minAndMaxSizeOf: el
			].
			
			
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
RTGDGlobalB >> maxSize: aSize [
	 maxSize := aSize
]

{ #category : #'as yet unclassified' }
RTGDGlobalB >> minAndMaxSizeOf: anRTElement [
	(minSize notNil and: [ anRTElement trachelShape extent < (minSize @ minSize) ]) 
		ifTrue: [ anRTElement trachelShape extent: minSize @ minSize ].
		
	(maxSize notNil and: [ anRTElement trachelShape size > (maxSize @ maxSize) ]) 
		ifTrue: [ anRTElement trachelShape extent: maxSize @ maxSize ].
]

{ #category : #'as yet unclassified' }
RTGDGlobalB >> minSize: aSize [
	 minSize := aSize
]

{ #category : #'as yet unclassified' }
RTGDGlobalB >> normalizeColor: metricBlock using: colors [
	^ self for: true normalizeColor: metricBlock using: colors
]
