Class {
	#name : #RTHTMLPopup,
	#superclass : #RTHTMLInteraction,
	#instVars : [
		'click',
		'color',
		'position'
	],
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #'as yet unclassified' }
RTHTMLPopup class >> on: anHTMLExporter color: aColor targets: aRTShape [
	|popup|
	popup := self on: anHTMLExporter targets: aRTShape.
	popup color: aColor.
	^popup
]

{ #category : #'as yet unclassified' }
RTHTMLPopup class >> onClick: anHTMLExporter color: aColor targets: aRTShape [
	|popup|
	popup := self on: anHTMLExporter targets: aRTShape.
	popup click: true.
	popup color: aColor.
	^popup
]

{ #category : #'as yet unclassified' }
RTHTMLPopup class >> onClick: anHTMLExporter targets: aRTShape [
	|popup|
	popup := self on: anHTMLExporter targets: aRTShape.
	popup click: true.
	^popup
]

{ #category : #adding }
RTHTMLPopup >> addEventHandlers: aStream id: aString element: aRTElement [
	self subclassResponsibility 
]

{ #category : #adding }
RTHTMLPopup >> addFunctions: aStream [
	"do nothing"
]

{ #category : #accessing }
RTHTMLPopup >> click [
	^ click
]

{ #category : #accessing }
RTHTMLPopup >> click: anObject [
	click := anObject
]

{ #category : #accessing }
RTHTMLPopup >> color [
	^ color
]

{ #category : #accessing }
RTHTMLPopup >> color: anObject [
	color := anObject
]

{ #category : #initialization }
RTHTMLPopup >> initialize [
	click := false.
	color := Color black.
	contained := false.
	external := true.
	position := [ :element | element trachelShape position ].
]

{ #category : #'as yet unclassified' }
RTHTMLPopup >> mouseAction: aString [
	^click 
		ifTrue: ["Still does not work"
	'
    <set id="',aString,'s" attributeName="visibility" from="visible" to="hidden" begin="',aString,'.click"/>
  '			  ]
		ifFalse: [  
	'
    <set attributeName="visibility" from="hidden" to="visible" begin="',aString,'.mouseover" end="',aString,'.mouseout"/>
  ']
]

{ #category : #accessing }
RTHTMLPopup >> position [
	^ position
]

{ #category : #accessing }
RTHTMLPopup >> position: anObject [
	position := anObject
]
