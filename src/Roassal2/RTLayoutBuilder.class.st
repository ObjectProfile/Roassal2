Class {
	#name : #RTLayoutBuilder,
	#superclass : #RTObject,
	#instVars : [
		'layout'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #'as yet unclassified' }
RTLayoutBuilder >> cell [
	layout := RTCellLayout new.
	^ layout
]

{ #category : #'as yet unclassified' }
RTLayoutBuilder >> gapSize: aValue [
	layout gapSize: aValue
]

{ #category : #'as yet unclassified' }
RTLayoutBuilder >> grid [
	layout := RTGridLayout new.
	^ layout
]

{ #category : #'as yet unclassified' }
RTLayoutBuilder >> layout [
	^ layout
]

{ #category : #'as yet unclassified' }
RTLayoutBuilder >> setUpElements: elements [
	layout on: elements
]
