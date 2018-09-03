Class {
	#name : #RecursiveFactorial,
	#superclass : #MicroBenchmark,
	#category : #'IntelPowerGadget-Benchmarks'
}

{ #category : #hooks }
RecursiveFactorial >> execute [
	"This method contains a piece of code to execute"
	3 timesRepeat: [ 70000 factorial ]
]
