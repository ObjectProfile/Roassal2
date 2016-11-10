Class {
	#name : #ForceBasedLayout,
	#superclass : #MacroBenchmark,
	#category : #'IntelPowerGadget-Benchmarks'
}

{ #category : #hooks }
ForceBasedLayout >> execute [
	"This method contains a piece of code to execute"
	| b |
	b := RTMondrian new.
	b nodes: (1 to: 5000).
	b edges connectFrom: [ :v | v // 2 ].
	b layout force.
	b build
]
