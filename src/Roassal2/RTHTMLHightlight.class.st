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
	| generator |
	generator := [ :e |  self new target: e; color: aColor; yourself ].
	self on: anHTMLExporter targets: aRTShape generator: generator
]

{ #category : #adding }
RTHTMLHightlight >> addEventHandlers: aStream id: aString element: element center: aNumber [
	aStream
		nextPutAll: 'onmouseover="hightlight',target class name asString,'(''',aString,''');" onmouseout="unHightlight',target class name asString,'(''',aString,''');"'
]

{ #category : #adding }
RTHTMLHightlight >> addFunctions: aStream [
	| attr  tname|
	attr := self targetAttribute.
	tname := target class name asString.
	aStream
		nextPutAll: '			var currentId',tname,';
			var color',tname,';
			function hightlight',tname,'(id) {
				var affected = document.getElementById(id);
				if (color',tname,' == affected.style["',attr,'"] || color',tname,' == null) {
					color',tname,' = affected.style["',attr,'"];
					currentId',tname,' = id;
					affected.style["',attr,'"] = "',self color asHTMLColor,'";
				}
			}
			function unHightlight',tname,'(id) {
				if (currentId',tname,' != id)
					return;
				var affected = document.getElementById(id);
				affected.style["',attr,'"] = color',tname,';
				color',tname,' = null;
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
	self target trachelShape class = TRArcShape ifTrue: [ ^'fill' ].
	self target trachelShape class = TRBezierShape ifTrue: [ ^'stroke' ].
	self target trachelShape class = TRBoxShape ifTrue: [ ^'fill' ].
	self target trachelShape class = TREllipseShape ifTrue: [ ^'fill' ].
	self target trachelShape class = TRLabelShape ifTrue: [ ^'fill' ].
	self target trachelShape class = TRLineShape ifTrue: [ ^'stroke' ].
	self target trachelShape class = TRRotatedLabelShape ifTrue: [ ^'fill' ].
	self target trachelShape class = TRSVGPath ifTrue: [ ^'fill' ].
]
