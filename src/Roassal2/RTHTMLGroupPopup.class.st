Class {
	#name : #RTHTMLGroupPopup,
	#superclass : #RTHTMLPopup,
	#instVars : [
		'group'
	],
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #adding }
RTHTMLGroupPopup >> addEventHandlers: aStream id: aString element: aRTElement center: aNumber [
	| visitor myGroup |
	myGroup := (self group value: aRTElement ).
	aStream nextPutAll: '<g visibility="hidden">', String cr.
	visitor := RTSVGVisitor new stream: aStream; center: aNumber; yourself.
	visitor canvas: myGroup encompassingRectangle.
	visitor visitGroup: myGroup.
	aStream 
		nextPutAll: (self mouseAction: aString);
		nextPutAll:  '</g>'
]

{ #category : #accessing }
RTHTMLGroupPopup >> group [
	^ group
]

{ #category : #accessing }
RTHTMLGroupPopup >> group: anObject [
	group := anObject
]

{ #category : #initialization }
RTHTMLGroupPopup >> initialize [
	super initialize.
	group := [ :m | RTGroup new add: ((RTElement on: m) + (RTBox new color: Color blue; yourself)); yourself]
]
