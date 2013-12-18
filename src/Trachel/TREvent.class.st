Class {
	#name : #TREvent,
	#superclass : #Announcement,
	#instVars : [
		'shape',
		'canvas',
		'position',
		'morph'
	],
	#category : #Trachel
}

{ #category : #accessing }
TREvent >> canvas [
	
	^ canvas
]

{ #category : #accessing }
TREvent >> canvas: aTrachelCanvas [
	
	canvas := aTrachelCanvas
]

{ #category : #accessing }
TREvent >> element [
	^ self shape element
]

{ #category : #accessing }
TREvent >> morph: aMorph [
	morph := aMorph
]

{ #category : #accessing }
TREvent >> position [
	
	^ position
]

{ #category : #accessing }
TREvent >> position: aPoint [
	
	position := aPoint
]

{ #category : #accessing }
TREvent >> shape [
	
	^ shape
]

{ #category : #accessing }
TREvent >> shape: aTrachelShape [
	
	shape := aTrachelShape
]

{ #category : #accessing }
TREvent >> signalUpdate [
	morph notNil ifTrue: [ morph changed ]
	
]
