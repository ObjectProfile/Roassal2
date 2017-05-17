Class {
	#name : #RTBrushInteraction,
	#superclass : #RTAbstractElasticBoxInteraction,
	#instVars : [
		'dragging',
		'groups'
	],
	#category : #'Roassal2-Experimental'
}

{ #category : #accessing }
RTBrushInteraction >> getOrCreateShapeForView [
	^ (view attributes includesKey: self key) 
		ifTrue: [ view attributes at: self key ]
		ifFalse: [ | s |
			s := shapeBuilder elementOn: self.
			view add: s.
			view attributes at: self key put: s.
			s @ RTDraggable.
			s @ RTResizable.
			s ].
]

{ #category : #accessing }
RTBrushInteraction >> getSelectedElementsWith: s [
	| g r |
	g := RTGroup new. 
	r := s encompassingRectangle.
	view elements do: [ :e | 
		((e ~= s) and: [ e trachelShape encompassingRectangle intersects: r ])
			ifTrue: [ g add: e. ] ].
	^ g
]

{ #category : #accessing }
RTBrushInteraction >> groups: aCollection [
	groups := aCollection 
]

{ #category : #util }
RTBrushInteraction >> highlight: aGroup [
	aGroup do: [:e | RTBlink highlight: e color: (Color red rtValue: e) ].
]

{ #category : #initialization }
RTBrushInteraction >> initialize [
	super initialize.
	self when: RTSelectionStart do: [ :e | 
		super removeShape.
		self removeSelection: view elements ].
	self when: RTSelectionChange do: [ :e | self highlight: view elements ]. 
]

{ #category : #removing }
RTBrushInteraction >> removeSelection: aGroup [
	aGroup do: [:e | RTBlink unhighlight: e ].

]

{ #category : #removing }
RTBrushInteraction >> removeShape [
	
]
