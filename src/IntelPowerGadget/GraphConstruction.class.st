Class {
	#name : #GraphConstruction,
	#superclass : #MacroBenchmark,
	#category : #'IntelPowerGadget-Benchmarks'
}

{ #category : #hooks }
GraphConstruction >> execute [

	| b |
	b := RTMondrian new.
	b nodes: (1 to: 70000).
	b edges connectFrom: [ :v | v // 2 ].
	b layout grid.
	b build
]
