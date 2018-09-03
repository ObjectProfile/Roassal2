Class {
	#name : #InstanceSpyTest,
	#superclass : #TestCase,
	#instVars : [
		'spy'
	],
	#category : #'RoassalObsolete-Builder-MemoryProfiler'
}

{ #category : #running }
InstanceSpyTest >> setUp [
	super setUp.
	spy := InstanceSpy new
]

{ #category : #tests }
InstanceSpyTest >> testDefault [

	self assert: spy numberOfClassesToMonitor equals: 0
]

{ #category : #tests }
InstanceSpyTest >> testNumberOfClassesToMonitor [
	spy monitor: Announcer.
	self assert: spy numberOfClassesToMonitor equals: 1.
	spy monitor: InstanceSpy.
	self assert: spy numberOfClassesToMonitor equals: 2
]
