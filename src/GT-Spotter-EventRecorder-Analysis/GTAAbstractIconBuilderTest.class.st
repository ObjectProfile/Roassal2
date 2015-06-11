Class {
	#name : #GTAAbstractIconBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Tests'
}

{ #category : #testing }
GTAAbstractIconBuilderTest class >> isAbstract [
	^ self name = #GTAAbstractIconBuilderTest
]

{ #category : #initialization }
GTAAbstractIconBuilderTest >> initializeBuilder [
	self subclassResponsibility
]

{ #category : #'instance creation' }
GTAAbstractIconBuilderTest >> newElementForEvent: anEventObject [
	^ (builder shapeFor: anEventObject) element
]

{ #category : #'instance creation' }
GTAAbstractIconBuilderTest >> newElementForEventClass: aClass [
	^ self newElementForEvent: aClass new
]

{ #category : #running }
GTAAbstractIconBuilderTest >> setUp [
	super setUp.
	self initializeBuilder.
	
]

{ #category : #tests }
GTAAbstractIconBuilderTest >> testShapeFor [
	| shape view |
	view := RTView new.
	GTSpotterRecorderEvent allSubclassesDo: [ :eachClass |
		shape := builder shapeFor: eachClass new.
		shape ifNotNil: [
			view add: shape element ]
	].
	RTHorizontalLineLayout on: view elements.
	view
]
