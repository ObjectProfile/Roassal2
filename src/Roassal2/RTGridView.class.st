"
I add a grid background to a view.

Additionally any element having RTDraggableSnapToGrid will use my gridSize settings.

!! Example

see class-side
"
Class {
	#name : #RTGridView,
	#superclass : #RTInteraction,
	#instVars : [
		'gridShape',
		'gridSize'
	],
	#category : #'Roassal2-Interactions'
}

{ #category : #example }
RTGridView class >> example [
	| v es |
	v := RTView new.
	v @ RTDraggableView.
	v @ (RTGridView new gridSize: 20).
	v @ RTZoomableView.
	es := RTBox new
		color: Color green;
		size: 20;
		elementsOn: #(1 2).
	v addAll: es.
	es @ (RTDraggableSnapToGrid new gridSize: 40).
	es @ RTResizable.
	es first translateTo: 70 negated @ 90 negated.
	es second translateTo: 70 @ 110.
	v open
]

{ #category : #adding }
RTGridView >> addCenterMarkerTo: aCanvas [
	aCanvas
		addShape:
			(TRSVGPath new
				strokePaint: (Color black alpha: 0.5);
				borderWidth: 1;
				path: 'M -5 0 H 5 M 0 -5 V 5')
]

{ #category : #adding }
RTGridView >> addGridShapeTo: aCanvas [
	gridShape := TRCanvasGridShape new.
	gridShape spacing: gridSize.
	aCanvas addShape: gridShape
]

{ #category : #accessing }
RTGridView >> gridSize [
	^ gridSize
]

{ #category : #accessing }
RTGridView >> gridSize: aNumber [
	gridSize := aNumber
]

{ #category : #hooks }
RTGridView >> initializeElement: aView [
	aView attributeAt: self className put: self.
	self addGridShapeTo: aView canvas.
	self addCenterMarkerTo: aView canvas.
	self registerMovementEvents: aView canvas
]

{ #category : #hooks }
RTGridView >> registerMovementEvents: aCanvas [
	aCanvas
		when: TRMouseDragging
		do:
			[ :e | 
			gridShape addToOffset: e step negated / aCanvas camera scale.
			gridShape signalUpdate ].
	aCanvas when: TRMouseWheelEvent do: [ :e | gridShape resetPath ]
	"aCanvas camera translateBy: e step negated / aCanvas camera scale."
]
