Class {
	#name : #RTHTMLHightlight,
	#superclass : #RTHTMLInteraction,
	#instVars : [
		'color'
	],
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #'as yet unclassified' }
RTHTMLHightlight class >> on: anHTMLExporter color: aColor targets: aRTShape [
	|highlight|
	highlight := self new targets: aRTShape; color: aColor; yourself. 
	anHTMLExporter interactions add: highlight.
	^highlight
]

{ #category : #adding }
RTHTMLHightlight >> addEventHandlers: aStream id: aString element: element [
	aStream
		nextPutAll: 'onmouseover="hightlight(id);" onmouseout="unHightlight(id);"'
]

{ #category : #adding }
RTHTMLHightlight >> addFunctions: aStream [
	| attr |
	attr := self targetAttribute.
	aStream
		nextPutAll: '			var currentId;
			var color;
			function hightlight(id) {
				var affected = document.getElementById(id);
				if (color == affected.style["',attr,'"] || color == null) {
					color = affected.style["',attr,'"];
					currentId = id;
					affected.style["',attr,'"] = "',self color asHTMLColor,'";
				}
			}
			function unHightlight(id) {
				if (currentId != id)
					return;
				var affected = document.getElementById(id);
				affected.style["',attr,'"] = color;
				color = null;
			}'.
]

{ #category : #accessing }
RTHTMLHightlight >> color [
	^ color
]

{ #category : #accessing }
RTHTMLHightlight >> color: anObject [
	color := anObject
]

{ #category : #initialization }
RTHTMLHightlight >> initialize [
	color := Color red.
	contained := true.
	external := false.
]

{ #category : #adding }
RTHTMLHightlight >> targetAttribute [
	self targets = TRArcShape ifTrue: [ ^'fill' ].
	self targets = TRBezierShape ifTrue: [ ^'stroke' ].
	self targets = TRBoxShape ifTrue: [ ^'fill' ].
	self targets = TREllipseShape ifTrue: [ ^'fill' ].
	self targets = TRLabelShape ifTrue: [ ^'fill' ].
	self targets = TRLineShape ifTrue: [ ^'stroke' ].
	self targets = TRRotatedLabelShape ifTrue: [ ^'fill' ].
	self targets = TRSVGPath ifTrue: [ ^'fill' ].
]
