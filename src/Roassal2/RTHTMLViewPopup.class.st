Class {
	#name : #RTHTMLViewPopup,
	#superclass : #RTHTMLPopup,
	#instVars : [
		'view'
	],
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #'as yet unclassified' }
RTHTMLViewPopup class >> on: anHTMLExporter view: aRTView targets: aRTShape [
	| generator |
	generator := [ :e |  self new target: e; view: aRTView; yourself ].
	self on: anHTMLExporter targets: aRTShape generator: generator
]

{ #category : #'as yet unclassified' }
RTHTMLViewPopup class >> onClick: anHTMLExporter view: aRTView targets: aRTShape [
	| generator |
	generator := [ :e |  self new target: e; click: true; view: aRTView; yourself ].
	self on: anHTMLExporter targets: aRTShape generator: generator
]

{ #category : #adding }
RTHTMLViewPopup >> addEventHandlers: aStream id: aString element: aRTElement center: aNumber [
	aStream nextPutAll: '<g visibility="hidden">', String cr.
	RTSVGVisitor visit: (self view value: aRTElement model) on: aStream center: aNumber.
	aStream 
		nextPutAll: (self mouseAction: aString);
		nextPutAll:  '</g>'
]

{ #category : #initialization }
RTHTMLViewPopup >> initialize [
	super initialize.
	view := [ :m | RTView new add: ((RTElement on: m) + (RTBox new color: Color blue; yourself))]
]

{ #category : #accessing }
RTHTMLViewPopup >> view [
	^ view
]

{ #category : #accessing }
RTHTMLViewPopup >> view: anObject [
	view := anObject
]
