Class {
	#name : #RTView,
	#superclass : #RTObject,
	#instVars : [
		'elements'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTView >> add: anElement [
	elements add: anElement
]

{ #category : #'as yet unclassified' }
RTView >> elements [
	^ elements
]

{ #category : #'as yet unclassified' }
RTView >> initialize [
	super initialize.
	elements := OrderedCollection new
]

{ #category : #'as yet unclassified' }
RTView >> numberOfElements [
	^ elements size
]

{ #category : #'as yet unclassified' }
RTView >> open [

	| trCanvas |
	trCanvas := TRCanvas new.
	elements do: [ :el |
		el renderOn: trCanvas 
	].
	^ trCanvas open
]
