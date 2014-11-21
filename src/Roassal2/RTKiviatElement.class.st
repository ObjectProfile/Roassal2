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

{ #category : #initialization }
RTKiviatElement >> initialize [
	super initialize.
]

{ #category : #accessing }
RTKiviatElement >> kiviatNode [
	^ kiviatNode
]

{ #category : #accessing }
RTKiviatElement >> kiviatNode: anRTKiviatNode [
	kiviatNode := anRTKiviatNode
]

{ #category : #accessing }
RTKiviatElement >> named [
 ^ named
]

{ #category : #accessing }
RTKiviatElement >> named: aString [
 named:= aString
]

{ #category : #accessing }
RTKiviatElement >> position [
	^ position
]

{ #category : #accessing }
RTKiviatElement >> position: aPoint [
	position:= aPoint
]

{ #category : #accessing }
RTKiviatElement >> value [
	^ value
]

{ #category : #accessing }
RTKiviatElement >> value: anObject [
	value := anObject
]
