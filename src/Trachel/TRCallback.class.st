Class {
	#name : #TRCallback,
	#superclass : #TRObject,
	#instVars : [
		'block'
	],
	#category : #'Trachel-Core'
}

{ #category : #public }
TRCallback class >> block: aBlock [
	^ self new block: aBlock
]

{ #category : #accessing }
TRCallback >> block [
	^ block
	
]

{ #category : #accessing }
TRCallback >> block: aOneArgBlock [
	"aThreeArgBlock follows the pattern [ :shape | ... ]"
	block := aOneArgBlock
]

{ #category : #initialization }
TRCallback >> initialize [
	super initialize.
	block := [ :aShape :aValue | ]
]

{ #category : #testing }
TRCallback >> isExtentCallback [
	^ false
]

{ #category : #testing }
TRCallback >> isTranslationCallback [
	^ false
]
