Class {
	#name : #RTGDGlobalBOLD,
	#superclass : #RTGDElement,
	#instVars : [
		'conditionalShapes',
		'minSize',
		'maxSize',
		'normalizeSize',
		'alphaColor'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #'as yet unclassified' }
RTGDGlobalBOLD >> alphaColor: aFloat [
	"aFloat = 1.0 no color transparency"
	"aFloat = 0.0 fully transparent"
	 alphaColor := aFloat
]

{ #category : #'as yet unclassified' }
RTGDGlobalBOLD >> executeOn: aView [
	| normalizer  ellsToConsider |
	
	normalizeSize do: [ :array |
		| condition metric t min max minValueInPixels maxValueInPixels |
		condition := array first.
		metric := array second.
		minValueInPixels := array third.
		maxValueInPixels := array fourth.
	
		min := 100000.
		max := -100000.
		ellsToConsider := OrderedCollection new.
		aView elements do: [ :el | 		
						(condition rtValue: el model)
							ifTrue: [ 
								t := metric rtValue: el model.
								min := min min: t.
								max := max max: t.
								ellsToConsider add: el ] ].
	
		ellsToConsider do: [ :el | 
			| tt |
			t := metric rtValue: el model.
			tt := minValueInPixels + (maxValueInPixels * (t - min) / (max + 1)) asInteger.
			el trachelShape extent: tt @ tt]
		].
	
		
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
					ifTrue: [ el trachelShape color: ((normalizer level: (((metricBlock rtValue: el model) - min) / max)) alpha: alphaColor) ]
					ifFalse: [ el trachelShape color: (el trachelShape color alpha: alphaColor) ].
			
				"Set the min and max size"
					self minAndMaxSizeOf: el
			].
		 ].
	
	"Set the transparency"
	aView elements do: [ :el | 
		el trachelShape color: (el trachelShape color alpha: alphaColor) ].
	


]

{ #category : #'as yet unclassified' }
RTGDGlobalBOLD >> for: condition normalizeColor: metricBlock using: colors [
	conditionalShapes add: (Array with: condition with: metricBlock with: colors)
]

{ #category : #'as yet unclassified' }
RTGDGlobalBOLD >> for: condition normalizeSize: metricBlock min: minValue max: maxValue [
	normalizeSize add: (Array with: condition with: metricBlock with: minValue with: maxValue)
]

{ #category : #'as yet unclassified' }
RTGDGlobalBOLD >> initialize [
	super initialize.
	conditionalShapes := OrderedCollection new.
	normalizeSize := OrderedCollection new.
	alphaColor := 1.0
]

{ #category : #'as yet unclassified' }
RTGDGlobalBOLD >> maxSize: aSize [
	 maxSize := aSize
]

{ #category : #'as yet unclassified' }
RTGDGlobalBOLD >> minAndMaxSizeOf: anRTElement [
	
	(minSize notNil and: [ anRTElement trachelShape extent < (minSize @ minSize) ]) 
		ifTrue: [ anRTElement trachelShape extent: minSize @ minSize ].
		
	(maxSize notNil and: [ anRTElement trachelShape size > (maxSize @ maxSize) ]) 
		ifTrue: [ anRTElement trachelShape extent: maxSize @ maxSize ].
]

{ #category : #'as yet unclassified' }
RTGDGlobalBOLD >> minSize: aSize [
	 minSize := aSize
]

{ #category : #'as yet unclassified' }
RTGDGlobalBOLD >> normalizeColor: metricBlock using: colors [
	^ self for: true normalizeColor: metricBlock using: colors
]

{ #category : #'as yet unclassified' }
RTGDGlobalBOLD >> normalizeSize: metricBlock [
	^ self for: true normalizeSize: metricBlock
]

{ #category : #'as yet unclassified' }
RTGDGlobalBOLD >> normalizeSize: metricBlock min: minValue max: maxValue [
	^ self for: true normalizeSize: metricBlock min: minValue max: maxValue
]
