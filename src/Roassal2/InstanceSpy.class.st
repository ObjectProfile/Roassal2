Class {
	#name : #InstanceSpy,
	#superclass : #Object,
	#instVars : [
		'classesToMonitor'
	],
	#category : #'Roassal2-Builder-MemoryProfiler'
}

{ #category : #'as yet unclassified' }
InstanceSpy >> example01 [
	"
	self new example01
	"

	| spy |
	spy := InstanceSpy new.
	spy monitor: TRMouseMove.
	spy monitor: TRMouseEnter.
	spy monitor: TRMouseLeave.
	spy open
]

{ #category : #'as yet unclassified' }
InstanceSpy >> example02 [
	"
	self new example02
	"

	| spy |
	spy := InstanceSpy new.
	spy monitor: ROMouseMove.
	spy monitor: ROMouseEnter.
	spy monitor: ROMouseLeave.
	spy open
]

{ #category : #'as yet unclassified' }
InstanceSpy >> example03 [
	"
	self new example03
	"

	| spy |
	spy := InstanceSpy new.
	spy monitor: ROElement.
	spy monitor: ROEdge.
	spy monitor: ROLabel.
	spy monitor: ROMouseEnter.
	spy open
]

{ #category : #'as yet unclassified' }
InstanceSpy >> example04 [
	"
	self new example04
	"

	| spy |
	spy := InstanceSpy new.
	spy monitor: RTElement.
	spy monitor: RTEdge.
	spy monitor: RTLabel.
	spy monitor: TRMouseEnter.
	spy monitor: TRMouseLeave.
	spy monitor: TRMouseMove.
	spy open.
	spy
]

{ #category : #'as yet unclassified' }
InstanceSpy >> initialize [
	super initialize.
	classesToMonitor := OrderedCollection new
]

{ #category : #'as yet unclassified' }
InstanceSpy >> monitor: aClass [
	classesToMonitor add: aClass
]

{ #category : #'as yet unclassified' }
InstanceSpy >> numberOfClassesToMonitor [
	^ classesToMonitor size
]

{ #category : #'as yet unclassified' }
InstanceSpy >> open [

	| view shape elements |
	view := RTView new.
	shape := RTBox new size: [ :cls | ((cls allInstances size + 1) log * 40) max: 5 ].
	elements := shape elementsOn: classesToMonitor.
	elements @ (RTPopup new text: [ :cls | self textInfoFor: cls ]) .
	view addAll: elements.
	RTGridLayout on: view elements.

	view addAnimation: (RTRefreshShapes new view: view; elements: view elements; yourself).
	view open
	

]

{ #category : #'as yet unclassified' }
InstanceSpy >> textInfoFor: cls [

	| s |
	s := WriteStream on: String new.
	s nextPutAll: cls name.
	s nextPutAll: ' => '.
	s nextPutAll: cls allInstances size printString.
	s nextPutAll: ' instances'.
	^ s contents
]
