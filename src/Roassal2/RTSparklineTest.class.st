Class {
	#name : #RTSparklineTest,
	#superclass : #RTTest,
	#category : 'Roassal2-Sparkline'
}

{ #category : #tests }
RTSparklineTest >> testValue [
	| shape e |
	shape := RTSparkline new values: [ :tuple | tuple + 10 ].
	e := shape elementOn: #(1 2 3 4 5).
	self assert: (shape valuesFor: e) = (#(1 2 3 4 5) + 10)
]
