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

{ #category : #accessing }
RTPushAwayLayout >> center [
	^ center
]

{ #category : #accessing }
RTPushAwayLayout >> center: aCenter [
	"Fix the center to move the elements away"
	"Argument could be a point, or a one-arg block, evaluated against the elements to push away"
	^ aCenter
]

{ #category : #hook }
RTPushAwayLayout >> doExecute: elements [
	"Performs the layout"
	c := center rtValue: elements.
	elements do: [ :e | 
		| p |
		p := e position - c.
		e translateTo: (p scaleBy: (factor rtValue: e)) ]
]

{ #category : #accessing }
RTPushAwayLayout >> factor [
	^ factor
]

{ #category : #accessing }
RTPushAwayLayout >> factor: aFloatOrABlock [
	factor := aFloatOrABlock
]

{ #category : #'initialize-release' }
RTPushAwayLayout >> initialize [
	super initialize.
	center := 0 @ 0.
	factor := 1 @ 1
]
