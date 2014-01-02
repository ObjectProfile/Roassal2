Class {
	#name : #RTMondrianViewBuilder,
	#superclass : #RTObject,
	#instVars : [
		'view'
	],
	#category : #'Roassal2-Builder-Mondrian'
}

{ #category : #adding }
RTMondrianViewBuilder >> edges: objects from: fromBlock to: toBlock [

	RTEdge buildEdgesFromObjects: objects from: fromBlock to: toBlock using: RTLine inView: view
]

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
	view := RTView new.
	view @ RTDraggableView.
]

{ #category : #adding }
RTMondrianViewBuilder >> nodes: objects [
	| elements |
	elements := RTBox elementsOn: objects.
	view addAll: elements.
	elements @ RTDraggable.
	^ elements
]

{ #category : #'instance creation' }
RTMondrianViewBuilder >> open [
	^ view open
]

{ #category : #layout }
RTMondrianViewBuilder >> treeLayout [
	RTTreeLayout on: view elements edges: view edges
]

{ #category : #accessing }
RTMondrianViewBuilder >> view [
	^ view
]
