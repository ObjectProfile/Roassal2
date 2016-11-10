Class {
	#name : #GarbageCollector1,
	#superclass : #MicroBenchmark,
	#category : #'IntelPowerGadget-Benchmarks'
}

{ #category : #hooks }
GarbageCollector1 >> execute [
	"This method contains a piece of code to execute"
	500 timesRepeat: [ Array new: 3000000 ]
]
