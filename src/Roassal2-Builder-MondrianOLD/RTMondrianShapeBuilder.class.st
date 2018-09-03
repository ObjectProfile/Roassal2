Class {
	#name : #RTMondrianShapeBuilder,
	#superclass : #RTBoundedShapeBuilder,
	#category : #'Roassal2-Builder-MondrianOLD'
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
