Class {
	#name : #RTSunburstStrategy,
	#superclass : #RTObject,
	#instVars : [
		'builder',
		'angularSpacing',
		'radialSpacing',
		'hasCenter'
	],
	#category : #'Roassal2-Builder-Sunburst'
}

{ #category : #accessing }
RTSunburstStrategy >> angularSpacing [
	^ angularSpacing
]

{ #category : #accessing }
RTSunburstStrategy >> angularSpacing: anInteger [
	angularSpacing := anInteger
]

{ #category : #accessing }
RTSunburstStrategy >> builder [
	^ builder
]

{ #category : #accessing }
RTSunburstStrategy >> builder: aBuilder [
	builder := aBuilder
	
]

{ #category : #accessing }
RTSunburstStrategy >> hasCenter [
	^ hasCenter
]

{ #category : #accessing }
RTSunburstStrategy >> hasCenter: aBool [
	hasCenter := aBool
]

{ #category : #initialization }
RTSunburstStrategy >> initialize [
	super initialize.
	self hasCenter: true.
	self angularSpacing: 0.
	self radialSpacing: 5.
]

{ #category : #public }
RTSunburstStrategy >> on: elements [
	self subclassResponsibility
]

{ #category : #accessing }
RTSunburstStrategy >> radialSpacing [
	^ radialSpacing 
]

{ #category : #accessing }
RTSunburstStrategy >> radialSpacing: aNumber [
	radialSpacing := aNumber
]

{ #category : #public }
RTSunburstStrategy >> withoutCenter [
	self hasCenter: false
]
