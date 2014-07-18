"
I am a class for pharo platform
"
Class {
	#name : #TRPharoPlatform,
	#superclass : #TRPlatform,
	#category : #'Trachel-MorphSpecific'
}

{ #category : #public }
TRPharoPlatform >> getFontForSize: aNumber [

   ^ LogicalFont familyName: StandardFonts defaultFont familyName pointSize: aNumber
]

{ #category : #public }
TRPharoPlatform >> widthOfString: string font: font [

	^ (font widthOfString: string)
]
