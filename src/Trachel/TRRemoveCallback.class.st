Class {
	#name : #TRRemoveCallback,
	#superclass : #TRCallback,
	#category : #'Trachel-Callbacks'
}

{ #category : #testing }
TRRemoveCallback >> isRemoveCallback [
	^ true
]

{ #category : #linking }
TRRemoveCallback >> removeShape: aTRShape [ 
	^ block cull: aTRShape 
]
