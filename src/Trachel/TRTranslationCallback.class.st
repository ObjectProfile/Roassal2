Class {
	#name : #TRTranslationCallback,
	#superclass : #TRCallback,
	#category : #'Trachel-Core'
}

{ #category : #testing }
TRTranslationCallback >> isTranslationCallback [
	^ true
]

{ #category : #actions }
TRTranslationCallback >> shape: aTRShape step: aStep [ 
	"aStep is a point that represents a translation step"
	^ block cull: aTRShape cull: aStep
]
