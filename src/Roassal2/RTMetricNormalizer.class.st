Class {
	#name : #RTMetricNormalizer,
	#superclass : #RTObject,
	#instVars : [
		'elements'
	],
	#category : #'Roassal2-ColorNormalizer'
}

{ #category : #accessing }
RTMetricNormalizer >> alphaColor: anAlphaValue [
	"Set an alpha color (transparency) for nodes"
	"aFloat has to be between 0.0 and 1.0"
	elements do: [ :el | 
				el trachelShape color: (el trachelShape color alpha: anAlphaValue) ] 
		 
]

{ #category : #utility }
RTMetricNormalizer >> checkNotEmpty [
	"Raise an error if no elements have been added"
	elements ifEmpty: [ self error: 'Please specify what are the element I should operate on using #elements:' ]
]

{ #category : #accessing }
RTMetricNormalizer >> elements: someElements [
	elements := someElements
]

{ #category : #initialization }
RTMetricNormalizer >> initialize [
	super initialize.
	elements := OrderedCollection new
]

{ #category : #accessing }
RTMetricNormalizer >> maxSize: anInteger [
	"aBlock is evaluated on each node model. 
	Set the maximum size of each element"
	elements do: [ :el | 
		el trachelShape extent: (el trachelShape extent min: anInteger @ anInteger) ]
]

{ #category : #'public normalize color' }
RTMetricNormalizer >> normalizeColor: metricBlock [
	"aBlock is evaluated on each node model. 
	 Colors is an array of colors used to do the fading"
	^ self normalizeColor: metricBlock using: (Array with: Color gray with: Color red)
]

{ #category : #'public normalize color' }
RTMetricNormalizer >> normalizeColor: metricBlock using: colors [
	"aBlock is evaluated on each node model. 
	 Colors is an array of colors used to do the fading"
	^ self normalizeColor: metricBlock using: colors using: #yourself
]

{ #category : #'public normalize color' }
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

{ #category : #'public normalize color' }
RTMetricNormalizer >> normalizeColorUsing: colors [
	^ self normalizeColor: #yourself using: colors
]

{ #category : #'public normalize x' }
RTMetricNormalizer >> normalizeElementX: metricBlock min: min max: max minValue: minValue maxValue: maxValue [ 
	"
	metricBlock is evaluated on each element. 	

	min represent the X value of the minimum value.
	max represent the X value of the maximum value.
	
	minValue is the minimum value of the dataset.
	maxValue is the maximum value of the dataset.
	
	[ minValue ; maxValue ] is mapped to [ min ; max ]

	transformation is used to transform the metric value"
		
	self normalizeElementX: metricBlock min: min max: max minValue: minValue maxValue: maxValue using: #yourself
]

{ #category : #'public normalize x' }
RTMetricNormalizer >> normalizeElementX: metricBlock min: min max: max minValue: minValue maxValue: maxValue using: transformation [
	"
	metricBlock is evaluated on each element. 	

	min represent the X value of the minimum value.
	max represent the X value of the maximum value.
	
	minValue is the minimum value of the dataset.
	maxValue is the maximum value of the dataset.
	
	[ minValue ; maxValue ] is mapped to [ min ; max ]

	transformation is used to transform the metric value"
		
	(maxValue - minValue) ~= 0 ifTrue: [
		elements do: [ :el | 
			| tt t |
			t := transformation rtValue: (metricBlock rtValue: el).
			tt := min + ((max - min) * ( (t - minValue) / (maxValue - minValue))) asInteger.
			el translateBy: tt @ 0 ] ] 
]

{ #category : #'public normalize position' }
RTMetricNormalizer >> normalizePosition: metricBlock min: minValue max: maxValue [
	"metricBlock is evaluated on each node model. 
	 minValue and maxValue are integer representing the minimum and maximum size in pixels for each node"
	self normalizePosition: metricBlock min: minValue max: maxValue using: #yourself
]

{ #category : #'public normalize position' }
RTMetricNormalizer >> normalizePosition: metricBlock min: min max: max using: transformation [
	"aBlock is evaluated on each node model"
	
	| minValue maxValue |
	"We get the min and the max of the metric for all the elements"
	minValue := transformation rtValue: (metricBlock rtValue: elements anyOne model).
	maxValue := minValue.
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

{ #category : #'public normalize size' }
RTMetricNormalizer >> normalizeSize: metricBlock min: minValue max: maxValue [
	"metricBlock is evaluated on each node model. 
	 minValue and maxValue are integer representing the minimum and maximum size in pixels for each node"
	self normalizeSize: metricBlock min: minValue max: maxValue using: #yourself
]

{ #category : #'public normalize size' }
RTMetricNormalizer >> normalizeSize: metricBlock min: min max: max using: transformation [
	"aBlock is evaluated on each node model. 
	 Colors is an array of colors used to do the fading"
	
	| minValue maxValue |
	
	self checkNotEmpty.

	"We get the min and the max of the metric for all the elements"
	minValue := transformation rtValue: (metricBlock rtValue: elements anyOne model).
	maxValue := minValue.
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

{ #category : #'public normalize x' }
RTMetricNormalizer >> normalizeX: metricBlock min: minValue max: maxValue [
	"metricBlock is evaluated on each node model. 
	 minValue and maxValue are integer representing the minimum and maximum size in pixels for each node"
	self normalizeX: metricBlock min: minValue max: maxValue using: #yourself
]

{ #category : #'public normalize x' }
RTMetricNormalizer >> normalizeX: metricBlock min: min max: max minValue: minValue [
	"metricBlock is evaluated on each node model. 	
	 min represent the X value of the minimum value.
	 max represent the X value of the maximum value.
	 transformation is used to transform the metric value"
	
	^ self normalizeX: metricBlock min: min max: max minValue: minValue using: #yourself
]

{ #category : #'public normalize x' }
RTMetricNormalizer >> normalizeX: metricBlock min: min max: max minValue: minValue maxValue: maxValue [ 
	"
	metricBlock is evaluated on each node model. 	

	min represent the X value of the minimum value.
	max represent the X value of the maximum value.
	
	minValue is the minimum value of the dataset.
	maxValue is the maximum value of the dataset.
	
	[ minValue ; maxValue ] is mapped to [ min ; max ]
	"
		
	self normalizeX: metricBlock min: min max: max minValue: minValue maxValue: maxValue using: #yourself
]

{ #category : #'public normalize x' }
RTMetricNormalizer >> normalizeX: metricBlock min: min max: max minValue: minValue maxValue: maxValue using: transformation [
	"
	metricBlock is evaluated on each node model. 	

	min represent the X value of the minimum value.
	max represent the X value of the maximum value.
	
	minValue is the minimum value of the dataset.
	maxValue is the maximum value of the dataset.
	
	[ minValue ; maxValue ] is mapped to [ min ; max ]

	transformation is used to transform the metric value"
		
	(maxValue - minValue) ~= 0 ifTrue: [
		elements do: [ :el | 
			| tt t |
			t := transformation rtValue: (metricBlock rtValue: el model).
			tt := min + ((max - min) * ( (t - minValue) / (maxValue - minValue))) asInteger.
			el translateBy: tt @ 0 ] ] 
]

{ #category : #'public normalize x' }
RTMetricNormalizer >> normalizeX: metricBlock min: min max: max minValue: minValue using: transformation [
	"metricBlock is evaluated on each node model. 	
	 min represent the X value of the minimum value.
	 max represent the X value of the maximum value.
	 transformation is used to transform the metric value"
	
	| maxValue |
	"We get the min and the max of the metric for all the elements"
	maxValue := transformation rtValue: (metricBlock rtValue: elements anyOne model).
	elements do: [ :el | 
		| t |  
		t := transformation rtValue: (metricBlock rtValue: el model).
		maxValue := maxValue max: t ].
	
	self normalizeX: metricBlock min: min max: max minValue: minValue maxValue: maxValue using: transformation
]

{ #category : #'public normalize x' }
RTMetricNormalizer >> normalizeX: metricBlock min: min max: max using: transformation [
	"metricBlock is evaluated on each node model. 	
	 min represent the X value of the minimum value.
	 max represent the X value of the maximum value.
	 transformation is used to transform the metric value"
	
	| minValue maxValue |
	"We get the min and the max of the metric for all the elements"
	minValue := transformation rtValue: (metricBlock rtValue: elements anyOne model).
	maxValue := minValue.
	elements do: [ :el | 
		| t |  
		t := transformation rtValue: (metricBlock rtValue: el model).
		minValue := minValue min: t.
		maxValue := maxValue max: t ].
	
	self normalizeX: metricBlock min: min max: max minValue: minValue maxValue: maxValue using: transformation
]

{ #category : #'public normalize y' }
RTMetricNormalizer >> normalizeY: metricBlock min: minValue max: maxValue [
	"metricBlock is evaluated on each node model. 
	 minValue and maxValue are integer representing the minimum and maximum size in pixels for each node"
	self normalizeY: metricBlock min: minValue max: maxValue using: #yourself
]

{ #category : #'public normalize y' }
RTMetricNormalizer >> normalizeY: metricBlock min: min max: max minValue: minValue [
	"metricBlock is evaluated on each node model. 	
	 min represent the X value of the minimum value.
	 max represent the X value of the maximum value.
	 transformation is used to transform the metric value"
	
	^ self normalizeY: metricBlock min: min max: max minValue: minValue using: #yourself
]

{ #category : #'public normalize y' }
RTMetricNormalizer >> normalizeY: metricBlock min: min max: max minValue: minValue maxValue: maxValue [ 
	"
	metricBlock is evaluated on each node model. 	

	min represent the X value of the minimum value.
	max represent the X value of the maximum value.
	
	minValue is the minimum value of the dataset.
	maxValue is the maximum value of the dataset.
	
	[ minValue ; maxValue ] is mapped to [ min ; max ]
	"
		
	self normalizeY: metricBlock min: min max: max minValue: minValue maxValue: maxValue using: #yourself
]

{ #category : #'public normalize y' }
RTMetricNormalizer >> normalizeY: metricBlock min: min max: max minValue: minValue maxValue: maxValue using: transformation [
	"
	metricBlock is evaluated on each node model. 	

	min represent the Y value of the minimum value.
	max represent the Y value of the maximum value.
	
	minValue is the minimum value of the dataset.
	maxValue is the maximum value of the dataset.
	
	[ minValue ; maxValue ] is mapped to [ min ; max ]

	transformation is used to transform the metric value"
		
	(maxValue - minValue) ~= 0 ifTrue: [
		elements do: [ :el | 
			| tt t |
			t := transformation rtValue: (metricBlock rtValue: el model).
			tt := min + ((max - min) * ( (t - minValue) / (maxValue - minValue))) asInteger.
			el translateBy: 0 @ tt ] ] 
]

{ #category : #'public normalize y' }
RTMetricNormalizer >> normalizeY: metricBlock min: min max: max minValue: minValue using: transformation [
	"metricBlock is evaluated on each node model. 	
	 min represent the X value of the minimum value.
	 max represent the X value of the maximum value.
	 transformation is used to transform the metric value"
	
	| maxValue |
	"We get the min and the max of the metric for all the elements"
	maxValue := transformation rtValue: (metricBlock rtValue: elements anyOne model).
	elements do: [ :el | 
		| t |  
		t := transformation rtValue: (metricBlock rtValue: el model).
		maxValue := maxValue max: t ].
	
	self normalizeY: metricBlock min: min max: max minValue: minValue maxValue: maxValue using: transformation
]

{ #category : #'public normalize y' }
RTMetricNormalizer >> normalizeY: metricBlock min: min max: max using: transformation [
	"metricBlock is evaluated on each node model. 	
	 min represent the X value of the minimum value.
	 max represent the X value of the maximum value.
	 transformation is used to transform the metric value"
	
	| minValue maxValue |
	"We get the min and the max of the metric for all the elements"
	maxValue := transformation rtValue: (metricBlock rtValue: elements anyOne model).
	minValue := maxValue.
	
	elements do: [ :el | 
		| t |  
		t := transformation rtValue: (metricBlock rtValue: el model).
		minValue := minValue min: t.
		maxValue := maxValue max: t ].
	
	self normalizeY: metricBlock min: min max: max minValue: minValue maxValue: maxValue using: transformation
]
