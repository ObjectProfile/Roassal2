Class {
	#name : #RTExample,
	#superclass : #RTObject,
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTExample >> basic [
	"
	self new basic
	"
	
	| view |
	view := RTView new.
	view add: (RTBox element translateTo: 20 @ 20; yourself).
	view open
]

{ #category : #'as yet unclassified' }
RTExample >> growingSquares [
	"
	self new growingSquares
	"
	
	| view shape |
	view := RTView new.

	shape := RTBox new size: [ :e | e model yourself ].
	1 to: 100 do: [ :i |
		view add: ((shape elementOn: i) translateTo: 20 @ 20; yourself).
	].
	RTGridLayout on: view elements.
	
	view open
]
