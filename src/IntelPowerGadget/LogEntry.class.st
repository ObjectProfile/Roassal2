Class {
	#name : #LogEntry,
	#superclass : #Object,
	#instVars : [
		'gtFrequency',
		'cpuFrequency',
		'processorPower',
		'processorEnergyJ',
		'processorEnergymWH',
		'iaPowerW',
		'iaEnergyJ',
		'iaEnergymWh',
		'packageTemperatureC',
		'packageHot',
		'packagePowerLimit'
	],
	#category : #'IntelPowerGadget-Core'
}

{ #category : #accessing }
LogEntry >> cpuFrequency [
	^ cpuFrequency
]

{ #category : #accessing }
LogEntry >> cpuFrequency: anObject [
	cpuFrequency := anObject
]

{ #category : #accessing }
LogEntry >> gtFrequency [
	^ gtFrequency
]

{ #category : #accessing }
LogEntry >> gtFrequency: anObject [
	gtFrequency := anObject
]

{ #category : #accessing }
LogEntry >> iaEnergyJ [
	^ iaEnergyJ
]

{ #category : #accessing }
LogEntry >> iaEnergyJ: anObject [
	iaEnergyJ := anObject
]

{ #category : #accessing }
LogEntry >> iaEnergymWh [
	^ iaEnergymWh
]

{ #category : #accessing }
LogEntry >> iaEnergymWh: anObject [
	iaEnergymWh := anObject
]

{ #category : #accessing }
LogEntry >> iaPowerW [
	^ iaPowerW
]

{ #category : #accessing }
LogEntry >> iaPowerW: anObject [
	iaPowerW := anObject
]

{ #category : #testing }
LogEntry >> isValid [
	^ gtFrequency notNil & cpuFrequency notNil & processorPower notNil & processorEnergyJ notNil & processorEnergymWH notNil & iaPowerW notNil & iaEnergyJ notNil & iaEnergymWh notNil & packageTemperatureC notNil & packageHot notNil & packagePowerLimit notNil
]

{ #category : #accessing }
LogEntry >> packageHot [
	^ packageHot
]

{ #category : #accessing }
LogEntry >> packageHot: anObject [
	packageHot := anObject
]

{ #category : #accessing }
LogEntry >> packagePowerLimit [
	^ packagePowerLimit
]

{ #category : #accessing }
LogEntry >> packagePowerLimit: anObject [
	packagePowerLimit := anObject
]

{ #category : #accessing }
LogEntry >> packageTemperatureC [
	^ packageTemperatureC
]

{ #category : #accessing }
LogEntry >> packageTemperatureC: anObject [
	packageTemperatureC := anObject
]

{ #category : #accessing }
LogEntry >> processorEnergyJ [
	^ processorEnergyJ
]

{ #category : #accessing }
LogEntry >> processorEnergyJ: anObject [
	processorEnergyJ := anObject
]

{ #category : #accessing }
LogEntry >> processorEnergymWH [
	^ processorEnergymWH
]

{ #category : #accessing }
LogEntry >> processorEnergymWH: anObject [
	processorEnergymWH := anObject
]

{ #category : #accessing }
LogEntry >> processorPower [
	^ processorPower
]

{ #category : #accessing }
LogEntry >> processorPower: anObject [
	processorPower := anObject
]
