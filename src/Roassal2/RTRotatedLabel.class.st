Class {
	#name : #RTRotatedLabel,
	#superclass : #RTLabel,
	#instVars : [
		'angle'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTRotatedLabel >> angleFor: element [
	^ angle rtValue: element
]

{ #category : #'as yet unclassified' }
RTRotatedLabel >> angleInDegree: aValueOrABlock [
	"The argument will be evaluated against the model"
	angle := aValueOrABlock
]

{ #category : #'as yet unclassified' }
RTRotatedLabel >> initialize [
	super initialize.
	self angleInDegree: 0.
]

{ #category : #'as yet unclassified' }
RTRotatedLabel >> trachelShapeFor: anElement [
	|  shape |
	"ex := (self widthFor: anElement) @ (self heightFor: anElement)."
	"rec := (anElement position ) extent: ex."
	
	shape := TRRotatedLabelShape new.
	shape text: (self textFor: anElement);
			color: (self colorFor: anElement);
			position: anElement position;
			angleInDegree: (self angleFor: anElement);
			fontSize: (self heightFor: anElement).
	^ shape
]
