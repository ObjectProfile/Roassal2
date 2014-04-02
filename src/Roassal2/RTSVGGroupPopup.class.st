Class {
	#name : #RTSVGGroupPopup,
	#superclass : #RTSVGPopup,
	#instVars : [
		'group'
	],
	#category : #'Roassal2-Exporter-SVG'
}

{ #category : #adding }
RTSVGGroupPopup >> addEventHandlers: aStream id: aString element: aRTElement center: aNumber [
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
RTSVGGroupPopup >> group [
	^ group
]

{ #category : #accessing }
RTSVGGroupPopup >> group: anObject [
	group := anObject
]

{ #category : #initialization }
RTSVGGroupPopup >> initialize [
	super initialize.
	group := [ :m | RTGroup new add: ((RTElement on: m) + (RTBox new color: Color blue; yourself)); yourself]
]
