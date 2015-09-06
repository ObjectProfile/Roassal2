Class {
	#name : #RTRotableView,
	#superclass : #RTInteraction,
	#instVars : [
		'view',
		'draggingView',
		'elements',
		'center',
		'startPoint'
	],
	#category : #'Roassal2-Experimental'
}

{ #category : #'as yet unclassified' }
RTRotableView >> center: anObject [
	center := anObject
]

{ #category : #'as yet unclassified' }
RTRotableView >> dragViewWithEvent: e [
	view canvas camera translateBy: e step negated / view canvas camera scale.
	e signalUpdate
]

{ #category : #'as yet unclassified' }
RTRotableView >> elements: anObject [
	elements := anObject
]

{ #category : #'as yet unclassified' }
RTRotableView >> initialize [
	super initialize.
	elements := [ view elements ].
	center := 0@0.
]

{ #category : #'as yet unclassified' }
RTRotableView >> initializeElement: element. [
	view := element.
	draggingView := false.
	view canvas when: TRMouseRightDragStart do: [ draggingView := true ].
	view canvas when: TRMouseLeftDragStart do: [ :e |
		draggingView := false.
		startPoint := (e positionFromCamera - center value). ].
	view canvas when: TRMouseDragging do: [ :e | 
		draggingView
			ifTrue: [ self dragViewWithEvent: e]
			ifFalse: [ self updateTargetElements: e ]  ].
	view canvas when: TRMouseDragEnd do: [ draggingView := false ].
	
]

{ #category : #'as yet unclassified' }
RTRotableView >> updateTargetElements: evt [
	| target c angle eangle p d evtPoint |
	target := elements value."A collection of elements"
	c := center value."a point"
	evtPoint := (evt positionFromCamera - c ).
	angle := startPoint theta - evtPoint theta.
	startPoint := evtPoint.

	target do: [ :e |
		d := c dist: e position .
		eangle := (e position - c) theta - angle.
		p := c + ((d * eangle cos) @ (d * eangle sin)).
		e translateTo: p.
		 ].
	view signalUpdate.
]
