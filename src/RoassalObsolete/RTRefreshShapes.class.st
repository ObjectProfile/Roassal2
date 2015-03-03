Class {
	#name : #RTRefreshShapes,
	#superclass : #RTObject,
	#instVars : [
		'view',
		'refreshValue',
		'elements'
	],
	#category : #'RoassalObsolete-Builder-MemoryProfiler'
}

{ #category : #'as yet unclassified' }
RTRefreshShapes >> addedIn: aCanvas [
]

{ #category : #'as yet unclassified' }
RTRefreshShapes >> elements: elementsToRefresh [
	elements := elementsToRefresh
]

{ #category : #'as yet unclassified' }
RTRefreshShapes >> hasCompleted [
	^ false
]

{ #category : #'as yet unclassified' }
RTRefreshShapes >> initialize [
	super initialize.
	refreshValue := 0.
	elements := #()
]

{ #category : #'as yet unclassified' }
RTRefreshShapes >> refresh [
	refreshValue := refreshValue + 1.
	refreshValue < 10 ifTrue: [ ^ self ].
	refreshValue := 0.

	elements do: #update.
	RTGridLayout on: elements.
]

{ #category : #'as yet unclassified' }
RTRefreshShapes >> start [
]

{ #category : #'as yet unclassified' }
RTRefreshShapes >> view: aView [
	view := aView
]
