Class {
	#name : #RTAnimation,
	#superclass : #Object,
	#instVars : [
		'cycleLength',
		'element'
	],
	#category : #Roassal2
}

{ #category : #actions }
RTAnimation >> addedIn: trachelCanvas [
	"do nothing"
]

{ #category : #testing }
RTAnimation >> hasCompleted [
	self subclassResponsibility
]

{ #category : #refreshing }
RTAnimation >> refresh [

]
