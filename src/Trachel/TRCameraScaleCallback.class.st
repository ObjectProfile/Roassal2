Class {
	#name : #TRCameraScaleCallback,
	#superclass : #TRCallback,
	#category : #'Trachel-Callbacks'
}

{ #category : #testing }
TRCameraScaleCallback >> isCameraScaleCallback [
	^ true
]

{ #category : #action }
TRCameraScaleCallback >> scaleChanged: aScaleFactorAsInteger [
	^ block cull: self cull: aScaleFactorAsInteger
]
