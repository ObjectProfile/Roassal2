Class {
	#name : #EnergyProfiler,
	#superclass : #Object,
	#instVars : [
		'process',
		'logEntries',
		'parsingDictionaryCache',
		'duration',
		'logFilename'
	],
	#category : #'IntelPowerGadget-Core'
}

{ #category : #'accessing - computed' }
EnergyProfiler >> createLogEntry [
	logEntries add: (LogEntry new)
]

{ #category : #'accessing - computed' }
EnergyProfiler >> currentEntry [
	self numberOfLogEntries = 0 ifTrue: [ self createLogEntry ].
	^ logEntries last
]

{ #category : #'private - logging parsing' }
EnergyProfiler >> defaultFileName [

	^ '/tmp/power.log'
]

{ #category : #public }
EnergyProfiler >> exportAsCSV: aFullFileName [
	"Export the current data as a CSV file"
	| fr stream |
	fr := aFullFileName asFileReference.
	self assert: [ fr extension = 'csv' ] description: 'Should have a .csv file extension'.
	self assert: [ fr exists not ] description: 'File already exist. Proceed to override'.
	fr exists ifTrue: [ fr delete ].
	stream := fr writeStream.
	
	stream nextPutAll: 'id,'.
	LogEntry instVarNames sorted do: [ :varName | stream nextPutAll: varName ] separatedBy: [ stream nextPut: $, ].
	stream lf.
	self logEntries doWithIndex: [ :entry :index |
		stream nextPutAll: index asString.
		stream nextPut: $,.
		LogEntry instVarNames sorted do: [ :varName | stream nextPutAll: (entry instVarNamed: varName) asString ] separatedBy: [ stream nextPut: $, ].
		stream lf
	].
	stream close
]

{ #category : #visualization }
EnergyProfiler >> gtInspectorIdentityIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'Identity';
		initializeView: [
			| b |
			b := RTMondrian new.
			b nodes: self validLogEntries.
			b normalizer distinctColor.
			b layout grid; gapSize: 1.
			b ]
]

{ #category : #visualization }
EnergyProfiler >> gtViewCPUFreqIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'CPUFrq';
		initializeView: [
			| b ds lb |
			b := RTGrapher new.
			ds := RTData new.
			ds points: self validLogEntries.
			ds y: #cpuFrequency.
			b add: ds.
			"b addDecorator: (RTAverageDecorator new).
			b addDecorator: (RTStandardDeviationDecorator new)."
			b addDecorator: RTMeanDevVarDecorator new.
			b build.
			
			lb := RTLegendBuilder new.
			lb view: b view.
			lb addText: 'CPU frequency along time'.
			lb addText: '# snapshots = ', self validLogEntries size asString.
			lb build.
			
			b view.  ]
]

{ #category : #visualization }
EnergyProfiler >> gtViewIAPowerIn: composite [
	<gtInspectorPresentationOrder: -100>
	| lb |
	composite roassal2
		title: 'IAPow';
		initializeView: [
			| b ds |
			b := RTGrapher new.
			ds := RTData new.
			ds points: self validLogEntries.
			ds y: #iaPowerW.
			b add: ds.
			"b addDecorator: (RTAverageDecorator new).
			b addDecorator: (RTStandardDeviationDecorator new)."
			b addDecorator: RTMeanDevVarDecorator new.
			b build.
			
			lb := RTLegendBuilder new.
			lb view: b view.
			lb addText: 'Energy of the CPU/processor cores along time (IA Power (W))'.
			lb addText: '# snapshots = ', self validLogEntries size asString.
			lb build.
			
			b view. ]
]

{ #category : #visualization }
EnergyProfiler >> gtViewPkgPowerIn: composite [
	<gtInspectorPresentationOrder: -200>
	| lb |
	composite roassal2
		title: 'PkgPow';
		initializeView: [
			| b ds |
			b := RTGrapher new.
			ds := RTData new.
			ds noDot; connectColor: Color blue.
			ds points: self validLogEntries.
			ds y: #processorPower.
			b add: ds.
			"b addDecorator: (RTAverageDecorator new).
			b addDecorator: (RTStandardDeviationDecorator new)."
			b addDecorator: RTMeanDevVarDecorator new.
			b build.
			
			lb := RTLegendBuilder new.
			lb view: b view.
			lb addText: 'Energy of the CPU/processor cores along time (Pkg Power (W))'.
			lb addText: '# snapshots = ', self validLogEntries size asString.
			lb build.
			
			b view. ]
]

{ #category : #visualization }
EnergyProfiler >> gtViewTemperature2In: composite [
	<gtInspectorPresentationOrder: -100>
	| lb |
	composite roassal2
		title: 'ProcEnergy';
		initializeView: [
			| b ds |
			b := RTGrapher new.
			ds := RTData new.
			ds points: self validLogEntries.
			ds y: #processorEnergyJ.
			b add: ds.
			b build.
			
			lb := RTLegendBuilder new.
			lb view: b view.
			lb addText: 'Total energy of the processor (J)'.
			lb addText: '# snapshots = ', self validLogEntries size asString.
			lb build.
			
			b view ]
]

{ #category : #visualization }
EnergyProfiler >> gtViewTemperatureIn: composite [
	<gtInspectorPresentationOrder: -10>
	| lb |
	composite roassal2
		title: 'GTFrq';
		initializeView: [
			| b ds |
			b := RTGrapher new.
			ds := RTData new.
			ds dotShape color: Color blue trans.
			ds points: self validLogEntries.
			ds y: #gtFrequency.
			b add: ds.
			"b addDecorator: (RTAverageDecorator new).
			b addDecorator: (RTStandardDeviationDecorator new)."
			b addDecorator: RTMeanDevVarDecorator new.
			b build.
			
			lb := RTLegendBuilder new.
			lb view: b view.
			lb addText: 'Graphic Processor (GT) frequency along time'.
			lb addText: '# snapshots = ', self validLogEntries size asString.
			lb build.
			
			b view. ]
]

{ #category : #initialization }
EnergyProfiler >> initialize [
	super initialize.
	logEntries := OrderedCollection new.
	self initializeParsingDictionaryCache.
	logFilename := self defaultFileName.
]

{ #category : #initialization }
EnergyProfiler >> initializeParsingDictionaryCache [
	parsingDictionaryCache := {('GT Frq' -> #gtFrequency:).
	('Logging...GT Frq' -> #gtFrequency:).
	('CPU Frequency Frq' -> #cpuFrequency:).
	('Processor power (W)' -> #processorPower:).
	('Processor energy (J)' -> #processorEnergyJ:).
	('Processor energy (mWh)' -> #processorEnergymWH:).
	('IA power (W)' -> #iaPowerW:).
	('IA energy (J)' -> #iaEnergyJ:).
	('IA energy (mWh)' -> #iaEnergymWh:).
	('Package temperature (C)' -> #packageTemperatureC:).
	('Package Hot' -> #packageHot:).
	('Package power limit (W)' -> #packagePowerLimit:)} asDictionary
]

{ #category : #'accessing - computed' }
EnergyProfiler >> logEntries [
	^ logEntries
]

{ #category : #accessing }
EnergyProfiler >> logFilename [
	^ logFilename
]

{ #category : #accessing }
EnergyProfiler >> logFilename: anObject [
	logFilename := anObject
]

{ #category : #'accessing - computed' }
EnergyProfiler >> numberOfLogEntries [
	^ logEntries size
]

{ #category : #'private - logging parsing' }
EnergyProfiler >> parseDefaultFilename [
	"
	self new parseDefaultFilename
	"
	self parseFilenamed: logFilename
]

{ #category : #'private - logging parsing' }
EnergyProfiler >> parseFile: aFilename [
	"
	self new parseFile: ('/tmp/power.log' asFileReference readStream) 
	"
	
	(ZnFastLineReader on: self) linesDo: [ :line | self processLine: line ].
]

{ #category : #'private - logging parsing' }
EnergyProfiler >> parseFilenamed: aFileNamed [
	"
	self new parseDefaultFilename
	"
	self parseStream: aFileNamed asFileReference readStream
]

{ #category : #'private - logging parsing' }
EnergyProfiler >> parseStream: aStream [
	"
	self new parseFile: ('/tmp/power.log' asFileReference readStream) 
	"
	
	(ZnFastLineReader on: aStream) linesDo: [ :line | self processLine: line ].
]

{ #category : #'private - logging parsing' }
EnergyProfiler >> parseText: aString [
	"
	self new parseText: ('/tmp/power.log' asFileReference readStream) 
	"
	
	self parseStream: aString readStream

]

{ #category : #'private - logging parsing' }
EnergyProfiler >> processLine: aLine [
	| indexOfEqual beforeEquals afterEquals selector |
	(aLine beginsWith: '---') ifTrue: [ self createLogEntry. ^ self ].
	aLine = 'Done' ifTrue: [ ^ self ].
	
	indexOfEqual := aLine indexOf: $=.
	indexOfEqual = 0 ifTrue: [ ^ self ].
	beforeEquals := aLine copyFrom: 1 to: indexOfEqual - 1.
	afterEquals := aLine copyFrom: indexOfEqual + 1 to: aLine size.
	afterEquals trimBoth ifEmpty: [ ^ self ].
	selector:= parsingDictionaryCache at: beforeEquals trimBoth ifAbsent: [ ^ self ].
	self currentEntry perform: selector with: (Float readFrom: afterEquals trimBoth)
]

{ #category : #public }
EnergyProfiler >> profile: aBlock [
	"
	self new profile: [ (Delay forSeconds: 2) wait ] 
	self new profile: [ 40 timesRepeat: [ Object withAllSubclasses collect: #numberOfMethods ] ]
	self new profile: [ 150 timesRepeat: [ Object withAllSubclasses collect: #numberOfMethods ] ]
	self new profile: [ 1000 timesRepeat: [ Object withAllSubclasses collect: #numberOfMethods ] ]
	
	b := RTMondrian new.
	b nodes: (1 to: 5000).
	b edges connectFrom: [ :v | v // 2 ].
	b layout force.
	self new profile: [b build ]
	
	
	self new profile: [ 3 timesRepeat: [ 100000 factorial ] ]
	
	self new profile: [ 500 timesRepeat: [ Array new: 1000000 ] ]
	
	b := RTMondrianExample new exampleBezierLines.
	b build.
	b view open.
	(Delay forSeconds: 5) wait.
	self new profile: [ (Delay forSeconds: 20) wait ].
	
	"
	self profileAndGenerateLog: aBlock.
	self waitABit.
	self parseFilenamed: logFilename
	
	"USING OSPROCESS -- buggy code--"
"	process := OSProcess command: '/Applications/Intel\ Power\ Gadget/PowerLog -duration 500 -verbose > ', self defaultFileName.
	duration := aBlock timeToRun.
	process sigquit.
	process terminate.
	self waitABit.
	 
	self parseFilenamed: self defaultFileName"
]

{ #category : #public }
EnergyProfiler >> profileAndGenerateLog: aBlock [
	"
	self new profile: [ (Delay forSeconds: 2) wait ] 
	self new profile: [ 40 timesRepeat: [ Object withAllSubclasses collect: #numberOfMethods ] ]
	self new profile: [ 150 timesRepeat: [ Object withAllSubclasses collect: #numberOfMethods ] ]
	self new profile: [ 1000 timesRepeat: [ Object withAllSubclasses collect: #numberOfMethods ] ]
	
	b := RTMondrian new.
	b nodes: (1 to: 5000).
	b edges connectFrom: [ :v | v // 2 ].
	b layout force.
	self new profile: [b build ]
	
	
	self new profile: [ 3 timesRepeat: [ 100000 factorial ] ]
	
	self new profile: [ 500 timesRepeat: [ Array new: 1000000 ] ]
	
	b := RTMondrianExample new exampleBezierLines.
	b build.
	b view open.
	(Delay forSeconds: 5) wait.
	self new profile: [ (Delay forSeconds: 20) wait ].
	
	"
	process := (OSSUnixSubprocess new
						command: '/Applications/Intel Power Gadget/PowerLog';
						arguments: #('-duration' '10000000' '-verbose');
						redirectStdoutTo: (StandardFileStream forceNewFileNamed: logFilename);
						run).
	duration := aBlock timeToRun.
	process terminate

]

{ #category : #'accessing - computed' }
EnergyProfiler >> validLogEntries [
	^ self logEntries select: #isValid
]

{ #category : #public }
EnergyProfiler >> viewLogFile [
	'/tmp' asFileReference 
	
]

{ #category : #'private - utility' }
EnergyProfiler >> waitABit [
	(Delay forSeconds: 4) wait
]
