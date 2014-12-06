Class {
	#name : #RTMondrianShapeBuilder,
	#superclass : #RTBoundedShapeBuilder,
	#category : #'Roassal2-Builder-Mondrian'
}

{ #category : #shapes }
RTMondrianShapeBuilder >> circle [
	super circle
		withBorder
]

{ #category : #shapes }
RTMondrianShapeBuilder >> defaultColor [
	^ Color white
]

{ #category : #shapes }
RTMondrianShapeBuilder >> rectangle [
	^ super rectangle withBorder
]
