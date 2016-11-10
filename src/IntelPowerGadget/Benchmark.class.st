Class {
	#name : #Benchmark,
	#superclass : #Object,
	#category : #'IntelPowerGadget-Benchmarks'
}

{ #category : #'private - util' }
Benchmark >> cleanMemory [
	2 timesRepeat: [ Smalltalk garbageCollect ].
	Object
		new;
		new;
		new.
	2 timesRepeat: [ Smalltalk garbageCollect ]
]

{ #category : #public }
Benchmark >> convertAllToCSV [
	"
	PUBLIC Method
	run all the benchmarks
	
	Benchmark new convertAllToCSV
	"
	<script: 'Benchmark new convertAllToCSV'>
	(Benchmark allSubclasses reject: [ :c | c hasSubclasses ]) do: [ :c | c new convertToCSV ]
]

{ #category : #public }
Benchmark >> convertToCSV [
	EnergyProfiler new
		parseFilenamed: self logFileName;
		exportAsCSV: self logFileName, '.csv'

]

{ #category : #'private - util' }
Benchmark >> createNewBenchmark [
	"
	self new createNewBenchmark
	"
	<script: 'Benchmark new createNewBenchmark'>
	| clsName cls |
	clsName := UIManager default request: 'Enter a class name' initialAnswer: 'MyNewBenchmark'.
	(clsName isNil or: [ clsName isEmpty or: [ clsName first isUppercase not ] ]) ifTrue: [ ^ self ].

	cls := Benchmark subclass: clsName asSymbol
				instanceVariableNames: ''
				classVariableNames: ''
				package: 'IntelPowerGadget-Benchmarks'.
	
	cls compile: 'execute
	"This method contains a piece of code to execute"
	self subclassResponsibility' classified: 'hooks'.

]

{ #category : #hooks }
Benchmark >> execute [
	"This method contains a piece of code to execute"
	self subclassResponsibility 
]

{ #category : #public }
Benchmark >> exportBenchmarkSourceAsFile [
	"
	(self allSubclasses reject: #hasSubclasses) do: [ :cls |
		| source |
		source := String lf join: (cls >> #execute) getSource lines allButFirst.
		source := source, String lf, 'Smalltalk quitPrimitive'.
		(cls name, '.st') asFileReference writeStream
			nextPutAll: source; close   ]
	
	"
]

{ #category : #'private - util' }
Benchmark >> getTimeNow [
	^ (Time microsecondClockValue // 1000) asInteger
]

{ #category : #'private - util' }
Benchmark >> log: aString [
	"
	Very simple log mechanism
	
	self new log: 'hello world'.
	self new log: '--------'.
	"
	| f |
	f := 'energyBencharmarkRun.txt' asFileReference writeStream.
	f setToEnd.
	f nextPutAll: aString; cr.
	f close
]

{ #category : #'private - util' }
Benchmark >> logDirectoryName [
	^ '/Users/alexandrebergel/Dropbox/EnergyProfilingData/'
]

{ #category : #'private - util' }
Benchmark >> logFileName [
	^ self logDirectoryName , self title , '.log'
]

{ #category : #'private - util' }
Benchmark >> numberOfFullGC [
	^ VirtualMachine new parameterAt: 7
]

{ #category : #'private - util' }
Benchmark >> numberOfIncrementalGC [
	^ VirtualMachine new parameterAt: 9
]

{ #category : #configuration }
Benchmark >> numberOfSecondsToWait [
	"Number of seconds to wait before executing the benchmark. Use to to have the CPU cool down a bit"
	^ 5
]

{ #category : #public }
Benchmark >> run [
	"run a particular benchmarks. This method is invoked by #runAllBenchmarks"
	| i time nbIncrGC newNbIncrGC nbFullGC newNbFullGC newTime |
	self cleanMemory.
	self waitABit.
	time := self getTimeNow.
	nbIncrGC := self numberOfIncrementalGC.
	nbFullGC := self numberOfFullGC.
	i := EnergyProfiler new
		logFilename: self logFileName;
		profileAndGenerateLog: [ self execute.
			newNbIncrGC := self numberOfIncrementalGC.
			newNbFullGC := self numberOfFullGC.
			newTime := self getTimeNow ].
	"self waitABit.
	i exportAsCSV: self logFileName , '.csv'."
	self
		log:
			DateAndTime now asString , '--' , self class name , 
				'  duration:', ((newTime - time) // 1000) asString , 
				'  nbOfIncrGC:', (newNbIncrGC - nbIncrGC) asString ,
				'  nbOfFullGC:', (newNbIncrGC - nbIncrGC) asString

]

{ #category : #public }
Benchmark >> runAllBenchmarks [
	"
	PUBLIC Method
	run all the benchmarks
	
	Benchmark new runAllBenchmarks
	"
	<script: 'Benchmark new runAllBenchmarks'>
	self log: '-----'.
	(Benchmark allSubclasses reject: [ :c | c hasSubclasses ]) do: [ :c | c new run ]
]

{ #category : #'private - util' }
Benchmark >> title [
	"this method should return a name. The name is used to generate the log file"
	^ self class name
]

{ #category : #'private - util' }
Benchmark >> viewFiles [
	<script: 'self new viewFiles'>
	"
	self new viewFiles
	"

	self logDirectoryName asFileReference inspect
]

{ #category : #'private - util' }
Benchmark >> waitABit [
	(Delay forSeconds: self numberOfSecondsToWait) wait
]
