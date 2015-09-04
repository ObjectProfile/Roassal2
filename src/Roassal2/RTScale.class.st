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
	#category : #'Roassal2-Scaling'
}

{ #category : #'instance creation' }
RTScale class >> linear [
	^ RTScaleLinear new.
]

{ #category : #accessing }
RTScale >> domain [
	^ domain
]

{ #category : #accessing }
RTScale >> domain: anObject [
	domain := anObject
]

{ #category : #accessing }
RTScale >> interpolate [
	^ interpolate
]

{ #category : #accessing }
RTScale >> interpolate: anObject [
	interpolate := anObject
]

{ #category : #transformations }
RTScale >> invert: anObject [
	self subclassResponsibility 
]

{ #category : #accessing }
RTScale >> range [
	^ range
]

{ #category : #accessing }
RTScale >> range: anObject [
	range := anObject
]

{ #category : #hooks }
RTScale >> rescale [
	self subclassResponsibility 
]

{ #category : #accessing }
RTScale >> scale: anObject [
	self subclassResponsibility 
]

{ #category : #accessing }
RTScale >> uninterpolate [
	^ uninterpolate
]

{ #category : #accessing }
RTScale >> uninterpolate: anObject [
	uninterpolate := anObject
]
