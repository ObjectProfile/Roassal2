Class {
	#name : #GarbageCollector4,
	#superclass : #MicroBenchmark,
	#category : #'IntelPowerGadget-Benchmarks'
}

{ #category : #hooks }
GarbageCollector4 >> execute [
	"This method contains a piece of code to execute"
	800000 timesRepeat: [ 
		| arr |
		arr := Array new: 10000.
		1 to: arr size do: [ :i | arr at: i put: 42 ] ]
]
