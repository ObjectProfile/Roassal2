Class {
	#name : #RTHTMLTextPopup,
	#superclass : #RTHTMLPopup,
	#instVars : [
		'text',
		'fontSize'
	],
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #'as yet unclassified' }
RTHTMLTextPopup class >> on: anHTMLExporter text: aString color: aColor size: aNumber targets: aRTShape [
	|popup|
	popup := self on: anHTMLExporter color: aColor targets: aRTShape.
	popup text: aString;  fontSize: aNumber.
	^popup
]

{ #category : #'as yet unclassified' }
RTHTMLTextPopup class >> on: anHTMLExporter text: aString targets: aRTShape [
	|popup|
	popup := self on: anHTMLExporter targets: aRTShape.
	popup text: aString. 
	^popup
]

{ #category : #'as yet unclassified' }
RTHTMLTextPopup class >> onClick: anHTMLExporter text: aString color: aColor size: aNumber targets: aRTShape [
	|popup|
	popup := self onClick: anHTMLExporter color: aColor targets: aRTShape.
	popup text: aString;  fontSize: aNumber.
	^popup
]

{ #category : #'as yet unclassified' }
RTHTMLTextPopup class >> onClick: anHTMLExporter text: aString targets: aRTShape [
	|popup|
	popup := self onClick: anHTMLExporter targets: aRTShape.
	popup text: aString. 
	^popup
]

{ #category : #adding }
RTHTMLTextPopup >> addEventHandlers: aStream id: aString element: aRTElement [
	| center |
	center := self position value: aRTElement.
	aStream
		nextPutAll: String cr,'<text id="',aString,'pop" x="',center x asString,'" y="',center y asString,'" font-size="',self fontSize asString,'" style="fill:',self color asHTMLColor,'" visibility="hidden">',(self text value: aRTElement model),(self mouseAction: aString),'</text>'
]

{ #category : #accessing }
RTHTMLTextPopup >> fontSize [
	^ fontSize
]

{ #category : #accessing }
RTHTMLTextPopup >> fontSize: anObject [
	fontSize := anObject
]

{ #category : #initialization }
RTHTMLTextPopup >> initialize [
	super initialize.
	text := #asString.
	fontSize := 12.
]

{ #category : #accessing }
RTHTMLTextPopup >> text [
	^text
]

{ #category : #accessing }
RTHTMLTextPopup >> text: aSymbolOrBlock [
	text := aSymbolOrBlock
]
