Class {
	#name : #Plot,
	#superclass : #MacroBenchmark,
	#category : #'IntelPowerGadget-Benchmarks'
}

{ #category : #hooks }
Plot >> execute [

	| b ds |
	b := RTGrapher new.
	ds := RTData new.
	ds points: (1 to: 10000 by: 0.3).
	b add: ds.
	b build
]
