"
A RTForceBasedLayoutTest is a test class for testing the behavior of RTForceBasedLayout
"
Class {
	#name : #RTForceBasedLayoutTest,
	#superclass : #TestCase,
	#category : #'Roassal2-Tests'
}

{ #category : #tests }
RTForceBasedLayoutTest >> testBasic [
	| l |
	l := RTForceBasedLayout new.
	self assert: l shouldUseProgressBar.
	
	l doNotUseProgressBar.
	self deny: l shouldUseProgressBar.
]
