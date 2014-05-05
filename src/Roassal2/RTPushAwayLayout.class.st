Class {
	#name : #RTPushAwayLayout,
	#superclass : #RTLayout,
	#instVars : [
		'center',
		'c',
		'factor'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #'as yet unclassified' }
RTPushAwayLayout >> center [
	^ center
]

{ #category : #'as yet unclassified' }
RTPushAwayLayout >> center: aCenter [
	"Fix the center to move the elements away"
	"Argument could be a point, or a one-arg block, evaluated against the elements to push away"
	^ aCenter
]

{ #category : #'as yet unclassified' }
RTPushAwayLayout >> doExecute: elements [
	"Performs the layout"
	c := center rtValue: elements.
	elements do: [ :e | 
		| p |
		p := e position - c.
		e translateTo: (p scaleBy: (factor rtValue: e)) ]
]

{ #category : #'as yet unclassified' }
RTPushAwayLayout >> factor [
	^ factor
]

{ #category : #'as yet unclassified' }
RTPushAwayLayout >> factor: aFloatOrABlock [
	factor := aFloatOrABlock
]

{ #category : #'as yet unclassified' }
RTPushAwayLayout >> initialize [
	super initialize.
	center := 0 @ 0
]
