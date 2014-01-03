Class {
	#name : #RTDraggableViewTest,
	#superclass : #RTTest,
	#instVars : [
		'view'
	],
	#category : #'Roassal2-Core'
}

{ #category : #running }
RTDraggableViewTest >> setUp [
	super setUp.
	view := RTView new.
	view add: (RTEllipse new width: 40; height: 20) element.
	
]

{ #category : #running }
RTDraggableViewTest >> setUp [
	super setUp.
	view := RTView new.
	view add: (RTEllipse new width: 40; height: 20) element.
	
]

{ #category : #tests }
RTDraggableViewTest >> testDefault [
	self assert: view canvas camera position = (0 @ 0).
]

{ #category : #tests }
RTDraggableViewTest >> testDefault [
	self assert: view canvas camera position = (0 @ 0).
]

{ #category : #tests }
RTDraggableViewTest >> testDraggingOnDraggable [
	view @ RTDraggableView.
	view canvas announce: (TRMouseDragging step: 10 @ 5).
	self assert: view canvas camera position = (-10 @ -5)
]

{ #category : #tests }
RTDraggableViewTest >> testDraggingOnDraggable [
	view @ RTDraggableView.
	view canvas announce: (TRMouseDragging step: 10 @ 5).
	self assert: view canvas camera position = (-10 @ -5)
]

{ #category : #tests }
RTDraggableViewTest >> testDraggingOnNotDraggable [
	view canvas announce: (TRMouseDragging step: 10 @ 5).
	self assert: view canvas camera position = (0 @ 0)
]

{ #category : #tests }
RTDraggableViewTest >> testDraggingOnNotDraggable [
	view canvas announce: (TRMouseDragging step: 10 @ 5).
	self assert: view canvas camera position = (0 @ 0)
]
