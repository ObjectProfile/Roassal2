Class {
	#name : #RTHTMLPopup,
	#superclass : #RTHTMLInteraction,
	#instVars : [
		'click',
		'color',
		'position',
		'bounds'
	],
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #'as yet unclassified' }
RTHTMLPopup class >> on: anHTMLExporter color: aColor targets: aRTShape [
	| generator |
	generator := [ :e |  self new target: e; color: aColor; yourself ].
	self on: anHTMLExporter targets: aRTShape generator: generator
]

{ #category : #'as yet unclassified' }
RTHTMLPopup class >> onClick: anHTMLExporter color: aColor targets: aRTShape [
	| generator |
	generator := [ :e |  self new target: e; color: aColor; click: true; yourself ].
	self on: anHTMLExporter targets: aRTShape generator: generator
]

{ #category : #'as yet unclassified' }
RTHTMLPopup class >> onClick: anHTMLExporter targets: aRTShape [
	| generator |
	generator := [ :e |  self new target: e; click: true; yourself ].
	self on: anHTMLExporter targets: aRTShape generator: generator
]

{ #category : #adding }
RTHTMLPopup >> addEventHandlers: aStream id: aString element: aRTElement  center: aNumber [
	self subclassResponsibility 
]

{ #category : #adding }
RTHTMLPopup >> addFunctions: aStream [
	"do nothing"
]

{ #category : #adding }
RTHTMLPopup >> addGlobalHandlers: aStream [
	"do nothing"
]

{ #category : #accessing }
RTHTMLPopup >> bounds [
	^ bounds
]

{ #category : #accessing }
RTHTMLPopup >> bounds: anObject [
	bounds := anObject
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
	super initialize.
	click := false.
	color := Color black.
	contained := false.
	external := true.
	self type: 'popup'.
	position := [ :element | element trachelShape position ].
]

{ #category : #adding }
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

{ #category : #accessing }
RTHTMLPopup >> xBound [
	^1
]

{ #category : #accessing }
RTHTMLPopup >> yBound [
	^1
]
