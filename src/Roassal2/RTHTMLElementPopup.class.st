Class {
	#name : #RTHTMLElementPopup,
	#superclass : #RTHTMLPopup,
	#instVars : [
		'element'
	],
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #'as yet unclassified' }
RTHTMLElementPopup >> addEventHandlers: aStream id: aString element: aRTElement  center: aNumber [
	| visitor myElement|
	myElement := (self element value: aRTElement ).
	aStream nextPutAll: '<g visibility="hidden">', String cr.
	visitor := RTSVGVisitor new stream: aStream; center: aNumber; yourself.
	visitor canvas: myElement encompassingRectangle.
	visitor visitElement: myElement.
	aStream 
		nextPutAll: (self mouseAction: aString);
		nextPutAll:  '</g>'
]

{ #category : #accessing }
RTHTMLElementPopup >> element [
	^ element
]

{ #category : #accessing }
RTHTMLElementPopup >> element: anObject [
	element := anObject
]

{ #category : #'as yet unclassified' }
RTHTMLElementPopup >> initialize [
	super initialize.
	element := [ :m | (RTElement  on: m) + (RTBox new color: Color blue; yourself)]
]
