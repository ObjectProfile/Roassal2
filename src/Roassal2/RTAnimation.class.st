Class {
	#name : #RTAnimation,
	#superclass : #Object,
	#instVars : [
		'cycleLength',
		'element'
	],
	#category : #'Roassal2-Core'
}

{ #category : #actions }
RTAnimation >> addedIn: trachelCanvas [
	"do nothing"
]

{ #category : #accessing }
RTAnimation >> after: aBlock [

]

{ #category : #accessing }
RTAnimation >> element [
	^ element
]

{ #category : #testing }
RTAnimation >> hasCompleted [
	self subclassResponsibility
]

{ #category : #refreshing }
RTAnimation >> refresh [

]

{ #category : #actions }
RTAnimation >> start [
	"Do be overriden"
]
