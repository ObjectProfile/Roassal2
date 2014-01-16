"
A ROPunchcardBuilder is xxxxxxxxx.

Instance Variables
	maxColor:		<Object>
	metrics:		<Object>
	minColor:		<Object>
	models:		<Object>
	popupText:		<Object>
	view:		<Object>

maxColor
	- xxxxx

metrics
	- xxxxx

minColor
	- xxxxx

models
	- xxxxx

popupText
	- xxxxx

view
	- xxxxx

"
Class {
	#name : #RTPunchcardBuilder,
	#superclass : #RTObject,
	#instVars : [
		'models',
		'metrics',
		'view',
		'minColor',
		'maxColor',
		'popupText'
	],
	#category : #'Roassal2-Builder-Punchcard'
}

{ #category : #adding }
RTPunchcardBuilder >> addMetric: aBlock namedAs: metricName [
	metrics add: (Array with: aBlock with: metricName).
]

{ #category : #adding }
RTPunchcardBuilder >> addModels: aCollection [
	models addAll: aCollection.
]

{ #category : #'initialize-release' }
RTPunchcardBuilder >> initialize [
	super initialize.
	metrics := OrderedCollection new.
	models := OrderedCollection new.
	minColor := maxColor := Color gray.
	popupText := [ :object :metricName :value | value ]
]

{ #category : #accessing }
RTPunchcardBuilder >> maxColor: aColor [
	maxColor := aColor
]

{ #category : #accessing }
RTPunchcardBuilder >> minColor: aColor [
	minColor := aColor
]

{ #category : #metrics }
RTPunchcardBuilder >> numberOfMetrics [
	^ metrics size
]

{ #category : #metrics }
RTPunchcardBuilder >> numberOfModels [
	^ models size
]

{ #category : #'instance creation' }
RTPunchcardBuilder >> open [

	|  aView |
	aView := RTView new.
	self renderOn: aView.
	aView open
]

{ #category : #accessing }
RTPunchcardBuilder >> popupText: aTreeArgBlock [
	"Block has to match the pattern [ :object :metricName :value |  ... ]."
	popupText := aTreeArgBlock
	
]

{ #category : #rendering }
RTPunchcardBuilder >> renderOn: aView [
	|  layout |
	
	metrics do: [ :metric |
		| m name normalizer | 
		m := metric first.
		name := metric second.
		"thresholds :=  self thresholdsFor: metric."
		normalizer := RTNColorLinearNormalizer inContext: (models collect: [:obj | m rtValue: obj]) lowColor: minColor highColor: maxColor.
		models do: [ :obj |
			| circle metricValue |
			metricValue := m rtValue: obj.
			circle := ((RTEllipse new size: metricValue ) color: (normalizer rtValue: metricValue)) elementOn: obj.
			circle @ (RTPopup text: [ :roElement | (popupText value: obj  value: name value: metricValue) asString ]).
			aView add: circle.
			 ].
			 
		aView add: (RTLabel new elementOn: name) 
	].
	
	models do: [ :obj | aView add: (RTLabel new elementOn: obj) ].
	
	layout := RTCellLayout withLineItemsCount: (self numberOfModels + 1).
	layout on: aView elements
]
