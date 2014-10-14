Class {
	#name : #RTGrapherBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'extent',
		'axisConfiguration',
		'datasets'
	],
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> add: aDataSet [
	datasets add: aDataSet.
	aDataSet builder: self
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> axisPointFor: aPoint [
	"Return the position in the view to have the 0 @ 0"
	| centralPointX centralPointY |
	centralPointX := aPoint x + ((extent x - aPoint x) * ((aPoint x - self minX) / (self maxX - self minX))) asInteger.
	centralPointY := aPoint y + ((extent y - aPoint y) * ((aPoint y - self minY) / (self maxY - self minY))) asInteger.
	^ centralPointX @ centralPointY negated.

]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> axisX [
	| centralPoint |
	self computeMinAndMax.
	centralPoint := self centralPoint.
	axisConfiguration
		positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position + (0 @ 15) ];
		minValue:
				(self minX > 0
						ifTrue: [ 0 ]
						ifFalse: [ self minX ]);
		maxValue: self maxX.
	axisConfiguration axisFrom: 0 @ centralPoint y to: extent x @ centralPoint y
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> axisXWithNumberOfTicks: nbOfTicks [
	| config centralPoint |
	self computeMinAndMax.
	config := RTAxisConfiguration new
					builder: self;
					numberOfTicks: nbOfTicks;
					numberOfLabels: nbOfTicks;
					minValue: ((self minX > 0) ifTrue: [ 0 ] ifFalse: [ self minX ]);
					maxValue: self maxX;
					labelConvertion: [ :number | number asFloat round: 2 ];
					positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position + (0 @ 15) ].
	centralPoint := self centralPoint.
	config axisFrom: 0 @ centralPoint y to: extent x @ centralPoint y
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> axisY [
	| centralPoint |
	self computeMinAndMax.
	centralPoint := self centralPoint.
	axisConfiguration
		positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position - (40 @ 0) ];
		minValue:
				(self minY > 0
						ifTrue: [ 0 ]
						ifFalse: [ self minY ]);
		maxValue: self maxY.
	axisConfiguration axisFrom: centralPoint x @ 0 to: centralPoint x @ extent y negated
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> axisYWithNumberOfTicks: nbOfTicks [
	| config centralPoint |
	self computeMinAndMax.
	config := RTAxisConfiguration new
					builder: self;
					numberOfTicks: nbOfTicks;
					numberOfLabels: nbOfTicks;
					minValue: ((self minY > 0) ifTrue: [ 0 ] ifFalse: [ self minY ]);
					maxValue: self maxY;
					labelConvertion: [ :number | number asFloat round: 2 ];
					positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position - (40 @ 0) ].
	centralPoint := self centralPoint.
	config axisFrom: centralPoint x @ 0 to: centralPoint x @ extent y negated
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> centralPoint [
	"Return the position in the view to have the 0 @ 0"
	^ self axisPointFor: 0 @ 0
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> computeMinAndMax [
	self computeMinAndMaxForX.
	self computeMinAndMaxForY.
	self homogenizeMinAndMax
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> computeMinAndMaxForX [
	datasets do: #computeMinAndMaxForX
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> computeMinAndMaxForY [
	datasets do: #computeMinAndMaxForY
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> example01 [

	"
	self new example01
	"
	| grapher |
	grapher := RTGrapherBuilder new.
	grapher extent: 300 @ 200.
	grapher add: (RTDataSet new points: RTObject withAllSubclasses; x: #numberOfLinesOfCode; y: #numberOfMethods).
	grapher open
	
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> example02 [

	"
	self new example02
	"
	| grapher dataSet |
	grapher := RTGrapherBuilder new.
	grapher extent: 300 @ 200.
	dataSet := RTDataSet new 
		points: RTObject withAllSubclasses; 
		x: #numberOfLinesOfCode; 
		y: #numberOfMethods.
	dataSet dotShape color: (Color red alpha: 0.3).
	grapher add: dataSet.
	grapher axisX; axisY.
	grapher open
	
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> example03 [

	"
	self new example03
	"

| methodsRoassal methodsTrachel greatestAge b ds | 
methodsRoassal := RTObject withAllSubclasses flatCollect: #methods.
methodsTrachel := TRObject withAllSubclasses flatCollect: #methods.

methodsRoassal := methodsRoassal select: [ :m | m numberOfLinesOfCode < 300 ].
methodsTrachel := methodsTrachel select: [ :m | m numberOfLinesOfCode < 300 ].

greatestAge := (methodsTrachel , methodsRoassal collect: [ :m | m date asUnixTime ]) min.

b := RTGrapherBuilder new.
b extent: 300 @ 300.

ds := RTDataSet new
				points: methodsRoassal;
				x: [ :m | (m date asUnixTime - greatestAge) / 3600 ];
				y: #numberOfLinesOfCode.
ds dotShape circle color: (Color blue alpha: 0.3); size: 5.
ds interaction popup.
b add: ds.

ds := RTDataSet new
				points: methodsTrachel;
				x: [ :m | (m date asUnixTime - greatestAge) / 3600 ];
				y: #numberOfLinesOfCode.
ds dotShape circle color: (Color red alpha: 0.3); size: 5.
ds interaction popup.
b add: ds.


"b allX: [ :m | (m date asUnixTime - greatestAge) / 3600 ] .
b allY: #numberOfLinesOfCode.
"
b axisXWithNumberOfTicks: 4.
b axisYWithNumberOfTicks: 4.
"b axisX; axisY."
b open.

b view canvas
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> example04 [

| b ds |
b := RTGrapherBuilder new.
b extent: 200 @ 200.

ds := RTDataSet new.
ds dotShape rectangle size: 0.
ds points: (0 to: 3.1415 * 5 by: 0.01).
ds y: [ :v | v sin ].
ds x: #yourself.
ds connectColor: (Color red alpha: 0.4).
b add: ds.

ds := RTDataSet new.
ds dotShape rectangle size: 0.
ds points: (0 to: 3.1415 * 5 by: 0.01).
ds y: [ :v | v cos ].
ds x: #yourself.
ds connectColor: (Color blue alpha: 0.4).
b add: ds.

b axisX.
b axisY.

b open.

]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> extent [
	^ extent
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> extent: aPoint [
	extent := aPoint
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> homogenizeMinAndMax [
	| minX maxX minY maxY |
	minX := self minX.
	maxX := self maxX.
	minY := self minY.
	maxY := self maxY.
	datasets do: [ :ds |
		ds minX: minX.
		ds minY: minY.
		ds maxX: maxX.
		ds maxY: maxY. ]
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> initialize [
	super initialize.
	extent := 100 @ 100.
	
	"Collection of data sets"
	datasets := OrderedCollection new.
	
	self resetAxisConfiguration
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> maxX [
	^ (datasets collect: #maxX) max
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> maxY [
	^ (datasets collect: #maxY) max
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> minX [
	^ (datasets collect: #minX) min
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> minY [
	^ (datasets collect: #minY) min
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> renderIn: aView [
	datasets do: [ :aDataset | aDataset renderIn: aView ]
]

{ #category : #'as yet unclassified' }
RTGrapherBuilder >> resetAxisConfiguration [
	axisConfiguration := RTAxisConfiguration new.
	axisConfiguration builder: self
]
