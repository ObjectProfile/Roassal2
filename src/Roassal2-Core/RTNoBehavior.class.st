Class {
	#name : #RTNoBehavior,
	#superclass : #RTNestingBehavior,
	#classVars : [
		'Instance'
	],
	#category : #'Roassal2-Core-Base'
}

{ #category : #accessing }
RTNoBehavior class >> instance [
	Instance ifNil: [ Instance := self new ].
	^ Instance
]

{ #category : #hooks }
RTNoBehavior >> on: backElement setNested: elements [
	"Do nothing"
	super on: backElement setNested: elements.
]
