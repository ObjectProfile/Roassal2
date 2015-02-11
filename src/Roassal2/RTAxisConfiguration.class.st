"
A RTAxisConfiguration describes an axis configuration
"
Class {
	#name : #RTAxisConfiguration,
	#superclass : #RTObject,
	#instVars : [
		'numberOfTicks',
		'numberOfLabels',
		'labelConvertion',
		'positionLabel',
		'minValue',
		'maxValue',
		'thousandsSeparator',
		'title',
		'builder',
		'color',
		'titlePosition',
		'labelRotation',
		'lineThickness',
		'fromPoint',
		'toPoint'
	],
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #testing }
RTAxisConfiguration >> areLabelRotated [
	"Return true if labels are rotated"
	^ labelRotation ~= 0
]

{ #category : #rendering }
RTAxisConfiguration >> axisFrom: fromPosition to: toPosition [ 
	| renderer |
	renderer := RTAxisRenderer new.
	renderer builder: self builder.
	renderer config: self.
	renderer axisFrom: fromPosition to: toPosition width: lineThickness
]

{ #category : #accessing }
RTAxisConfiguration >> builder [
	^ builder
]

{ #category : #accessing }
RTAxisConfiguration >> builder: anObject [
	builder := anObject
]

{ #category : #accessing }
RTAxisConfiguration >> color [
	"Return the color of the axis"
	^ color
]

{ #category : #accessing }
RTAxisConfiguration >> color: aColor [
	"Set the color of the axis"
	color := aColor
]

{ #category : #configuration }
RTAxisConfiguration >> decimal: anInteger [
	"Set the number of decimals"
	self labelConvertion: [ :number | number asFloat round: anInteger ]
]

{ #category : #configuration }
RTAxisConfiguration >> defaultColor [
	^ Color gray
]

{ #category : #configuration }
RTAxisConfiguration >> defaultTitlePosition [
	^ 0 @ 20
]

{ #category : #configuration }
RTAxisConfiguration >> doNotRotateLabels [
	labelRotation := 0
]

{ #category : #accessing }
RTAxisConfiguration >> fromPoint [
	^ fromPoint
]

{ #category : #accessing }
RTAxisConfiguration >> fromPoint: anObject [
	fromPoint := anObject
]

{ #category : #action }
RTAxisConfiguration >> getStringFromNumber: aNumber [
	^ (self labelConvertion rtValue: aNumber) asString
]

{ #category : #initialization }
RTAxisConfiguration >> initialize [
	super initialize.
	labelConvertion := [ :number | (number asFloat round: 2) asString ].
	positionLabel := [ :aLabel :aTick | aLabel translateTo: aTick position ].
	numberOfTicks := 4.
	numberOfLabels := numberOfTicks.
	lineThickness := 1.
	minValue := 0.
	maxValue := 0.
	self twoDecimals.
	self noThousandsSeparator.
	self noTitle.
	color := self defaultColor.
	titlePosition := self defaultTitlePosition.
	self doNotRotateLabels
]

{ #category : #accessing }
RTAxisConfiguration >> labelConvertion [
	^ labelConvertion
]

{ #category : #accessing }
RTAxisConfiguration >> labelConvertion: aOneArgBlock [
	"The argument is a one arg block taking the numerical value and returning another numerical value or a string"
	labelConvertion := aOneArgBlock
]

{ #category : #accessing }
RTAxisConfiguration >> labelRotation [
	"Return the rotation of the label"
	^ labelRotation
]

{ #category : #configuration }
RTAxisConfiguration >> labelRotation: rotationAsDegrees [
	"Rotate the labels"
	labelRotation := rotationAsDegrees
]

{ #category : #accessing }
RTAxisConfiguration >> lineThickness [
	^ lineThickness
]

{ #category : #accessing }
RTAxisConfiguration >> lineThickness: lineThicknessInPixels [
	lineThickness := lineThicknessInPixels
]

{ #category : #accessing }
RTAxisConfiguration >> maxValue [
	^ maxValue
]

{ #category : #accessing }
RTAxisConfiguration >> maxValue: aMinValue [
	maxValue := aMinValue
]

{ #category : #accessing }
RTAxisConfiguration >> maxValueIfNotSet: aMinValue [
	self maxValue: (aMinValue max: maxValue)
]

{ #category : #accessing }
RTAxisConfiguration >> minValue [
	^ minValue
]

{ #category : #accessing }
RTAxisConfiguration >> minValue: aMinValue [
	minValue := aMinValue
]

{ #category : #accessing }
RTAxisConfiguration >> minValueIfNotSet: aMinValue [
	self minValue: (aMinValue min: minValue)
]

{ #category : #configuration }
RTAxisConfiguration >> noDecimal [
	"Make the axis labels without decimal"
	self labelConvertion: [ :number | number asInteger ]
]

{ #category : #configuration }
RTAxisConfiguration >> noLabel [
	self numberOfLabels: 0
]

{ #category : #configuration }
RTAxisConfiguration >> noThousandsSeparator [
	thousandsSeparator := false
]

{ #category : #configuration }
RTAxisConfiguration >> noTick [
	self numberOfTicks: 0
]

{ #category : #configuration }
RTAxisConfiguration >> noTitle [
	self title: ''
]

{ #category : #accessing }
RTAxisConfiguration >> numberOfLabels [
	^ numberOfLabels
]

{ #category : #accessing }
RTAxisConfiguration >> numberOfLabels: aValue [
	numberOfLabels := aValue
]

{ #category : #accessing }
RTAxisConfiguration >> numberOfTicks [
	^ numberOfTicks
]

{ #category : #accessing }
RTAxisConfiguration >> numberOfTicks: aValue [
	numberOfTicks := aValue
]

{ #category : #configuration }
RTAxisConfiguration >> oneDecimal [
	self decimal: 1
]

{ #category : #configuration }
RTAxisConfiguration >> optimalTicksAndLabels [
	self halt.
]

{ #category : #configuration }
RTAxisConfiguration >> plain [
	"Make the axis a plain line"
	self noLabel; noTick
]

{ #category : #accessing }
RTAxisConfiguration >> positionLabel [
	^ positionLabel
]

{ #category : #accessing }
RTAxisConfiguration >> positionLabel: aTwoArgBlock [
	"This method expect a two argblock to set where the label should be"
	"eg. [ :aLabel :aTick | aLabel translateTo: aTick position + (0 @ 15) ]"
	positionLabel := aTwoArgBlock
]

{ #category : #configuration }
RTAxisConfiguration >> rotateLabels [
	"Rotate the labels"
	labelRotation := -45
]

{ #category : #accessing }
RTAxisConfiguration >> step [
	"Return the step between each tick"
	
	^ (self maxValue - self minValue) / self numberOfTicks.
"	| s |
	s := (self maxValue - self minValue) / self numberOfTicks.
	((self minValue to: self maxValue by: s) includes: 0.0) ifTrue: [ ^ s ].
	
	numberOfTicks := numberOfTicks + 1.
	s := (self maxValue - self minValue) / self numberOfTicks.

	self maxValue: (self maxValue / s) asInteger * s. 
	s := (self maxValue - self minValue) / self numberOfTicks.
	^ s"
]

{ #category : #accessing }
RTAxisConfiguration >> tickIntervalForLabel [
	^ numberOfTicks / numberOfLabels
]

{ #category : #accessing }
RTAxisConfiguration >> tickLabelOffset: aPoint [
	"Specify the offset between the tick and its label"
	self positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position + aPoint ].
]

{ #category : #accessing }
RTAxisConfiguration >> title [
	^ title
]

{ #category : #accessing }
RTAxisConfiguration >> title: aTitleAsString [
	title := aTitleAsString
]

{ #category : #accessing }
RTAxisConfiguration >> titlePosition [
	^ titlePosition
]

{ #category : #accessing }
RTAxisConfiguration >> titlePosition: aPoint [
	"Set the position of the title according to the toPosition when rendering the axis"
	"The argument is added to the toPosition"
	titlePosition := aPoint
]

{ #category : #accessing }
RTAxisConfiguration >> toPoint [
	^ toPoint
]

{ #category : #accessing }
RTAxisConfiguration >> toPoint: anObject [
	toPoint := anObject
]

{ #category : #configuration }
RTAxisConfiguration >> twoDecimals [
	self decimal: 2
]

{ #category : #configuration }
RTAxisConfiguration >> withThousandsSeparator [
	self labelConvertion: [ :number | number asInteger asStringWithCommas ] 
]
