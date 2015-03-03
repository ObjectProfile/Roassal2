Class {
	#name : #RTTranslationLayout,
	#superclass : #RTLayout,
	#instVars : [
		'step'
	],
	#category : #Roassal2OldGraphBuilder
}

{ #category : #hook }
RTTranslationLayout >> doExecute: elements [
	"Performs the layout"
	elements do: [ :e | e translateBy: step ]
]

{ #category : #'initialize-release' }
RTTranslationLayout >> initialize [
	super initialize.
	step := 0 @ 0
]

{ #category : #accessing }
RTTranslationLayout >> step: aPoint [
	step := aPoint
]
