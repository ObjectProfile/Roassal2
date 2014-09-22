Class {
	#name : #RTAxisConfigurationTest,
	#superclass : #RTTest,
	#instVars : [
		'config'
	],
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #running }
RTAxisConfigurationTest >> setUp [
	config := RTAxisConfiguration new
]

{ #category : #tests }
RTAxisConfigurationTest >> testDefault [
	self deny: config areLabelRotated
]

{ #category : #tests }
RTAxisConfigurationTest >> testLabelRotation [
	self assert: config labelRotation equals: 0.
]

{ #category : #tests }
RTAxisConfigurationTest >> testLabelRotationBy45 [
	config labelRotation: -45.
	self assert: config labelRotation equals: -45
]

{ #category : #tests }
RTAxisConfigurationTest >> testNoRotation [
	config rotateLabels.
	config doNotRotateLabels.
	self deny: config areLabelRotated 
]

{ #category : #tests }
RTAxisConfigurationTest >> testRotation [
	config rotateLabels.
	self assert: config areLabelRotated 
]
