"
An IntelPowerGadgetTest is a test class for testing the behavior of IntelPowerGadget
"
Class {
	#name : #IntelPowerGadgetTest,
	#superclass : #TestCase,
	#instVars : [
		'p'
	],
	#category : #'IntelPowerGadget-Tests'
}

{ #category : #tests }
IntelPowerGadgetTest >> setUp [
	super setUp.
	p := EnergyProfiler new.
]

{ #category : #tests }
IntelPowerGadgetTest >> shortScript [
	^ 'Max Temp = 105
number of nodes = 1
TDP(mWh)_0 = 77.00
Base Frequency = 3200.00(MHz)
Logging...GT Frq =   350
CPU Frequency Frq =  1600
Processor power (W) =  11.48
Processor energy (J) =   1.20
Processor energy (mWh) =   0.33
IA power (W) =   6.86
IA energy (J) =   0.72
IA energy (mWh) =   0.20
Package temperature (C) =     54
Package Hot =   0
Package power limit (W) =  77.00
--------------------------
GT Frq =   350
CPU Frequency Frq =  1600
Processor power (W) =  12.48
Processor energy (J) =   1.30
Processor energy (mWh) =   0.36
IA power (W) =   7.86
IA energy (J) =   0.82
IA energy (mWh) =   0.23
Package temperature (C) =     56
Package Hot =   0
Package power limit (W) =  77.00
--------------------------
GT Frq =   350
CPU Frequency Frq =  3400
Processor power (W) =  12.58
Processor energy (J) =   1.30
Processor energy (mWh) =   0.36
IA power (W) =   7.87
IA energy (J) =   0.81
IA energy (mWh) =   0.23
Package temperature (C) =     56
Package Hot =   0
Package power limit (W) =  77.00
--------------------------
GT Frq =   350
CPU Frequency Frq =  3400
Processor power (W) =  12.54
Processor energy (J) =   1.30
Processor energy (mWh) =   0.36
IA power (W) =   7.91
IA energy (J) =   0.82
IA energy (mWh) =   0.23
Package temperature (C) =     55
Package Hot =   0
Package power limit (W) =  77.00
'
]

{ #category : #tests }
IntelPowerGadgetTest >> testBasic [

	self assert: p numberOfLogEntries equals: 0.
	p createLogEntry.
	self assert: p numberOfLogEntries equals: 1
]

{ #category : #tests }
IntelPowerGadgetTest >> testParseText [

	| entry |
	p parseText: self shortScript.
	self assert: p numberOfLogEntries equals: 4.
	
	entry := p logEntries first.
	self assert: entry cpuFrequency equals: 1600
]
