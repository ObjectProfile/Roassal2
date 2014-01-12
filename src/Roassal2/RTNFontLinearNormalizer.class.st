"
A RONFontLinearNormalizer is xxxxxxxxx.

"
Class {
	#name : #RTNFontLinearNormalizer,
	#superclass : #RTNLinearNormalizer,
	#category : #'Roassal2-ColorNormalizer'
}

{ #category : #accessing }
RTNFontLinearNormalizer >> rtValue: anEntity [
	"Calculates the color of the entity based on the context."
	
	| value |
	value := self command roValue: anEntity.
	^5 + (38 * (value abs / (self maximumValue: anEntity))) asInteger
]
