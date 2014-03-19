Class {
	#name : #RTHTMLPopup,
	#superclass : #RTHTMLInteraction,
	#instVars : [
		'text',
		'fontSize',
		'color'
	],
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #'as yet unclassified' }
RTHTMLPopup class >> on: anHTMLExporter text: aString color: aColor size: aNumber targets: aRTShape [
	|popup|
	popup := self new targets: aRTShape; text: aString; color: aColor; fontSize: aNumber; yourself. 
	anHTMLExporter interactions add: popup.
	^popup
]

{ #category : #'as yet unclassified' }
RTHTMLPopup class >> on: anHTMLExporter text: aString targets: aRTShape [
	|popup|
	popup := self new targets: aRTShape; text: aString; yourself. 
	anHTMLExporter interactions add: popup.
	^popup
]

{ #category : #adding }
RTHTMLPopup >> addEventHandlers: aStream id: aString element: aRTElement [
	| center |
	center := aRTElement trachelShape position.
	aStream
		nextPutAll: String cr,'<text id="',aString,'pop" x="',center x asString,'" y="',center y asString,'" font-size="',self fontSize asString,'" style="fill:',self color asHTMLColor,'" visibility="hidden">',(self text value: aRTElement model),'
    <set attributeName="visibility" from="hidden" to="visible" begin="',aString,'.mouseover" end="',aString,'.mouseout"/>
  </text>'
]

{ #category : #adding }
RTHTMLPopup >> addFunctions: aStream [
	"do nothing"
]

{ #category : #accessing }
RTHTMLPopup >> color [
	^ color
]

{ #category : #accessing }
RTHTMLPopup >> color: anObject [
	color := anObject
]

{ #category : #accessing }
RTHTMLPopup >> fontSize [
	^ fontSize
]

{ #category : #accessing }
RTHTMLPopup >> fontSize: anObject [
	fontSize := anObject
]

{ #category : #initialization }
RTHTMLPopup >> initialize [
	text := #asString.
	fontSize := 12.
	color := Color black.
	contained := false.
	external := true.
]

{ #category : #accessing }
RTHTMLPopup >> text [
	^text
]

{ #category : #accessing }
RTHTMLPopup >> text: aSymbolOrBlock [
	text := aSymbolOrBlock
]
