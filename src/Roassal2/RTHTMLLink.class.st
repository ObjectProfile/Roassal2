Class {
	#name : #RTHTMLLink,
	#superclass : #RTHTMLInteraction,
	#instVars : [
		'link'
	],
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #'as yet unclassified' }
RTHTMLLink class >> on: anHTMLExporter link: anHref targets: aRTShape [
	|link|
	link := self new targets: aRTShape; link: anHref; yourself. 
	anHTMLExporter interactions add: link.
	^link
]

{ #category : #adding }
RTHTMLLink >> addEventHandlers: aStream id: aString element: aRTElement [
	aStream
		nextPutAll: '<a xlink:href="',(self link value: aRTElement model),'" target="_blank">'.
	"return the missing closing"
	^'</a>'
]

{ #category : #adding }
RTHTMLLink >> addFunctions: aStream [
	"do nothing"
]

{ #category : #accessing }
RTHTMLLink >> initialize [
	link := [:a |'http://objectprofile.com/'].
	contained := false.
	external := false.
]

{ #category : #accessing }
RTHTMLLink >> link [
	^ link
]

{ #category : #accessing }
RTHTMLLink >> link: anObject [
	link := anObject
]
