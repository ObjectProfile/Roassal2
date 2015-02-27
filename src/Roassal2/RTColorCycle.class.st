Class {
	#name : #RTColorCycle,
	#superclass : #RTObject,
	#instVars : [
		'color',
		'markedElements'
	],
	#category : #'Roassal2-Builder-GraphOLD'
}

{ #category : #'as yet unclassified' }
RTColorCycle >> changeColorOf: elements [
	| t |
	"
	elements collect: #model
	"
	t := elements first.
	elements allButFirst
		do: [ :e | 
			(e outgoingEdges anySatisfy: [ :edge | edge from == e ])
				ifTrue: [ self markElement: e ]
				ifFalse: [ ^ self ] ]
]

{ #category : #'as yet unclassified' }
RTColorCycle >> color [
	^ color
]

{ #category : #'as yet unclassified' }
RTColorCycle >> color: colorOrBlock [
	color := colorOrBlock
]

{ #category : #'as yet unclassified' }
RTColorCycle >> defaultColor [
	^ Color red
]

{ #category : #'as yet unclassified' }
RTColorCycle >> initialize [
	super initialize.
	color := self defaultColor.
	markedElements := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
RTColorCycle >> markElement: e [
	e trachelShape color: (color rtValue: e).
	^ markedElements add: e
]

{ #category : #'as yet unclassified' }
RTColorCycle >> on: elements [

	| visited |
	visited := OrderedCollection new.
	elements do: [ :el | 
		self on: elements visitedElements: visited ].
]

{ #category : #'as yet unclassified' }
RTColorCycle >> on: element visitedElements: visitedElements [
	
]

{ #category : #'as yet unclassified' }
RTColorCycle >> visit: element [
	self visit: element visitedElements: Array new
]

{ #category : #'as yet unclassified' }
RTColorCycle >> visit: element visitedElements: visitedElements [
	| v |
	(visitedElements includes: element)
		ifTrue: [ self changeColorOf: visitedElements ]
		ifFalse: [ 
			v := visitedElements, (Array with:element ).
			element outgoingEdges do: [ :ee | self visit: ee to visitedElements: v ] ]
]

{ #category : #'as yet unclassified' }
RTColorCycle >> visitElements: elements [
	elements do: [ :e | 
		(markedElements includes: e)
			ifFalse: [ self visit: e ] ]
]
