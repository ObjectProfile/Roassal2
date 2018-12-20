Class {
	#name : #RTExperimentalExampleTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Tests'
}

{ #category : #tests }
RTExperimentalExampleTest >> testBasic [
	"Should not raise an error"
	| view |
	view := RTExperimentalExample new exampleClusterBezierAndSlider.
	view canvas buildMorph drawOnMockCanvas
]
