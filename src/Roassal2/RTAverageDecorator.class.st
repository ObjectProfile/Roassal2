"
RTAverageDecorator is a decorator that indicates the average of a set of values.

Consider the following example:

-=-=-=-=
b := RTGrapher new.
ds := RTDataSet new. 
ds dotShape color: Color red. 
ds points: #(5 1 20 8).
b add: ds.
b addDecorator: (RTAverageDecorator new withLabel; labelConvertion: [ :aValue | 'average = ', aValue asFloat asString ]).
b build.
-=-=-=-=
"
Class {
	#name : #RTAverageDecorator,
	#superclass : #RTAbstractGrapherDecorator,
	#instVars : [
		'shouldHaveLabel',
		'labelConvertion'
	],
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #initialization }
RTAverageDecorator >> initialize [
	super initialize.
	self noLabel.
	labelConvertion := #yourself
]

{ #category : #accessing }
RTAverageDecorator >> labelConvertion [
	^ labelConvertion
]

{ #category : #accessing }
RTAverageDecorator >> labelConvertion: aBlockOrSymbol [
	"This method is used to set how to convert the average value"
	"Take as argument the average value, as a number and the block has to return a value or a string"
	labelConvertion := aBlockOrSymbol
]

{ #category : #initialization }
RTAverageDecorator >> noLabel [
	shouldHaveLabel := false
]

{ #category : #drawing }
RTAverageDecorator >> render [
	| values average from to |
	values := self datasetValues.
	average := values average.
	from := builder getPixelPositionOf: builder minX @ average.
	to := builder getPixelPositionOf: builder maxX @ average.
	self lineFrom: from to: to.
	
	shouldHaveLabel ifTrue: [ 
		self label: ((labelConvertion rtValue: average) asString) above: to.
	]
]

{ #category : #configuration }
RTAverageDecorator >> withLabel [
	shouldHaveLabel := true
]
