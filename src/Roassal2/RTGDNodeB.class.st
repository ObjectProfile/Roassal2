Class {
	#name : #RTGDNodeB,
	#superclass : #RTGDShapedElementB,
	#instVars : [
		'withPopup',
		'draggableNodes'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #'as yet unclassified' }
RTGDNodeB >> createElementFor: objects [
	^ (shape elementOn: objects) @ RTDraggable @ RTPopup
]

{ #category : #'as yet unclassified' }
RTGDNodeB >> createElementsFor: objects [
	^ (shape elementsOn: objects) @ RTDraggable @ RTPopup
]

{ #category : #'as yet unclassified' }
RTGDNodeB >> initialize [
	super initialize.
	self shape: (RTEllipse new size: 10)
]
