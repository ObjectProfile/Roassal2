Class {
	#name : #RTScopedBuilder,
	#superclass : #RTObject,
	#instVars : [
		'condition'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #testing }
RTScopedBuilder >> canCreateForObject: anObject [
	"Return true or false on whether I can create a Roassal element for the given argument"
	^ condition rtValue: anObject
	
]

{ #category : #public }
RTScopedBuilder >> if: aCondition [
	condition := aCondition
]

{ #category : #initialization }
RTScopedBuilder >> initialize [
	super initialize.
	condition := true
]
