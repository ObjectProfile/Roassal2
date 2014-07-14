Class {
	#name : #RTMetricNormalizer,
	#superclass : #RTObject,
	#instVars : [
		'elements'
	],
	#category : #'Roassal2-ColorNormalizer'
}

{ #category : #'as yet unclassified' }
RTMetricNormalizer >> alphaColor: anAlphaValue [
	"Set an alpha color (transparency) for nodes"
	"aFloat has to be between 0.0 and 1.0"
	elements do: [ :el | 
				el trachelShape color: (el trachelShape color alpha: anAlphaValue) ] 
		 
]

{ #category : #'as yet unclassified' }
RTMetricNormalizer >> elements: someElements [
	elements := someElements
]

{ #category : #'as yet unclassified' }
RTMetricNormalizer >> initialize [
	super initialize.
	elements := OrderedCollection new
]

{ #category : #'as yet unclassified' }
RTMetricNormalizer >> maxSize: anInteger [
	"aBlock is evaluated on each node model. 
	Set the maximum size of each element"
	elements do: [ :el | 
		el trachelShape extent: (el trachelShape extent min: anInteger @ anInteger) ]
]

{ #category : #'as yet unclassified' }
RTMetricNormalizer >> normalizeColor: metricBlock [
	"aBlock is evaluated on each node model. 
	 Colors is an array of colors used to do the fading"
	^ self normalizeColor: metricBlock using: (Array with: Color gray with: Color red)
]

{ #category : #'as yet unclassified' }
RTMetricNormalizer >> normalizeColor: metricBlock using: colors [
	"aBlock is evaluated on each node model. 
	 Colors is an array of colors used to do the fading"
	^ self normalizeColor: metricBlock using: colors using: #yourself
]

{ #category : #'as yet unclassified' }
RTMetricNormalizer >> normalizeColor: metricBlock using: colors using: transformation [
	"aBlock is evaluated on each node model. 
	 Colors is an array of colors used to do the fading"
	
	| min max normalizer |
	"We get the min and the max of the metric for all the elements"
	min := 1000000.
	max := 0.
	elements do: [ :el | 
		| t |  
		t := transformation rtValue: (metricBlock rtValue: el model).
		min := min min: t.
		max := max max: t ].
	max ~= 0 ifTrue: [ 
		normalizer := RTMultiLinearColor new colors: colors.
		elements do: [ :el |  
			el trachelShape color: (normalizer level: (((transformation rtValue: (metricBlock rtValue: el model)) - min) / max)) ] ] 
]

{ #category : #'as yet unclassified' }
RTMetricNormalizer >> normalizeColorUsing: colors [
	^ self normalizeColor: #yourself using: colors
]

{ #category : #'as yet unclassified' }
RTMetricNormalizer >> normalizePosition: metricBlock min: minValue max: maxValue [
	"metricBlock is evaluated on each node model. 
	 minValue and maxValue are integer representing the minimum and maximum size in pixels for each node"
	self normalizePosition: metricBlock min: minValue max: maxValue using: #yourself
]

{ #category : #'as yet unclassified' }
RTMetricNormalizer >> normalizePosition: metricBlock min: min max: max using: transformation [
	"aBlock is evaluated on each node model"
	
	| minValue maxValue |
	"We get the min and the max of the metric for all the elements"
	minValue := 1000000.
	maxValue := -1000000.
	elements do: [ :el | 
		| t |  
		t := transformation rtValue: (metricBlock rtValue: el model).
		minValue := minValue min: t.
		maxValue := maxValue max: t ].
	
	(maxValue - minValue) ~= (0 @ 0) ifTrue: [ 
		elements do: [ :el | 
			| tt t |
			t := transformation rtValue: (metricBlock rtValue: el model).
			"tt := minValue + (maxValue * (t - min) / max) asInteger."
			tt := min + ((max - min) * ( (t - minValue) / (maxValue - minValue))) asIntegerPoint.
			el translateBy: tt ] ] 

]

{ #category : #'as yet unclassified' }
RTMetricNormalizer >> normalizeSize: metricBlock min: minValue max: maxValue [
	"metricBlock is evaluated on each node model. 
	 minValue and maxValue are integer representing the minimum and maximum size in pixels for each node"
	self normalizeSize: metricBlock min: minValue max: maxValue using: #yourself
]

{ #category : #'as yet unclassified' }
RTMetricNormalizer >> normalizeSize: metricBlock min: min max: max using: transformation [
	"aBlock is evaluated on each node model. 
	 Colors is an array of colors used to do the fading"
	
	| minValue maxValue |
	"We get the min and the max of the metric for all the elements"
	minValue := 1000000.
	maxValue := -1000000.
	elements do: [ :el | 
		| t |  
		t := transformation rtValue: (metricBlock rtValue: el model).
		minValue := minValue min: t.
		maxValue := maxValue max: t ].
	
	
	(maxValue - minValue) ~= 0 ifTrue: [
		elements do: [ :el | 
			| tt t |
			t := transformation rtValue: (metricBlock rtValue: el model).
			"tt := minValue + (maxValue * (t - min) / max) asInteger."
			tt := min + ((max - min) * ( (t - minValue) / (maxValue - minValue))) asInteger.
			el trachelShape extent: tt @ tt ] ] 
	
	
]

{ #category : #'as yet unclassified' }
RTMetricNormalizer >> normalizeX: metricBlock min: minValue max: maxValue [
	"metricBlock is evaluated on each node model. 
	 minValue and maxValue are integer representing the minimum and maximum size in pixels for each node"
	self normalizeX: metricBlock min: minValue max: maxValue using: #yourself
]

{ #category : #'as yet unclassified' }
RTMetricNormalizer >> normalizeX: metricBlock min: min max: max using: transformation [
	"aBlock is evaluated on each node model. 
	 Colors is an array of colors used to do the fading"
	
	| minValue maxValue |
	"We get the min and the max of the metric for all the elements"
	minValue := 1000000.
	maxValue := -1000000.
	elements do: [ :el | 
		| t |  
		t := transformation rtValue: (metricBlock rtValue: el model).
		minValue := minValue min: t.
		maxValue := maxValue max: t ].
	
	(maxValue - minValue) ~= 0 ifTrue: [
		elements do: [ :el | 
			| tt t |
			t := transformation rtValue: (metricBlock rtValue: el model).
			"tt := minValue + (maxValue * (t - min) / max) asInteger."
			tt := min + ((max - min) * ( (t - minValue) / (maxValue - minValue))) asInteger.
			el translateBy: tt @ 0 ] ] 
]

{ #category : #'as yet unclassified' }
RTMetricNormalizer >> normalizeY: metricBlock min: minValue max: maxValue [
	"metricBlock is evaluated on each node model. 
	 minValue and maxValue are integer representing the minimum and maximum size in pixels for each node"

	self normalizeY: metricBlock min: minValue max: maxValue using: #yourself
]

{ #category : #'as yet unclassified' }
RTMetricNormalizer >> normalizeY: metricBlock min: min max: max using: transformation [
	"aBlock is evaluated on each node model. 
	 Colors is an array of colors used to do the fading"
	
	| minValue maxValue |
	"We get the min and the max of the metric for all the elements"
	minValue := 1000000.
	maxValue := -1000000.
	elements do: [ :el | 
		| t |  
		t := transformation rtValue: (metricBlock rtValue: el model).
		minValue := minValue min: t.
		maxValue := maxValue max: t ].
	
	(maxValue - minValue) ~= 0 ifTrue: [ 
		elements do: [ :el | 
			| tt t |
			t := transformation rtValue: (metricBlock rtValue: el model).
			"tt := minValue + (maxValue * (t - min) / max) asInteger."
			tt := min + ((max - min) * ( (t - minValue) / (maxValue - minValue))) asInteger.
			el translateBy: 0 @ tt ] ] 
]
