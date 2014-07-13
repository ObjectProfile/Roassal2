Class {
	#name : #RTCharterBuilderTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #'as yet unclassified' }
RTCharterBuilderTest >> testSimpleScatterplot [

	| b |
	b := RTCharterBuilder new.
	b extent: 100 @ 100.
	b x: #yourself.
	b y: [ :v | v * v ].
	b size: #numberOfVariable min: 5 max: 15.
	b shape ellipse.
	b points: (1 to: 30).
	b build.
]
