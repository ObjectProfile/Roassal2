Class {
	#name : #RTGDGlobalB,
	#superclass : #RTGDElement,
	#instVars : [
		'alphaColor'
	],
	#category : #'Roassal2-Builder-Graph'
}

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
	self addProperty: [
		| min max normalizer |
		"We get the min and the max of the metric for all the elements"
		min := 1000000.
		max := 0.
		self view elements do: [ :el | 
			| t |  
			t := metricBlock rtValue: el model.
			min := min min: t.
			max := max max: t ].
		
		normalizer := RTMultiLinearColor new colors: colors.
		self view elements do: [ :el | 
				"We set the color"
				(condition rtValue: el model)
					ifTrue: [ el trachelShape color: ((normalizer level: (((metricBlock rtValue: el model) - min) / max)) alpha: alphaColor) ]
					ifFalse: [ el trachelShape color: (el trachelShape color alpha: alphaColor) ].
			] 
		]. 
]

{ #category : #'as yet unclassified' }
RTGDGlobalB >> normalizeSize: metricBlock min: minValue max: maxValue [
	"metricBlock is evaluated on each node model. 
	 minValue and maxValue are integer representing the minimum and maximum size in pixels for each node"
	self addProperty: [	
		| min max ellsToConsider t |
		min := 100000.
		max := -100000.
		ellsToConsider := OrderedCollection new.
		self view elements do: [ :el | 	
				t := metricBlock rtValue: el model.
				min := min min: t.
				max := max max: t.
				ellsToConsider add: el ].
	
		ellsToConsider do: [ :el | 
			| tt |
			t := metricBlock rtValue: el model.
			tt := minValue + (maxValue * (t - min) / (max + 1)) asInteger.
			el trachelShape extent: tt @ tt ]
		]
]
