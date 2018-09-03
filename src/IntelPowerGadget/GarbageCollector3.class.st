Class {
	#name : #GarbageCollector3,
	#superclass : #MicroBenchmark,
	#category : #'IntelPowerGadget-Benchmarks'
}

{ #category : #hooks }
GarbageCollector3 >> execute [
	"This method contains a piece of code to execute"
	800000 timesRepeat: [ Array new: 10000 ]
]
