Class {
	#name : #TRExtentCallback,
	#superclass : #TRCallback,
	#category : #'Trachel-Core'
}

{ #category : #testing }
TRExtentCallback >> isExtentCallback [
	^ true
]

{ #category : #actions }
TRExtentCallback >> shape: aTRShape newExtent: newExtent oldExtent: oldExtent [
	^ self
		shape: aTRShape
		ratio: newExtent / oldExtent
]

{ #category : #actions }
TRExtentCallback >> shape: aTRShape ratio: aRatio [
	^ block cull: aTRShape cull: aRatio
]
