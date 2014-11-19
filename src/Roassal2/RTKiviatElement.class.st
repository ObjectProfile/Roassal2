Class {
	#name : #RTKiviatElement,
	#superclass : #RTObject,
	#instVars : [
		'named',
		'value',
		'position',
		'kiviatNode'
	],
	#category : #'Roassal2-Builder-Kiviat'
}

{ #category : #'as yet unclassified' }
RTKiviatElement >> initialize [
	super initialize.
]

{ #category : #'as yet unclassified' }
RTKiviatElement >> kiviatNode [
	^ kiviatNode
]

{ #category : #'as yet unclassified' }
RTKiviatElement >> kiviatNode: anRTKiviatNode [
	kiviatNode := anRTKiviatNode
]

{ #category : #'as yet unclassified' }
RTKiviatElement >> named [
 ^ named
]

{ #category : #'as yet unclassified' }
RTKiviatElement >> named: aString [
 named:= aString
]

{ #category : #'as yet unclassified' }
RTKiviatElement >> position [
	^ position
]

{ #category : #'as yet unclassified' }
RTKiviatElement >> position: aPoint [
	position:= aPoint
]

{ #category : #'as yet unclassified' }
RTKiviatElement >> value [
	^ value
]

{ #category : #'as yet unclassified' }
RTKiviatElement >> value: anObject [
	value := anObject
]
