Class {
	#name : #TRCameraInitializer,
	#superclass : #TRObject,
	#instVars : [
		'block'
	],
	#classVars : [
		'LastCamera'
	],
	#category : #'Trachel-Core'
}

{ #category : #public }
TRCameraInitializer class >> focusOnCenter [
	^ self new focusOnCenter
]

{ #category : #public }
TRCameraInitializer class >> restorePrevious [
	^ self new restorePrevious
]

{ #category : #accessing }
TRCameraInitializer >> block [
	^ block
]

{ #category : #accessing }
TRCameraInitializer >> block: oneArgBlock [
	"oneArgBlock takes as parameter a camera"
	block := oneArgBlock
]

{ #category : #public }
TRCameraInitializer >> executeOn: camera [
	"Do nothing"
	block rtValue: camera
]

{ #category : #'public - configuration' }
TRCameraInitializer >> focusOnCenter [
	block := [ :camera | camera focusOnCenter ]
]

{ #category : #initialization }
TRCameraInitializer >> initialize [
	super initialize.
	self focusOnCenter 
]

{ #category : #'public - configuration' }
TRCameraInitializer >> restorePrevious [
	block := [ :camera | self restorePrevious: camera ]

]

{ #category : #utility }
TRCameraInitializer >> restorePrevious: camera [
	
	LastCamera ifNil: [ LastCamera := camera ].
	camera canvas camera: LastCamera
"	camera translateTo: LastCamera position.
	camera scale: LastCamera scale."
]
