"
A ROPunchcardExample is xxxxxxxxx.

Instance Variables
	builder:		<Object>

builder
	- xxxxx

"
Class {
	#name : #RTPunchcardExample,
	#superclass : #ROObject,
	#instVars : [
		'builder'
	],
	#category : #'Roassal2-Builder-Punchard'
}

{ #category : #example }
RTPunchcardExample >> example [

"
self new example
"

builder := RTPunchcardBuilder new.
builder addModels: #( 'hello' 'world' 'hello world' ).
builder addMetric: [:word | word size] namedAs: 'length'.
builder minColor: Color green.
builder maxColor: Color red.
builder open
]

{ #category : #example }
RTPunchcardExample >> example [

"
self new example
"

builder := RTPunchcardBuilder new.
builder addModels: #( 'hello' 'world' 'hello world' ).
builder addMetric: [:word | word size] namedAs: 'length'.
builder minColor: Color green.
builder maxColor: Color red.
builder open
]

{ #category : #example }
RTPunchcardExample >> example2 [

"
self new example2
"

builder := RTPunchcardBuilder new.
builder addModels: #( 'hello' 'world' 'hello world' ).
builder addMetric: [:word | word size] namedAs: 'length'.
builder addMetric: [:word | word size * 2 ] namedAs: 'length 2'.
builder open.
]

{ #category : #example }
RTPunchcardExample >> example2 [

"
self new example2
"

builder := RTPunchcardBuilder new.
builder addModels: #( 'hello' 'world' 'hello world' ).
builder addMetric: [:word | word size] namedAs: 'length'.
builder addMetric: [:word | word size * 2 ] namedAs: 'length 2'.
builder open.
]

{ #category : #example }
RTPunchcardExample >> example3 [

"
self new example3
"

builder := RTPunchcardBuilder new.
builder addModels: #( 'hello' 'world' 'hello world' ).
builder addMetric: [:word | word size] namedAs: 'length'.
builder addMetric: [:word | word size * 2 ] namedAs: 'length 2'.
builder minColor: Color green.
builder maxColor: Color red.
builder open.
]

{ #category : #example }
RTPunchcardExample >> example3 [

"
self new example3
"

builder := RTPunchcardBuilder new.
builder addModels: #( 'hello' 'world' 'hello world' ).
builder addMetric: [:word | word size] namedAs: 'length'.
builder addMetric: [:word | word size * 2 ] namedAs: 'length 2'.
builder minColor: Color green.
builder maxColor: Color red.
builder open.
]

{ #category : #example }
RTPunchcardExample >> example4 [

"
self new example4
"

builder := RTPunchcardBuilder new.
builder addModels: (RTObject withAllSubclasses copyFrom: 3 to: 4).
builder addMetric: [ :c | c numberOfMethods + 5] namedAs: 'NOM'.
builder addMetric: [ :c | c numberOfVariables * 5 ] namedAs: 'NOA'.
builder addMetric: [ :c | c numberOfSubclasses * 5  ] namedAs: 'NOS'.
"builder popupText: [ :class :metricName :value | 'The value of ', metricName, ' for ', class name, ' is ', value asString ]."
builder minColor: Color green.
builder maxColor: Color red.
builder open.
]

{ #category : #example }
RTPunchcardExample >> example4 [

"
self new example4
"

builder := RTPunchcardBuilder new.
builder addModels: (RTObject withAllSubclasses copyFrom: 3 to: 4).
builder addMetric: [ :c | c numberOfMethods + 5] namedAs: 'NOM'.
builder addMetric: [ :c | c numberOfVariables * 5 ] namedAs: 'NOA'.
builder addMetric: [ :c | c numberOfSubclasses * 5  ] namedAs: 'NOS'.
"builder popupText: [ :class :metricName :value | 'The value of ', metricName, ' for ', class name, ' is ', value asString ]."
builder minColor: Color green.
builder maxColor: Color red.
builder open.
]
