Class {
	#name : #RTSpringLayoutStepping,
	#superclass : #RTAnimation,
	#instVars : [
		'view',
		'layout'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTSpringLayoutStepping >> hasCompleted [
	^ false
]

{ #category : #'as yet unclassified' }
RTSpringLayoutStepping >> initialize [
	super initialize.
	
]

{ #category : #'as yet unclassified' }
RTSpringLayoutStepping >> refresh [
	layout step
]

{ #category : #'as yet unclassified' }
RTSpringLayoutStepping >> start [
	view canvas signalUpdate
]

{ #category : #'as yet unclassified' }
RTSpringLayoutStepping >> view: aView [
	view := aView.
 	layout := RTForceBasedLayout new 
					nodes: view elements; 
					edges: view edges; 
					start: view elements;
					yourself.
]
