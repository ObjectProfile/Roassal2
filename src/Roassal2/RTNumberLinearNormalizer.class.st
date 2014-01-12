"
A RONumberLinearNormalizer is xxxxxxxxx.

Instance Variables
	scale:		<Object>

scale
	- xxxxx

"
Class {
	#name : #RTNumberLinearNormalizer,
	#superclass : #RTNLinearNormalizer,
	#instVars : [
		'scale'
	],
	#category : #'Roassal2-ColorNormalizer'
}

{ #category : #initialization }
RTNumberLinearNormalizer >> initialize [
	super initialize.
	scale := 1
]

{ #category : #accessing }
RTNumberLinearNormalizer >> rtValue: anEntity [
	"Normalize value based on maximum value."
	
	| value |
	value := self command roValue: anEntity.
	^ ((value abs / (self maximumValue: anEntity)) asFloat * self scale) asInteger
]

{ #category : #accessing }
RTNumberLinearNormalizer >> scale [
	^ scale
]

{ #category : #accessing }
RTNumberLinearNormalizer >> scale: anObject [
	scale := anObject
]
