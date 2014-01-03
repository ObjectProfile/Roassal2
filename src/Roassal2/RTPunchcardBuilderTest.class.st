"
A ROPunchcardBuilderTest is xxxxxxxxx.

Instance Variables
	builder:		<Object>
	emptyBuilder:		<Object>
	view:		<Object>

builder
	- xxxxx

emptyBuilder
	- xxxxx

view
	- xxxxx

"
Class {
	#name : #RTPunchcardBuilderTest,
	#superclass : #ROTest,
	#instVars : [
		'builder',
		'emptyBuilder',
		'view'
	],
	#category : #'Roassal2-Builder-Punchard'
}

{ #category : #running }
RTPunchcardBuilderTest >> setUp [

	builder := RTPunchcardBuilder new.
	builder addModels: #( 'hello' 'world' 'hello world' ).
	builder addMetric: [:word | word size] namedAs: 'length'.

	emptyBuilder := RTPunchcardBuilder new.
]

{ #category : #running }
RTPunchcardBuilderTest >> setUp [

	builder := RTPunchcardBuilder new.
	builder addModels: #( 'hello' 'world' 'hello world' ).
	builder addMetric: [:word | word size] namedAs: 'length'.

	emptyBuilder := RTPunchcardBuilder new.
]

{ #category : #tests }
RTPunchcardBuilderTest >> testCreation [

	self assert: emptyBuilder numberOfModels = 0.
	self assert: emptyBuilder numberOfMetrics = 0.
]

{ #category : #tests }
RTPunchcardBuilderTest >> testCreation [

	self assert: emptyBuilder numberOfModels = 0.
	self assert: emptyBuilder numberOfMetrics = 0.
]

{ #category : #tests }
RTPunchcardBuilderTest >> testRendering [

	view := RTView new.
	builder renderOn: view.
	self assert: view numberOfElements = 7
]

{ #category : #tests }
RTPunchcardBuilderTest >> testRendering [

	view := RTView new.
	builder renderOn: view.
	self assert: view numberOfElements = 7
]

{ #category : #tests }
RTPunchcardBuilderTest >> testSimpleScenario [
	self assert: builder numberOfModels = 3.
	self assert: builder numberOfMetrics = 1.
]

{ #category : #tests }
RTPunchcardBuilderTest >> testSimpleScenario [
	self assert: builder numberOfModels = 3.
	self assert: builder numberOfMetrics = 1.
]

{ #category : #tests }
RTPunchcardBuilderTest >> testTwoMetricsScenario [
	builder addMetric: [:word | word size * 2] namedAs: 'double lenght'.
	
	self assert: builder numberOfModels = 3.
	self assert: builder numberOfMetrics = 2.
]

{ #category : #tests }
RTPunchcardBuilderTest >> testTwoMetricsScenario [
	builder addMetric: [:word | word size * 2] namedAs: 'double lenght'.
	
	self assert: builder numberOfModels = 3.
	self assert: builder numberOfMetrics = 2.
]
