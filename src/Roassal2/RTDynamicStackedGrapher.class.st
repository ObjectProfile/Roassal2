Class {
	#name : #RTDynamicStackedGrapher,
	#superclass : #RTAbstractGrapher,
	#instVars : [
		'numberOfBars',
		'y',
		'allAddedElements'
	],
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #'as yet unclassified' }
RTDynamicStackedGrapher >> add: anObject [
	| positionInView el xPosition |
	allAddedElements size = numberOfBars
		ifTrue: [ 
			allAddedElements first remove.
			allAddedElements do: [ :e | e translateBy: self barWidthWithGap negated @ 0 ].
			allAddedElements removeFirst ].
	positionInView := self getPixelPositionOf: 0 @ (y rtValue: anObject).
	shapeBuilder width: self barWidth.
	shapeBuilder height: positionInView y abs.
	el := shapeBuilder elementOn: anObject.
	xPosition := (allAddedElements size + 1) * self barWidthWithGap.
	el translateTo: xPosition @ (positionInView y - (positionInView y / 2)).
	view add: el.
	view signalUpdate.
	allAddedElements add: el.
	^ el
]

{ #category : #'as yet unclassified' }
RTDynamicStackedGrapher >> addAll: someObjects [
	^ someObjects collect: [ :o | self add: o ]
	
]

{ #category : #'as yet unclassified' }
RTDynamicStackedGrapher >> barShape [
	^ self shape rectangle

]

{ #category : #'as yet unclassified' }
RTDynamicStackedGrapher >> barWidth [
	^ (extent x / (numberOfBars + 1)) asFloat - self gapBetweenBar
]

{ #category : #'as yet unclassified' }
RTDynamicStackedGrapher >> barWidthWithGap [
	^ self barWidth + self gapBetweenBar
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

{ #category : #'as yet unclassified' }
RTDynamicStackedGrapher >> gapBetweenBar [
	^ 2
]

{ #category : #'as yet unclassified' }
RTDynamicStackedGrapher >> initialize [
	super initialize.
	y := #yourself.
	self resetAddedElements
]

{ #category : #accessing }
RTDynamicStackedGrapher >> numberOfBars [
	^ numberOfBars
]

{ #category : #accessing }
RTDynamicStackedGrapher >> numberOfBars: anObject [
	numberOfBars := anObject
]

{ #category : #'as yet unclassified' }
RTDynamicStackedGrapher >> renderIn: aView [

	self defineAxesIfNecessary.
	self renderAxis.

]

{ #category : #'as yet unclassified' }
RTDynamicStackedGrapher >> resetAddedElements [
	allAddedElements := OrderedCollection new
]

{ #category : #'as yet unclassified' }
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
