Class {
	#name : #TRAddedCallback,
	#superclass : #TRCallback,
	#category : #'Trachel-Callbacks'
}

{ #category : #adding }
TRAddedCallback >> addShape: aTRShape [ 
	^ block cull: aTRShape 
]

{ #category : #testing }
TRAddedCallback >> isAddedCallback [
	^ true
]
