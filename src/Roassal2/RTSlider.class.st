Class {
	#name : #RTSlider,
	#superclass : #RTBuilder,
	#instVars : [
		'callback',
		'labelled',
		'position',
		'sliderElements'
	],
	#category : #'Roassal2-Builder-UI-Slider'
}

{ #category : #'as yet unclassified' }
RTSlider >> build [
	| allElements res |
	allElements := view elements.
	res := super build.
	TRConstraint move: sliderElements below: allElements.
	^ res
]

{ #category : #accessing }
RTSlider >> callback [
	^ callback
]

{ #category : #accessing }
RTSlider >> callback: anObject [
	callback := anObject
]

{ #category : #'as yet unclassified' }
RTSlider >> createShapeBuilder [
	"RTBox new color: (Color red alpha: 0.5); width: 15; height: 20"
	^ super createShapeBuilder
		rectangle;
		color: (Color red alpha: 0.5);
		width: 15;
		height: 20;
		yourself
]

{ #category : #'as yet unclassified' }
RTSlider >> example01 [

	| v label slider |
	v := RTView new.
	label := RTLabel elementOn: 0.
	v add: label.
	
	slider := RTSlider new.
	slider view: v.
	slider labelled.
	slider callback: [ :aValue | label model: aValue * 100. label updateShape ].
	slider moveBelow.
	slider build.
	
	v
	 
]

{ #category : #'as yet unclassified' }
RTSlider >> initialize [
	super initialize.
	labelled := false.
	callback := [ :aValue | ].
	sliderElements := #()
]

{ #category : #'as yet unclassified' }
RTSlider >> labelled [
	labelled := true
]

{ #category : #'as yet unclassified' }
RTSlider >> moveBelow [
	position := #moveBelow
]

{ #category : #'as yet unclassified' }
RTSlider >> renderIn: aView [

	| extremity1 extremity2 line cursor dragAndConstraint trachelShape | 
	extremity1 := (RTBox new width: 5; height: 10) element.
	extremity2 := (RTBox new width: 5; height: 10) element.
	line := (RTLine new width: 5) edgeFrom: extremity1 to: extremity2.
	aView add: extremity1.
	aView add: extremity2.
	aView add: line.
	
	extremity2 translateTo: 200 @ 0.
	
	cursor := self elementOn: nil.
	
	dragAndConstraint := RTConstrainedDraggable new.
	dragAndConstraint rectangle: [ :someElement | extremity1 position corner: extremity2 position ].
	cursor @ dragAndConstraint.
	aView add: cursor.
	cursor translateTo: 100 @ 0.
	
	labelled ifTrue: [ 
		cursor @ (RTLabelled new text: 0).
		trachelShape := cursor attributeAt: #RTLabelledLabel.
		cursor when: TRMouseDragging do: [ :evt | 
			| aValue |
			aValue := (cursor position x - extremity1 position x) / (extremity2 position x - extremity1 position x).
			trachelShape text: (aValue asFloat round: 2) asString.
			callback rtValue: aValue ]
		].
	
	sliderElements := RTGroup new.
	sliderElements add: cursor.
	sliderElements add: extremity1.
	sliderElements add: extremity2.

]
