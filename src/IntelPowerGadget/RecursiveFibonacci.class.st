Class {
	#name : #RecursiveFibonacci,
	#superclass : #MicroBenchmark,
	#category : #'IntelPowerGadget-Benchmarks'
}

{ #category : #'as yet unclassified' }
RecursiveFibonacci >> execute [
	"This method contains a piece of code to execute"
	3 timesRepeat: [ 44 fibonacci ]
]
