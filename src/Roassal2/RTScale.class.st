"
A class to have nice scales checks subclasses
"
Class {
	#name : #RTScale,
	#superclass : #RTObject,
	#instVars : [
		'range',
		'domain',
		'interpolate',
		'uninterpolate'
	],
	#category : #'Roassal2-Experimental'
}

{ #category : #'instance creation' }
RTScale class >> linear [
	^ RTScaleLinear new.
]

{ #category : #'as yet unclassified' }
RTScale >> domain [
	^ domain
]

{ #category : #'as yet unclassified' }
RTScale >> domain: anObject [
	domain := anObject
]

{ #category : #'as yet unclassified' }
RTScale >> interpolate [
	^ interpolate
]

{ #category : #'as yet unclassified' }
RTScale >> interpolate: anObject [
	interpolate := anObject
]

{ #category : #'as yet unclassified' }
RTScale >> invert: anObject [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
RTScale >> range [
	^ range
]

{ #category : #'as yet unclassified' }
RTScale >> range: anObject [
	range := anObject
]

{ #category : #'as yet unclassified' }
RTScale >> rescale [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
RTScale >> scale: anObject [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
RTScale >> uninterpolate [
	^ uninterpolate
]

{ #category : #'as yet unclassified' }
RTScale >> uninterpolate: anObject [
	uninterpolate := anObject
]
