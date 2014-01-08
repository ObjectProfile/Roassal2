Class {
	#name : #TREvent,
	#superclass : #Announcement,
	#instVars : [
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
TREvent >> morph [
	^ morph
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
TREvent >> signalUpdate [
	morph notNil ifTrue: [ morph changed ]
	
]
