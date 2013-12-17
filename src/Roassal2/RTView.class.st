Class {
	#name : #RTView,
	#superclass : #RTObject,
	#instVars : [
		'elements',
		'trachelCanvas'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTView >> add: anElement [
	elements add: anElement.
	"anElement shape renderOn: trachelCanvas for: anElement"
]

{ #category : #'as yet unclassified' }
RTView >> createAndFillCanvas [
	| trCanvas |
	trCanvas := TRCanvas new.
	elements do: [ :el | el renderOn: trCanvas ].
	^ trCanvas
]

{ #category : #'as yet unclassified' }
RTView >> elements [
	^ elements
]

{ #category : #'as yet unclassified' }
RTView >> initialize [
	super initialize.
	elements := OrderedCollection new.
	"trachelCanvas := TRCanvas new."
]

{ #category : #'as yet unclassified' }
RTView >> numberOfElements [
	^ elements size
]

{ #category : #'as yet unclassified' }
RTView >> open [
	"^ trachelCanvas open"

	^ self createAndFillCanvas open
]
