Class {
	#name : #RTCharterBuilderTest,
	#superclass : #RTTest,
	#category : #'RoassalObsolete-Builder-CharterOLD'
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
RTCharterBuilderTest >> testHistogramAndXAxis [
	| b view |
	b := RTCharterBuilder new.
	b extent: 200 @ 200.
	b points: #( 10 5 2 ).
	b stackX.
	b y: #yourself.
	b histogramBarWidth: 10.
	b axisXWithNumberOfTicks: 1.
	b axisYWithNumberOfTicks: 4.
	b build.
	view := b view.
	self assert: view numberOfEdges equals: 2.
	self assert: view edges first from position equals: (0 @ 0).
	
	
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
RTCharterBuilderTest >> testMultiplePointSetsAndAxis [

	| b |
	b := RTCharterBuilder new.
	b extent: 200 @ 200.
	b points: #( 5 ).
	b points: #( 1 ).

	b allY: #yourself.
	b stackX.

	b axisXWithNumberOfTicks: 1.
	b axisYWithNumberOfTicks: 1.
	b build.
	
	self assert: b allPoints size equals: 2.
	self assert: b centralPoint equals: 0 @ 0
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
RTCharterBuilderTest >> testPointsAndAxis [

	| b view |
	b := RTCharterBuilder new.
	b points: (Array with: 1 @ 1 with: 5 @ 5 ).
	b x: #x; y: #y.
	b axisX.
	b axisY.
	b build.
	
	view := b view.
	self assert: view edges first from position equals: 0 @ 0.
	self assert: view edges second from position equals: 0 @ 0.
]

{ #category : #scaling }
RTCharterBuilderTest >> testScaling01 [

	| f g xValues b |
	f := [ :x | x ].
	g := [ :x | x * x ].

	xValues := (0 to: 100 by: 0.1).

	b := RTCharterBuilder new.
	b extent: 300 @ 200.
	b shape rectangle size: 0.

	b points: xValues.
	b y: f.
	b x: #yourself.
	b connectDotColor: Color blue.

	b points: xValues.
	b y: g.
	b x: #yourself.
	b connectDotColor: Color green.

	b axisX; axisY.
	b build.
	
	self assert: b maxX equals: 100.
	self assert: b minX equals: 0.

	self assert: b maxY equals: 10000.
	self assert: b minY equals: 0.
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
