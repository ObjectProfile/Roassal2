Class {
	#name : #TRRemoveCallback,
	#superclass : #TRCallback,
	#category : #'Trachel-Core'
}

{ #category : #testing }
TRRemoveCallback >> isRemoveCallback [
	^ true
]

{ #category : #linking }
TRRemoveCallback >> removeShape: aTRShape [ 
	^ block cull: aTRShape 
]
