Class {
	#name : #RTView,
	#superclass : #RTObject,
	#instVars : [
		'elements',
		'animations'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTView >> add: anElement [
	elements add: anElement
]

{ #category : #'as yet unclassified' }
RTView >> addAll: someElements [
	someElements do: [ :el | self add: el ]
]

{ #category : #'as yet unclassified' }
RTView >> addAnimation: animation [
	animations add: animation
]

{ #category : #'as yet unclassified' }
RTView >> createAndFillCanvas [
	| trCanvas |
	trCanvas := TRCanvas new.
	elements do: [ :el | el renderOn: trCanvas ].
	animations do: [ :a | trCanvas addAnimation: a ].
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
	animations := OrderedCollection new
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
