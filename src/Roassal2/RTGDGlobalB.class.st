Class {
	#name : #RTGDGlobalB,
	#superclass : #RTGDElement,
	#instVars : [
		'alphaColor'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #'as yet unclassified' }
RTGDGlobalB >> alphaColor:  anAlphaColor [
	"aFloat has to be between 0.0 and 1.0"
	self addProperty: [
		self view elements do: [ :el | 
				el trachelShape color: (el trachelShape color alpha: anAlphaColor)
			] 
		]. 
]

{ #category : #'as yet unclassified' }
RTGDGlobalB >> execute [

	properties do: #value
]

{ #category : #'as yet unclassified' }
RTGDGlobalB >> initialize [
	super initialize.
	alphaColor := 1.0
]

{ #category : #'as yet unclassified' }
RTGDGlobalB >> minSize: anInteger [
	"aBlock is evaluated on each node model. 
	Set the minimum size of each element"
	self addProperty: [
		self view elements do: [ :el | 
				"We set the color"
				(condition rtValue: el model)
					ifTrue: [ el trachelShape extent: (el trachelShape extent max: anInteger @ anInteger) ]
					ifFalse: [ el trachelShape color: (el trachelShape color alpha: alphaColor) ].
			] 
		]. 
]

{ #category : #'as yet unclassified' }
RTGDGlobalB >> normalizeColor: metricBlock using: colors [
	"aBlock is evaluated on each node model. 
	 Colors is an array of colors used to do the fading"
	^ self normalizeColor: metricBlock using: colors transformation: #yourself
]

{ #category : #'as yet unclassified' }
RTGDGlobalB >> normalizeColor: metricBlock using: colors transformation: transformation [
	"aBlock is evaluated on each node model. 
	 Colors is an array of colors used to do the fading"
	self addProperty: [
		| min max normalizer |
		"We get the min and the max of the metric for all the elements"
		min := 1000000.
		max := 0.
		self view elements do: [ :el | 
			| t |  
			t := transformation rtValue: (metricBlock rtValue: el model).
			min := min min: t.
			max := max max: t ].
		
		normalizer := RTMultiLinearColor new colors: colors.
		self view elements do: [ :el | 
				"We set the color"
				(condition rtValue: el model)
					ifTrue: [ el trachelShape color: ((normalizer level: (((transformation rtValue: (metricBlock rtValue: el model)) - min) / max)) alpha: alphaColor) ]
					ifFalse: [ el trachelShape color: (el trachelShape color alpha: alphaColor) ].
			] 
		]. 
]

{ #category : #'as yet unclassified' }
RTGDGlobalB >> normalizeSize: metricBlock min: minValue max: maxValue [
	"metricBlock is evaluated on each node model. 
	 minValue and maxValue are integer representing the minimum and maximum size in pixels for each node"
	self normalizeSize: metricBlock min: minValue max: maxValue using: #yourself
]

{ #category : #'as yet unclassified' }
RTGDGlobalB >> normalizeSize: metricBlock min: minValue max: maxValue using: transformation [
	"metricBlock is evaluated on each node model. 
	 minValue and maxValue are integer representing the minimum and maximum size in pixels for each node"
	"transformation is a function that takes as argument the result of a metric and return the metric transformed"
	self addProperty: [	
		| min max ellsToConsider t |
		min := 100000.
		max := -100000.
		ellsToConsider := OrderedCollection new.
		self view elements do: [ :el | 	
				t := transformation rtValue: (metricBlock rtValue: el model).
				min := min min: t.
				max := max max: t.
				ellsToConsider add: el ].
	
		ellsToConsider do: [ :el | 
			| tt |
			t := transformation rtValue: (metricBlock rtValue: el model).
			tt := minValue + (maxValue * (t - min) / (max + 1)) asInteger.
			el trachelShape extent: tt @ tt ]
		]
]
