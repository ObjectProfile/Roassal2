Class {
	#name : #TRTranslationCallback,
	#superclass : #Object,
	#instVars : [
		'block'
	],
	#category : #Trachel
}

{ #category : #public }
TRTranslationCallback class >> block: aBlock [
	^ self new block: aBlock
]

{ #category : #accessing }
TRTranslationCallback >> block [
	^ block
	
]

{ #category : #accessing }
TRTranslationCallback >> block: aOneArgBlock [
	"aThreeArgBlock follows the pattern [ :shape | ... ]"
	block := aOneArgBlock
]

{ #category : #initialization }
TRTranslationCallback >> initialize [
	super initialize.
	block := [ :shape :step | ]
]
