Class {
	#name : #RTCharterBuilderTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #tests }
RTCharterBuilderTest >> testCurveAndTotalWidth [

	| b view elements extentBuilder |
	extentBuilder := 200 @ 200.
	b := RTCharterBuilder new.
	b extent: extentBuilder.
	b points: #(0 5).
	b y: #yourself.
	b curve.
	b build.
	view := b view.
	
	self assert: view numberOfElements equals: 2.
	self assert: view numberOfEdges equals: 1.
	
	elements := view elements.
	self assert: elements first position equals: 0 @ 0.
	self assert: elements second position equals: extentBuilder x @ extentBuilder y negated.
]

{ #category : #tests }
RTCharterBuilderTest >> testCurveAndTotalWidthAndScatterplot [

	| b view elements extentBuilder |
	extentBuilder := 200 @ 200.
	b := RTCharterBuilder new.
	b extent: extentBuilder.
	b points: #(0 5).
	b y: #yourself.
	b curve.
	b build.
	view := b view.
	
	self assert: view numberOfElements equals: 2.
	self assert: view numberOfEdges equals: 1.
	
	elements := view elements.
	self assert: elements first position equals: 0 @ 0.
	self assert: elements second position equals: extentBuilder x @ extentBuilder y negated.
]

{ #category : #tests }
RTCharterBuilderTest >> testMultipleCurve [

	| b expectedResult |
	b := RTCharterBuilder new.
	
	b shape ellipse color: (Color blue alpha: 0.5).
	b points: #(0 1 2 3).
	b connectDot.

	b shape ellipse color: (Color red alpha: 0.5).
	b points: #(0 10 20 30).
	b connectDot.

	b allY: #yourself.
	b stackX.
	
	b axisXWithNumberOfTicks: 4.
	b axisYWithNumberOfTicks: 3.
	b build.
	
	expectedResult := ((Array new: 8) at: 1 put: ((25@0)); at: 2 put: ((50@ -3)); at: 3 put: ((75@ -6)); at: 4 put: ((100@ -10)); at: 5 put: ((25@0)); at: 6 put: ((50@ -33)); at: 7 put: ((75@ -66)); at: 8 put: ((100@ -100)); yourself).
	self assert: (b allPoints collect: [ :el | el position asIntegerPoint ]) asArray equals: expectedResult
]

{ #category : #tests }
RTCharterBuilderTest >> testNegativeValues [

	| b view |
	b := RTCharterBuilder new.
	b extent: 200 @ 200.
	b points: #(0 5).
	b y: [ :v | v - 2 ].
	b x: #yourself.
	b build.
	view := b view.

	self assert: view elements first position equals: (0 @ 0).	
	self assert: view elements second position equals: (200 @ -200).
]

{ #category : #tests }
RTCharterBuilderTest >> testNegativeValuesAndAxisX [

	| b view edge |
	b := RTCharterBuilder new.
	b extent: 200 @ 200.
	b points: #(0 4).
	b y: [ :v | v - 2 ].
	b x: #yourself.
	b axisX.
	b build.
	view := b view.

	self assert: view edges size equals: 1.
	edge := view edges anyOne.
	self assert: edge from position equals: (0 @ -100)
]

{ #category : #tests }
RTCharterBuilderTest >> testSimpleScatterplot [

	| b |
	b := RTCharterBuilder new.
	b extent: 100 @ 100.
	b shape ellipse color: (Color blue alpha: 0.4).
	b points: (1 to: 30 by: 5).
	b x: #yourself.
	b y: [ :v | v * v ].
	b size: #yourself min: 5 max: 50.

	b build.
	
]

{ #category : #tests }
RTCharterBuilderTest >> testStacking [

	| b view |
	b := RTCharterBuilder new.
	b extent: 200 @ 200.
	b points: #(0 5).
	b allY: #yourself.
	b stackX.
	b build.
	view := b view.
	
	self assert: view numberOfElements equals: 2.
	self assert: view elements first position equals: (100 @ 0).
	self assert: view elements second position equals: (200 @ -200)
]

{ #category : #tests }
RTCharterBuilderTest >> testTotalWidth [

	| b view elements extentBuilder |
	extentBuilder := 200 @ 200.
	b := RTCharterBuilder new.
	b extent: extentBuilder.
	b points: #(0 5).
	b y: #yourself.
	b x: #yourself.
	b build.
	view := b view.
	
	self assert: view numberOfElements equals: 2.
	self assert: view numberOfEdges equals: 0.
	
	elements := view elements.
	self assert: elements first position equals: 0 @ 0.
	self assert: elements second position equals: extentBuilder x @ extentBuilder y negated.
]
