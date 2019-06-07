"
Builder that defines a heatmap

Example of use:
-=-=-=--=
b := RTHeatmap new.
b shapeWithText.
b function: [ :x :y | x * y ].
b mapping: #yourself.
b rangeX: #(5 10 15 20 25).
b rangeY: #(5 10 15 20 25) / 10.
b
-=-=-=--=
"
Class {
	#name : #RTHeatmap,
	#superclass : #RTBuilder,
	#instVars : [
		'function',
		'mapping',
		'rangeX',
		'rangeY',
		'colors',
		'scale',
		'gapSize'
	],
	#category : #'Roassal2-Heatmap'
}

{ #category : #'public - color' }
RTHeatmap >> blackGrayRed [
	self colors: (Array with: Color black with: Color gray with: Color red)
]

{ #category : #'public - color' }
RTHeatmap >> blackRed [
	self colors: (Array with: Color black with: Color red)
]

{ #category : #'public - color' }
RTHeatmap >> blackWhiteRed [
	self colors: (Array with: Color black with: Color white with: Color red)
]

{ #category : #accessing }
RTHeatmap >> colors [
	^ colors
]

{ #category : #accessing }
RTHeatmap >> colors: someColors [
	"Set the colors used to render the heatmap"
	colors := someColors
]

{ #category : #hooks }
RTHeatmap >> createShapeBuilder [
	^ super createShapeBuilder box size: 60
]

{ #category : #accessing }
RTHeatmap >> function [
	"Return the two argument function used to produce the heatmap"
	^ function
]

{ #category : #accessing }
RTHeatmap >> function: aTwoArgFunction [
	function := aTwoArgFunction
]

{ #category : #accessing }
RTHeatmap >> gapSize [
	^ gapSize
]

{ #category : #'public - configuration' }
RTHeatmap >> gapSize: aGapSize [
	"Specificy the distance between each cell"
	gapSize := aGapSize
]

{ #category : #'public - color' }
RTHeatmap >> grayRed [
	self colors: (Array with: Color gray with: Color red)
]

{ #category : #initialization }
RTHeatmap >> initialize [
	super initialize.
	self linear.
	self grayRed.
	self noGap
]

{ #category : #'public - scale' }
RTHeatmap >> linear [
	scale := #yourself
]

{ #category : #'public - scale' }
RTHeatmap >> ln [ 
	scale := [ :v | v ~= 0 ifTrue: [ v ln ] ifFalse: [ -1000 ] ]
]

{ #category : #'public - scale' }
RTHeatmap >> log [ 
	scale := [ :v | v ~= 0 ifTrue: [ v log ] ifFalse: [ -1000 ] ]
]

{ #category : #accessing }
RTHeatmap >> mapping [
	^ mapping
]

{ #category : #accessing }
RTHeatmap >> mapping: aSymbolOrOneArgBlock [
	"Set the one-arg function used to map the result of the function as a numerical value"
	mapping := aSymbolOrOneArgBlock
]

{ #category : #'public - configuration' }
RTHeatmap >> noGap [
	self gapSize: 0
]

{ #category : #accessing }
RTHeatmap >> rangeX [
	^ rangeX
]

{ #category : #accessing }
RTHeatmap >> rangeX: aCollectionOfValues [
	rangeX := aCollectionOfValues
]

{ #category : #accessing }
RTHeatmap >> rangeY [
	^ rangeY
]

{ #category : #accessing }
RTHeatmap >> rangeY: aCollectionOfValues [
	rangeY := aCollectionOfValues
]

{ #category : #hooks }
RTHeatmap >> renderIn: aView [
	| elements |
	elements := RTGroup new.
	rangeX do: [ :x |
		rangeY do: [ :y |
			elements add: (self shape elementOn: (mapping rtValue: (function value: x value: y)))
		]
	].
	aView addAll: elements.
	elements @ RTPopup.
	RTGridLayout new gapSize: gapSize; lineItemsCount: rangeX size; on: elements.
	
	RTMetricNormalizer new
		elements: elements;
		normalizeColor: [ :obj | mapping rtValue: obj ] using: colors using: scale
]

{ #category : #'public - configuration' }
RTHeatmap >> shapeWithText [
	"Set a text within each cell"
	self shapeWithTextColored: Color black
]

{ #category : #'public - configuration' }
RTHeatmap >> shapeWithTextColored: aColor [
	self shape withText: #yourself color: aColor
]

{ #category : #'public - scale' }
RTHeatmap >> sqrt [ 
	scale := #sqrt
]

{ #category : #'public - scale' }
RTHeatmap >> squared [ 
	scale := [ :v | v * v ]
]

{ #category : #'public - configuration' }
RTHeatmap >> withGap [
	self gapSize: 5.
]
