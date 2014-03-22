Class {
	#name : #TREvent,
	#superclass : #Announcement,
	#instVars : [
		'canvas',
		'position',
		'morph'
	],
	#category : #'Trachel-Core'
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
TREvent >> positionFromCamera [
	"Return the position from the camera. I.e., 0 @ 0 is at the center of the window"
	^ canvas camera fromPixelToSpace: self position
]

{ #category : #accessing }
TREvent >> signalUpdate [
	morph notNil ifTrue: [ morph changed ]
	
]
