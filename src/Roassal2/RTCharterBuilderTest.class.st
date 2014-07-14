Class {
	#name : #RTCharterBuilderTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #tests }
RTCharterBuilderTest >> testMultipleCurve [

	| b expectedResult |
	b := RTCharterBuilder new.
	
	b shape ellipse color: (Color blue alpha: 0.5).
	b points: #(0 1 2 3).
	b curve.

	b shape ellipse color: (Color red alpha: 0.5).
	b points: #(0 10 20 30).
	b curve.

	b y: #yourself.
	
	b axisXWithNumberOfTicks: 4.
	b axisYWithNumberOfTicks: 3.
	b build.
	
	expectedResult := ((Array new: 8) at: 1 put: ((0@0)); at: 2 put: ((33@ -3)); at: 3 put: ((66@ -6)); at: 4 put: ((100@ -10)); at: 5 put: ((0@0)); at: 6 put: ((33@ -33)); at: 7 put: ((66@ -66)); at: 8 put: ((100@ -100)); yourself).
	self assert: (b allPointElements collect: [ :el | el position asIntegerPoint ]) asArray equals: expectedResult
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
