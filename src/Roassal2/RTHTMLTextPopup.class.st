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
	| generator |
	generator := [ :e |  self new target: e; text: aString; color: aColor; fontSize: aNumber; yourself ].
	self on: anHTMLExporter targets: aRTShape generator: generator
]

{ #category : #'as yet unclassified' }
RTHTMLTextPopup class >> on: anHTMLExporter text: aString targets: aRTShape [
	| generator |
	generator := [ :e |  self new target: e; text: aString; yourself ].
	self on: anHTMLExporter targets: aRTShape generator: generator
]

{ #category : #'as yet unclassified' }
RTHTMLTextPopup class >> onClick: anHTMLExporter text: aString color: aColor size: aNumber targets: aRTShape [
	| generator |
	generator := [ :e |  self new target: e; text: aString; color: aColor; fontSize: aNumber; click: true; yourself ].
	self on: anHTMLExporter targets: aRTShape generator: generator
]

{ #category : #'as yet unclassified' }
RTHTMLTextPopup class >> onClick: anHTMLExporter text: aString targets: aRTShape [
	| generator |
	generator := [ :e |  self new target: e; text: aString; click: true; yourself ].
	self on: anHTMLExporter targets: aRTShape generator: generator
]

{ #category : #adding }
RTHTMLTextPopup >> addEventHandlers: aStream id: aString element: aRTElement center: aNumber [
	aStream
		nextPutAll: String cr,'<text id="',aString,'pop" x="',aNumber x asString,'" y="',aNumber y asString,'" font-size="',self fontSize asString,'" style="fill:',self color asHTMLColor,'" visibility="hidden">',(self text value: aRTElement model),(self mouseAction: aString),'</text>'
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
