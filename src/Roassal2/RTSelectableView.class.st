"
I am an iteraction for a RTView to select elements
the default RTSelectableView provides a box shape to select the shapes in a view.
"
Class {
	#name : #RTSelectableView,
	#superclass : #RTAbstractElasticBoxInteraction,
	#instVars : [
		'color'
	],
	#category : #'Roassal2-Selection'
}

{ #category : #accessing }
RTSelectableView >> color [
	^ color
]

{ #category : #accessing }
RTSelectableView >> color: anObject [
	color := anObject
]

{ #category : #util }
RTSelectableView >> getSelectedElementsWith: s [
	| g r |
	g := RTGroup new. 
	r := s encompassingRectangle.
	view elements do: [ :e | 
		(((e ~= s) and: [ e trachelShape encompassingRectangle intersects: r ]) and: [ e model notNil ])
			ifTrue: [ g add: e. ] ].
	^ g
]

{ #category : #util }
RTSelectableView >> highlight: aGroup [
	aGroup do: [:e | RTBlink highlight: e color: (self color rtValue: e) ].
]

{ #category : #initialization }
RTSelectableView >> initialize [
	super initialize.
	self color: Color red.
	self when: RTSelectionStart do: [ self removeSelection: view elements ].
	self when: RTSelectionChange do: [:e| self highlight: e group ].
	
]

{ #category : #util }
RTSelectableView >> removeSelection: aGroup [
	aGroup do: [:e | RTBlink unhighlight: e ].

]
