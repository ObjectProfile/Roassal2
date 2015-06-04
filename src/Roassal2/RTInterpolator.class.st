"
An interpolator a way to create lines in SVG
"
Class {
	#name : #RTInterpolator,
	#superclass : #RTObject,
	#instVars : [
		'tension'
	],
	#category : #'Roassal2-Experimental'
}

{ #category : #testing }
RTInterpolator >> closed [
	^ false.
]

{ #category : #public }
RTInterpolator >> interpolate: points [
	
]

{ #category : #converting }
RTInterpolator >> reverse [
	^ self.
]

{ #category : #'*Roassal2' }
RTInterpolator >> rtValue: anArgument [
	| value |
	value := anArgument.
	(anArgument isKindOf: Association)
		ifTrue: [ 
			self tension: anArgument value.
			value := anArgument key. ].
	
	^ self interpolate: value.
]

{ #category : #public }
RTInterpolator >> tension: aNumber [
	tension := aNumber
]
