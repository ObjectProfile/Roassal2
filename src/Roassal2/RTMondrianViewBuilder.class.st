Class {
	#name : #RTMondrianViewBuilder,
	#superclass : #RTObject,
	#instVars : [
		'view'
	],
	#category : #'Roassal2-Builder-Mondrian'
}

{ #category : #layout }
RTMondrianViewBuilder >> gridLayout [
	RTGridLayout on: view elements
]

{ #category : #layout }
RTMondrianViewBuilder >> horizontalLineLayout [
	RTHorizontalLineLayout on: view elements
]

{ #category : #initialization }
RTMondrianViewBuilder >> initialize [
	super initialize.
	view := RTView new
]

{ #category : #configuration }
RTMondrianViewBuilder >> nodes: objects [
	| elements |
	elements := RTBox elementsOn: objects.
	view addAll: elements.
	^ elements
]

{ #category : #'instance creation' }
RTMondrianViewBuilder >> open [
	^ view open
]

{ #category : #accessing }
RTMondrianViewBuilder >> view [
	^ view
]
