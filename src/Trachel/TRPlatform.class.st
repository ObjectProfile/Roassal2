"
I have the methods of the default platform(pharo or visualworks)
"
Class {
	#name : #TRPlatform,
	#superclass : #TRObject,
	#category : #'Trachel-Core'
}

{ #category : #default }
TRPlatform class >> current [
	^ TRPharoPlatform new.
]

{ #category : #public }
TRPlatform >> getFontForSize: aNumber [
	self subclassResponsibility.
]

{ #category : #public }
TRPlatform >> widthOfString: string font: font [
	self subclassResponsibility 
]
