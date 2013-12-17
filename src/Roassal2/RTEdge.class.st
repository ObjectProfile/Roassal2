Class {
	#name : #RTEdge,
	#superclass : #RTShapedObject,
	#instVars : [
		'from',
		'to'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTEdge class >> from: fromEl to: toEl [
	^ self new from: fromEl; to: toEl; yourself
]

{ #category : #'as yet unclassified' }
RTEdge >> addShape: aRTShape [
	shape := aRTShape instance
]

{ #category : #accessing }
RTEdge >> from [
	
	^ from
]

{ #category : #accessing }
RTEdge >> from: anElement [
	
	from := anElement.
	anElement addOutgoingEdge: self
]

{ #category : #accessing }
RTEdge >> to [
	
	^ to
]

{ #category : #accessing }
RTEdge >> to: anElement [
	
	to := anElement.
	anElement addIncomingEdge: self
]
