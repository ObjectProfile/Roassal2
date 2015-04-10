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
TRPlatform >> browseClass: aClass [
	self subclassResponsibility 
]

{ #category : #public }
TRPlatform >> dateAndTime [
	self subclassResponsibility
]

{ #category : #public }
TRPlatform >> dateAndTimeFromString: aString [
	self subclassResponsibility
]

{ #category : #public }
TRPlatform >> dialogChooseFrom: options values: values [
	self subclassResponsibility 
]

{ #category : #public }
TRPlatform >> dialogRequest: request initialAnswer: answer [
	self subclassResponsibility
	
]

{ #category : #public }
TRPlatform >> dialogRequestSaveFilename: filename extensions: exts path: path [
	self subclassResponsibility.
]

{ #category : #public }
TRPlatform >> download: aString [
	self subclassResponsibility
]

{ #category : #public }
TRPlatform >> downloadPng: aUrl [
	self subclassResponsibility
]

{ #category : #public }
TRPlatform >> fontFamilyName: name size: number [
	self subclassResponsibility
]

{ #category : #public }
TRPlatform >> fontListStrings [
	self subclassResponsibility
]

{ #category : #public }
TRPlatform >> formClass [
	self subclassResponsibility 
]

{ #category : #public }
TRPlatform >> formFromStream: aStream [
	^ self formClass fromBinaryStream: (self mimeDecodeToBytes: aStream)
]

{ #category : #public }
TRPlatform >> getFontForSize: aNumber [
	self subclassResponsibility.
]

{ #category : #public }
TRPlatform >> httpClientRequestClass [
	self subclassResponsibility 
]

{ #category : #public }
TRPlatform >> jsonReaderClass [
	self subclassResponsibility
]

{ #category : #public }
TRPlatform >> materializeFromByteArray: array [
	self subclassResponsibility
]

{ #category : #public }
TRPlatform >> menuMorphClass [
	self subclassResponsibility 
]

{ #category : #public }
TRPlatform >> mimeDecodeToBytes: bytes [
	self subclassResponsibility
]

{ #category : #public }
TRPlatform >> mimeEncode: aStream [
	self subclassResponsibility
]

{ #category : #public }
TRPlatform >> mimeEncode: aStream multiLine: aBool [
	self subclassResponsibility
]

{ #category : #public }
TRPlatform >> packageNamed: packageName [
	self subclassResponsibility
]

{ #category : #public }
TRPlatform >> pngReadWriterClass [
	self subclassResponsibility 
]

{ #category : #public }
TRPlatform >> roassalIcon [
	self subclassResponsibility
]

{ #category : #public }
TRPlatform >> widthOfString: string font: font [
	self subclassResponsibility 
]

{ #category : #public }
TRPlatform >> widthOfString: string fontFamilyName: fontFamilyName fontSize: fontSize [
	self subclassResponsibility 
]

{ #category : #public }
TRPlatform >> workingDirectory [
	self subclassResponsibility 
]
