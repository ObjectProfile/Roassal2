"
I am an iteraction for a RTView to select elements
the default RTSelectableView provides a box shape to select the shapes in a view.
"
Class {
	#name : #RTSelectableView,
	#superclass : #RTInteraction,
	#instVars : [
		'draggingView',
		'shapeBuilder',
		'key',
		'announcer',
		'group',
		'color',
		'view'
	],
	#category : #'Roassal2-Selection'
}

{ #category : #accessing }
RTSelectableView >> announcer [
	^ announcer
]

{ #category : #accessing }
RTSelectableView >> announcer: anAnnouncer [
	announcer := anAnnouncer.
]

{ #category : #accessing }
RTSelectableView >> color [
	^ color
]

{ #category : #accessing }
RTSelectableView >> color: anObject [
	color := anObject
]

{ #category : #'selection events' }
RTSelectableView >> dragViewWithEvent: e [
	view canvas camera translateBy: e step negated / view canvas camera scale.
	e signalUpdate
]

{ #category : #util }
RTSelectableView >> getOrCreateShapeForView [
	^ (view attributes includesKey: self key) 
		ifTrue: [ view attributes at: self key ]
		ifFalse: [ | s |
			s := shapeBuilder elementOn: self.
			view add: s.
			view attributes at: self key put: s.
			s ].
]

{ #category : #util }
RTSelectableView >> getSelectedElementsWith: s [
	| g r |
	g := RTGroup new. 
	r := s encompassingRectangle.
	view elements do: [ :e | 
		((e ~= s) and: [ e trachelShape encompassingRectangle intersects: r ])
			ifTrue: [ g add: e. ] ].
	^ g
]

{ #category : #accessing }
RTSelectableView >> group [
	^ group
]

{ #category : #util }
RTSelectableView >> highlight: aGroup [

	aGroup do: [:e | RTBlink highlight: e color: (self color rtValue: e) ].
]

{ #category : #initialization }
RTSelectableView >> initialize [
	| base |
	super initialize.
	shapeBuilder := RTShapeBuilder new.
	base := Color r: 51 g: 153 b: 255 range: 255.
	shapeBuilder rectangle borderColor: base ; color: (base alpha: 0.2).
	self key: #rtSelectorShape.
	group := #().
	announcer := Announcer new.
	self color: Color red.
	view := nil.
	self when: RTSelectionStart do: [ self unhighlight: view elements ].
	self when: RTSelectionChange do: [:e| self highlight: e group ].
	
]

{ #category : #hooks }
RTSelectableView >> initializeElement: anElement [
	view := anElement.
	self removeDraggableViewInteraction.
	draggingView := false.
	view canvas when: TRMouseRightDragStart do: [ :e | draggingView := true ].
	view canvas when: TRMouseLeftDragStart do: [ :e | 
		draggingView := false.
		self selectionStart. ].
	
	view canvas when: TRMouseDragging do: [ :e |
		draggingView
			ifTrue: [ self dragViewWithEvent: e ]
			ifFalse: [ self updateSelectableShapeWithEvent: e. ]. ].
	
	view canvas when: TRMouseDragEnd do: [ :e | 
		draggingView
			ifTrue: [ draggingView := false.  ]
			ifFalse: [ self selectionEnd ] ].
	
]

{ #category : #accessing }
RTSelectableView >> key [
	^ key
]

{ #category : #accessing }
RTSelectableView >> key: anObject [
	key := anObject
]

{ #category : #initialization }
RTSelectableView >> removeDraggableViewInteraction [
	view removeInteractionIfPresent: RTDraggableView
	
"	| a int |
	a := view canvas announcer.
	(view hasInteraction: RTDraggableView) ifTrue: [
		int := view getInteractionForClass: RTDraggableView.
		a unsubscribe: int ]
"	
	
	
	
]

{ #category : #util }
RTSelectableView >> removeShape [
	(self getOrCreateShapeForView) remove.
	view attributes removeKey: self key.
	view signalUpdate.
]

{ #category : #'selection events' }
RTSelectableView >> selectionEnd [
	| evt |
	self removeShape.
	evt := RTSelectionEnd new.
	evt group: group.
	self announcer announce: evt.
	
	
	
]

{ #category : #'selection events' }
RTSelectableView >> selectionStart [
	| evt |
	evt := RTSelectionStart new.
	group := RTGroup new.
	evt group: group.
	self announcer announce: evt.
]

{ #category : #accessing }
RTSelectableView >> shapeBuilder [
	^ shapeBuilder
]

{ #category : #util }
RTSelectableView >> unhighlight: aGroup [
	aGroup do: [:e | RTBlink unhighlight: e ].

]

{ #category : #util }
RTSelectableView >> updateSelectableShapeWithEvent: event [
	| s newgroup |
	s := self getOrCreateShapeForView.
	
	self updateShape: s with: event.
	
	newgroup := self getSelectedElementsWith: s.
	
	group = newgroup ifFalse: [ | evt |
		self unhighlight: group.
		group := newgroup.
		evt := RTSelectionChange new.
		evt group: group.
		self announcer announce: evt. ].
	view canvas signalUpdate.
	
]

{ #category : #util }
RTSelectableView >> updateShape: s with: e [
	"Update for box shape"
	| p k o extent | 
	p := e positionFromCamera.
	k := #rtorigin.
	(s attributes includesKey: k) ifTrue: [
		o := s attributes at: k.
		extent :=  p - o.
		extent x < 0 ifTrue: [ extent := (extent x negated)@extent y. o := (o x - extent x)@ o y ].
		extent y < 0 ifTrue: [ extent := extent x @ (extent y negated). o := o x @ (o y - extent y) ].
		s trachelShape extent: extent.
		s translateTo: o + (extent /2).
		] ifFalse: [
		s translateTo: p.
		s attributes at: k put: p].
]

{ #category : #announce }
RTSelectableView >> when: anEvent do: aBlock [
	self announcer when: anEvent do: aBlock
]
