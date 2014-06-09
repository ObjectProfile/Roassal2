Class {
	#name : #TRCameraTest,
	#superclass : #TRTest,
	#instVars : [
		'camera',
		'canvas'
	],
	#category : #'Trachel-Core'
}

{ #category : #running }
TRCameraTest >> setUp [
	super setUp. 
	canvas := TRCanvas new.
	camera := canvas camera
]

{ #category : #conversion }
TRCameraTest >> testConversion [
	self assert: (camera fromSpaceToPixel: 0 @ 0) = (canvas extent / 2).
	self assert: (camera fromSpaceToPixel: 10 @ 10) = ((canvas extent / 2) + (10 @ 10)).

	self assert: (camera fromPixelToSpace: (canvas extent / 2)) = (0 @ 0).
	self assert: (camera fromPixelToSpace: ((canvas extent / 2) + (10 @ 10))) = (10 @ 10).
	
	camera
		translateTo: 21578 @ -1239;
		scale: 736.
		
	self
		assert: (camera fromPixelToSpace: (camera fromSpaceToPixel: 100 @ 100))
		equals: 100 @ 100
]

{ #category : #focusing }
TRCameraTest >> testFocusingCenter [
	canvas addShape: (TREllipseShape new from: 50 @ 50 to: 100 @ 80).
	canvas camera focusOnCenter.
	self assert: canvas camera position = (75 @ 65)
]

{ #category : #tests }
TRCameraTest >> testInitialization [
	self assert: camera position = (0 @ 0)
]

{ #category : #tests }
TRCameraTest >> testTranslation [
	camera translateTo: 5 @ 3.
	self assert: camera position = (5 @ 3).
	
	camera translateBy: 2 @ 4.
	self assert: camera position = (7 @ 7).
]
