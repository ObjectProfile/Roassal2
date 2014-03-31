Class {
	#name : #RTHTMLTextPopup,
	#superclass : #RTHTMLPopup,
	#instVars : [
		'text',
		'font',
		'fontSize'
	],
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #'as yet unclassified' }
RTHTMLTextPopup class >> on: anHTMLExporter text: aString color: aColor font: aFont size: aNumber targets: aRTShape [
	| generator |
	generator := [ :e |  self new target: e; text: aString; color: aColor; font: aFont; fontSize: aNumber; yourself ].
	self on: anHTMLExporter targets: aRTShape generator: generator
]

{ #category : #'as yet unclassified' }
RTHTMLTextPopup class >> on: anHTMLExporter text: aString color: aColor size: aNumber targets: aRTShape [
	| generator |
	generator := [ :e |  self new target: e; text: aString; color: aColor; fontSize: aNumber; yourself ].
	self on: anHTMLExporter targets: aRTShape generator: generator
]

{ #category : #'as yet unclassified' }
RTHTMLTextPopup class >> on: anHTMLExporter text: aString font: aFont size: aNumber targets: aRTShape [
	| generator |
	generator := [ :e |  self new target: e; text: aString; font: aFont; fontSize: aNumber; yourself ].
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
		nextPutAll: String cr,'<text id="',aString,'pop" x="',aNumber x asString,'" y="',aNumber y asString,'" font-size="',self fontSize asString,'" style="fill:',self color asHTMLColor,'" visibility="hidden"><tspan font-family = "',self font,'">',(self text value: aRTElement model),(self mouseAction: aString),'</tspan></text>'
]

{ #category : #configuration }
RTHTMLTextPopup >> defaultFont [
	^'Arial, Helvetica, sans-serif'
]

{ #category : #accessing }
RTHTMLTextPopup >> font [
	^ font
]

{ #category : #accessing }
RTHTMLTextPopup >> font: anObject [
	font := anObject
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
	font := self defaultFont.
]

{ #category : #accessing }
RTHTMLTextPopup >> text [
	^text
]

{ #category : #accessing }
RTHTMLTextPopup >> text: aSymbolOrBlock [
	text := aSymbolOrBlock
]
