Class {
	#name : #RTAbstractData,
	#superclass : #RTObject,
	#instVars : [
		'builder',
		'maxX',
		'maxY',
		'minX',
		'minY',
		'x',
		'elements',
		'y',
		'barBuilder',
		'elementActions'
	],
	#category : #'Roassal2-Builder-Grapher-Core'
}

{ #category : #adding }
RTAbstractData >> addedInBuilder: aBuilder [
	self builder: aBuilder.
]

{ #category : #public }
RTAbstractData >> barChartWithBarCenteredTitle: aBlockOrSymbol [
	"Add bar charts with centered title, the default color is used. This is a public method"
	^ self barChartWithBarCenteredTitle: aBlockOrSymbol color: self defaultLabelColor
]

{ #category : #public }
RTAbstractData >> barChartWithBarCenteredTitle: aBlockOrSymbol color: aColor [
	"Draw a bar chart with title"
	self barShape.
	elementActions add: [ :someElements | 
		| lbl |
		self selectElementsForAddingBarTitle doWithIndex: [ :e :index |
			| modelToBeUsed |
			modelToBeUsed := self getModelForElement:e atIndex: index.
			lbl := (RTLabel new text: aBlockOrSymbol; color: aColor) 
						elementOn: modelToBeUsed.
			TRConstraint move: lbl below: e.
			elements anyOne view add: lbl.
		] ].
	 
]

{ #category : #public }
RTAbstractData >> barChartWithBarTitle: aBlockOrSymbol [
	"Draw a barChart with title"
	self barChartWithBarTitle: aBlockOrSymbol rotation: -45
]

{ #category : #public }
RTAbstractData >> barChartWithBarTitle: aBlockOrSymbol rotation: rotationInDegree [
	"Draw an histogram with title"

	self barChartWithBarTitle: aBlockOrSymbol rotation: rotationInDegree color: self defaultLabelColor
]

{ #category : #public }
RTAbstractData >> barChartWithBarTitle: aBlockOrSymbol rotation: rotationInDegree color: aColor [
	"Draw an histogram with title"
	self barShape.
	elementActions add: [ :someElements | 
		| lbl |
		self selectElementsForAddingBarTitle doWithIndex: [ :e :index |
			| modelToBeUsed |
			modelToBeUsed := self getModelForElement:e atIndex: index.
			lbl := (RTLabel new text: aBlockOrSymbol; color: aColor) elementOn: modelToBeUsed.
			lbl rotateByDegrees: rotationInDegree.
			TRConstraint move: lbl below: e.
			lbl translateBy: (lbl width / -2 @ 0) + (5 @ 0).
			elements anyOne view add: lbl.
		] ].
	 
]

{ #category : #accessing }
RTAbstractData >> barShape [
	^ barBuilder
]

{ #category : #accessing }
RTAbstractData >> builder: aBuilder [
	builder := aBuilder 
]

{ #category : #hooks }
RTAbstractData >> centralDot [
	^ (RTEllipse new
		size: 0;
		color: Color red) element translateTo: (builder getPixelPositionOf: 0 @ 0)
]

{ #category : #'min and max' }
RTAbstractData >> computeMinAndMax [
	self computeMinAndMaxForX.
	self computeMinAndMaxForY.
]

{ #category : #'min and max' }
RTAbstractData >> computeMinAndMaxForX [
	| computed |
	computed := elements collect: x.
	self assert: [ computed allSatisfy: [ :obj | obj isKindOf: Number ] ] description: 'You have provided objects that are not number. Please adjust what you provide to #points: #x: and #y:'.
	minX := computed min.
	maxX := computed max.

	(minX < 0 and: [ maxX < 0 ]) ifTrue: [ maxX := 0 ].
	(minX > 0 and: [ maxX > 0 ]) ifTrue: [ minX := 0 ].
	


]

{ #category : #'min and max' }
RTAbstractData >> computeMinAndMaxForY [
	| computed |
	computed := elements collect: y.
	self assert: [ computed allSatisfy: [ :obj | obj isKindOf: Number ] ] description: 'You have provided objects that are not number. Please adjust what you provide to #points: #x: and #y:'.
	minY := computed min.
	maxY := computed max.
	
	(minY < 0 and: [ maxY < 0 ]) ifTrue: [ maxY := 0 ].
	(minY > 0 and: [ maxY > 0 ]) ifTrue: [ minY := 0 ].
	
]

{ #category : #initialization }
RTAbstractData >> defaultLabelColor [
	"Label should be gray per default"
	^ Color gray
]

{ #category : #initialization }
RTAbstractData >> defaultMaxValue [
	^ 1000000
]

{ #category : #initialization }
RTAbstractData >> defaultMinValue [
	^ -1000000
]

{ #category : #accessing }
RTAbstractData >> elements [
	"Private method - not meant to be used by a end user.
	Return the elements added by the data"
	^ elements
]

{ #category : #hooks }
RTAbstractData >> getModelForElement: element atIndex: index [
	"Return the model that is used to insert a label for the element. index is index-th label to be provided."
	"The default behavior is simply to return the model of the element"
	^ element model
]

{ #category : #hooks }
RTAbstractData >> getPixelPositionOf: aPoint [
	"Return the position in the Roassal view of a point"

	| anX anY |
	anX := RTMetricNormalizer new
		getValue: aPoint x min: 0 max: builder extent x minValue: minX maxValue: maxX.
	anY := RTMetricNormalizer new
		getValue: aPoint y min: 0 max: builder extent y negated minValue: minY maxValue: maxY.
			
	^ anX @ anY
]

{ #category : #hooks }
RTAbstractData >> getPositionFromPixelPosition: aPoint [
	"Return the position in the graph from a position in the Roassal view of a point"

	| anX anY |
	anX := RTMetricNormalizer new
		getValue: aPoint x min: minX max: maxX minValue: 0 maxValue: builder extent x.
	anY := RTMetricNormalizer new
		getValue: aPoint y min: minY max: maxY minValue: 0 maxValue: builder extent y.
			
	^ anX @ anY negated
]

{ #category : #initialization }
RTAbstractData >> initialize [
	super initialize.
	elementActions := OrderedCollection new.
]

{ #category : #accessing }
RTAbstractData >> maxX [
	^ maxX
]

{ #category : #accessing }
RTAbstractData >> maxX: anObject [
	maxX := anObject
]

{ #category : #accessing }
RTAbstractData >> maxY [
	^ maxY
]

{ #category : #accessing }
RTAbstractData >> maxY: anObject [
	maxY := anObject
]

{ #category : #accessing }
RTAbstractData >> minX [
	^ minX
]

{ #category : #accessing }
RTAbstractData >> minX: anObject [
	minX := anObject
]

{ #category : #accessing }
RTAbstractData >> minY [
	^ minY
]

{ #category : #accessing }
RTAbstractData >> minY: anObject [
	minY := anObject
]

{ #category : #utility }
RTAbstractData >> resetMinAndMax [

	minY := self defaultMaxValue.
	maxY := self defaultMinValue.
	minX := self defaultMaxValue.
	maxX := self defaultMinValue.

]

{ #category : #hooks }
RTAbstractData >> resetShapeBuilderForBar [
	barBuilder := RTShapeBuilder new.
	barBuilder rectangle.
	
	"Default width that compute an appropriate width"
	barBuilder width: [ :object | 
		(builder extent x / (self numberOfPoints * self numberOfMetrics * 2)) asFloat ]
]

{ #category : #hooks }
RTAbstractData >> selectElementsForAddingBarTitle [
	"This method has to be overriden to provide the elements that deserve to receive a title"
	self subclassResponsibility
]
