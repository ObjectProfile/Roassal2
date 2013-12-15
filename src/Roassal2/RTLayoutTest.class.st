Class {
	#name : #RTLayoutTest,
	#superclass : #RTTest,
	#instVars : [
		'view'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTLayoutTest >> setUp [
	super setUp.
	view := RTView new.
	
	30 timesRepeat: [ view add: RTBox element ]
]

{ #category : #'as yet unclassified' }
RTLayoutTest >> test [

	RTHorizontalLineLayout on: view elements
]
