"
RTDynamicStackedGrapher is a dynamic grapher on which bar may be added.

Consider the following example:

	| b |
	b := RTDynamicStackedGrapher new.
	b numberOfBars: 10.
	b minY: -200; maxY: 200.

	b y: #yourself.
	 
	b barShape color: (Color red alpha: 0.3).
	b view addMenu: '+ 1' callback: [ b add: 400 atRandom - 200 ].
	b open
"
Class {
	#name : #RTDynamicStackedGrapher,
	#superclass : #RTAbstractGrapher,
	#instVars : [
		'numberOfBars',
		'y',
		'allAddedElements'
	],
	#category : #'Roassal2-Builder-Grapher-Core'
}

{ #category : #adding }
RTDynamicStackedGrapher >> add: anObject [
	| positionInView el center barHeight yValue |
	self removeExceedingBar.
	yValue := self yValueFor: anObject.
	positionInView := self getPixelPositionOf: 0 @ yValue.
	center := self getPixelPositionOf: 0 @ 0.
	barHeight := (positionInView y - center y) abs.
	el := self createElementFor: anObject height: barHeight.
	yValue > 0
		ifTrue: [ el translateTo: self barXPosition @ (positionInView y + (barHeight / 2)) ]
		ifFalse: [ el translateTo: self barXPosition @ (positionInView y - (barHeight / 2)) ].
	view add: el.
	view signalUpdate.
	allAddedElements add: el.
	^ el
]

{ #category : #adding }
RTDynamicStackedGrapher >> addAll: someObjects [
	^ someObjects collect: [ :o | self add: o ]
	
]

{ #category : #public }
RTDynamicStackedGrapher >> barShape [
	^ self shape rectangle

]

{ #category : #'private - bar management' }
RTDynamicStackedGrapher >> barWidth [
	^ (extent x / (numberOfBars + 1)) asFloat - self gapBetweenBar
]

{ #category : #'private - bar management' }
RTDynamicStackedGrapher >> barWidthWithGap [
	^ self barWidth + self gapBetweenBar
]

{ #category : #'private - bar management' }
RTDynamicStackedGrapher >> barXPosition [
	^ (allAddedElements size + 1) * self barWidthWithGap
]

{ #category : #'private - bar management' }
RTDynamicStackedGrapher >> createElementFor: anObject height: barHeight [
	| el |
	shapeBuilder width: self barWidth.
	shapeBuilder height: barHeight.
	el := shapeBuilder elementOn: anObject.
	el @ RTPopup.
	^ el
]

{ #category : #examples }
RTDynamicStackedGrapher >> example01 [

	| b |
	b := RTDynamicStackedGrapher new.
	b numberOfBars: 10.
	b minY: -200; maxY: 200.

	b y: #yourself.
	 
	b barShape color: (Color red alpha: 0.3).
	b view addMenu: '+ 1' callback: [ b add: 400 atRandom - 200 ].
	^ b  
]

{ #category : #'private - bar management' }
RTDynamicStackedGrapher >> gapBetweenBar [
	^ 2
]

{ #category : #initialization }
RTDynamicStackedGrapher >> initialize [
	super initialize.
	y := #yourself.
	self resetAddedElements.
	self axisX noTick; noLabel.
]

{ #category : #accessing }
RTDynamicStackedGrapher >> numberOfBars [
	^ numberOfBars
]

{ #category : #accessing }
RTDynamicStackedGrapher >> numberOfBars: anObject [
	numberOfBars := anObject
]

{ #category : #'private - bar management' }
RTDynamicStackedGrapher >> removeExceedingBar [
	allAddedElements size = numberOfBars
		ifTrue: [ 
			allAddedElements first remove.
			allAddedElements do: [ :e | 
				
				"e translateBy: self barWidthWithGap negated @ 0"
				view addAnimation: (RTLinearMove new by: (self barWidthWithGap negated @ 0) during: 0.1 on: e).
				 ].
			allAddedElements removeFirst ]
]

{ #category : #hooks }
RTDynamicStackedGrapher >> renderIn: aView [

	self defineAxesIfNecessary.
	self renderAxis.

]

{ #category : #'public - cleaning' }
RTDynamicStackedGrapher >> resetAddedElements [
	allAddedElements := OrderedCollection new
]

{ #category : #userinterface }
RTDynamicStackedGrapher >> updateView [
	self view signalUpdate
]

{ #category : #accessing }
RTDynamicStackedGrapher >> y [
	^ y
]

{ #category : #accessing }
RTDynamicStackedGrapher >> y: anObject [
	y := anObject
]

{ #category : #'private - bar management' }
RTDynamicStackedGrapher >> yValueFor: anObject [
	^ y rtValue: anObject
]
