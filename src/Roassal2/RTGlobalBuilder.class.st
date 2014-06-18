Class {
	#name : #RTGlobalBuilder,
	#superclass : #RTScopedBuilder,
	#instVars : [
		'alphaColor',
		'view',
		'properties',
		'elementsToConsider'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #public }
RTGlobalBuilder class >> view: aView [
	^ self new view: aView
]

{ #category : #adding }
RTGlobalBuilder >> addProperty: aOneOrTwoArgBlock [
	properties add: aOneOrTwoArgBlock
]

{ #category : #accessing }
RTGlobalBuilder >> alphaColor:  anAlphaColor [
	"Set an alpha color (transparency) for nodes"
	"aFloat has to be between 0.0 and 1.0"
	self addProperty: [
		self filteredElementsToConsider do: [ :el | 
				el trachelShape color: (el trachelShape color alpha: anAlphaColor)
			] 
		]. 
]

{ #category : #accessing }
RTGlobalBuilder >> alphaColorEdge:  anAlphaColor [
	"Set an alpha color (transparency) for nodes"
	"aFloat has to be between 0.0 and 1.0"
	self addProperty: [
		self view edges do: [ :edge | 
				edge trachelShape color: (edge trachelShape color alpha: anAlphaColor)
			] 
		]. 
]

{ #category : #algorithm }
RTGlobalBuilder >> colorCycles [

	self addProperty: [
		RTColorCycle new visitElements: self view elements
		]. 
]

{ #category : #accessing }
RTGlobalBuilder >> elementsToConsider [
	^ elementsToConsider
]

{ #category : #accessing }
RTGlobalBuilder >> elementsToConsider: elements [
	elementsToConsider := elements
]

{ #category : #execute }
RTGlobalBuilder >> execute [

	properties do: #value
]

{ #category : #execute }
RTGlobalBuilder >> executeOn: elements [
	self elementsToConsider: elements.
	self execute
]

{ #category : #accessing }
RTGlobalBuilder >> filteredElementsToConsider [ 
	^ elementsToConsider select: [ :v | condition rtValue: v model ]
]

{ #category : #initialization }
RTGlobalBuilder >> initialize [
	super initialize.
	alphaColor := 1.0.
	properties := OrderedCollection new
]

{ #category : #public }
RTGlobalBuilder >> maxSize: anInteger [
	"aBlock is evaluated on each node model. 
	Set the maximum size of each element"
	self addProperty: [
		self filteredElementsToConsider do: [ :el | 
				"We set the color"
				(condition rtValue: el model)
					ifTrue: [ el trachelShape extent: (el trachelShape extent min: anInteger @ anInteger) ]
					ifFalse: [ el trachelShape color: (el trachelShape color alpha: alphaColor) ].
			] 
		]. 
]

{ #category : #public }
RTGlobalBuilder >> minSize: anInteger [
	"aBlock is evaluated on each node model. 
	Set the minimum size of each element"
	self addProperty: [
		self filteredElementsToConsider do: [ :el | 
				"We set the color"
				(condition rtValue: el model)
					ifTrue: [ el trachelShape extent: (el trachelShape extent max: anInteger @ anInteger) ]
					ifFalse: [ el trachelShape color: (el trachelShape color alpha: alphaColor) ].
			] 
		]. 
]

{ #category : #public }
RTGlobalBuilder >> normalizeColor: metricBlock using: colors [
	"aBlock is evaluated on each node model. 
	 Colors is an array of colors used to do the fading"
	^ self normalizeColor: metricBlock using: colors using: #yourself
]

{ #category : #public }
RTGlobalBuilder >> normalizeColor: metricBlock using: colors using: transformation [
	"aBlock is evaluated on each node model. 
	 Colors is an array of colors used to do the fading"
	self addProperty: [
		| min max normalizer |
		"We get the min and the max of the metric for all the elements"
		min := 1000000.
		max := 0.
		self filteredElementsToConsider do: [ :el | 
			| t |  
			t := transformation rtValue: (metricBlock rtValue: el model).
			min := min min: t.
			max := max max: t ].
		max ~= 0 ifTrue: [ 
			normalizer := RTMultiLinearColor new colors: colors.
			self filteredElementsToConsider do: [ :el | 
					"We set the color"
					(condition rtValue: el model)
						ifTrue: [ el trachelShape color: ((normalizer level: (((transformation rtValue: (metricBlock rtValue: el model)) - min) / max)) alpha: alphaColor) ]
						ifFalse: [ el trachelShape color: (el trachelShape color alpha: alphaColor) ].
			] ]
		]. 
]

{ #category : #public }
RTGlobalBuilder >> normalizeColorUsing: colors [
	^ self normalizeColor: #yourself using: colors
]

{ #category : #public }
RTGlobalBuilder >> normalizeSize: metricBlock min: minValue max: maxValue [
	"metricBlock is evaluated on each node model. 
	 minValue and maxValue are integer representing the minimum and maximum size in pixels for each node"
	self normalizeSize: metricBlock min: minValue max: maxValue using: #yourself
]

{ #category : #public }
RTGlobalBuilder >> normalizeSize: metricBlock min: minValue max: maxValue using: transformation [
	"metricBlock is evaluated on each node model. 
	 minValue and maxValue are integer representing the minimum and maximum size in pixels for each node"
	"transformation is a function that takes as argument the result of a metric and return the metric transformed"
	self addProperty: [	
		| min max ellsToConsider t |
		min := 100000.
		max := -100000.
		ellsToConsider := OrderedCollection new.
		self filteredElementsToConsider do: [ :el | 	
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

{ #category : #public }
RTGlobalBuilder >> normalizeSizeMin: minValue max: maxValue [
	self addProperty: [	
		| min max ellsToConsider t |
		min := 1000000.
		max := -1000000.
		 
		ellsToConsider := OrderedCollection new.
		self filteredElementsToConsider do: [ :el | 	
				t := el trachelShape extent x max: el trachelShape extent y.
				min := min min: t.
				max := max max: t.
				ellsToConsider add: el ].
	
		ellsToConsider do: [ :el | 
			| tt |
			t := el trachelShape extent x max: el trachelShape extent y.
			tt := minValue + (maxValue * (t - min) / (max + 1)) asInteger.
			el trachelShape extent: tt @ tt ]
		]
]

{ #category : #accessing }
RTGlobalBuilder >> view [
	^ view
]

{ #category : #accessing }
RTGlobalBuilder >> view: aView [
	view := aView.
	self elementsToConsider: aView elements
]
