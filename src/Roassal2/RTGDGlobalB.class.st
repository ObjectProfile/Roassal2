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
			
				"Set the min and max size"
				"self minAndMaxSizeOf: el"
			] 
		]. 
]
