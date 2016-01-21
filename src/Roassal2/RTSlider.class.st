"
Create a slider on a view. A callback may be set when it is moved

[ [ [ 
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
 ] ] ]
"
Class {
	#name : #RTSlider,
	#superclass : #RTBuilder,
	#instVars : [
		'callback',
		'labelled',
		'position',
		'sliderElements',
		'min',
		'max',
		'useIntegerLabel'
	],
	#category : #'Roassal2-Builder-UI-Slider'
}

{ #category : #public }
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
RTSlider >> callback: aOneArgBlock [
	"At each movement of the slider, the argument aOneArgBlock will be evaluated. The bloc takes as argument a float value, ranging between 0.0 and 1.0"
	callback := aOneArgBlock
]

{ #category : #hooks }
RTSlider >> createShapeBuilder [
	"RTBox new color: (Color red alpha: 0.5); width: 15; height: 20"
	^ super createShapeBuilder
		rectangle;
		color: (Color red alpha: 0.5);
		width: 15;
		height: 20;
		yourself
]

{ #category : #examples }
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

{ #category : #initialization }
RTSlider >> initialize [
	super initialize.
	labelled := false.
	callback := [ :aValue | ].
	sliderElements := #().
	min := 0.0.
	max := 1.0.
	useIntegerLabel := false.
]

{ #category : #accessing }
RTSlider >> labelled [
	labelled := true
]

{ #category : #accessing }
RTSlider >> max [
	^ max
]

{ #category : #accessing }
RTSlider >> max: aNumber [
	self assert: [ min <= aNumber ] description: 'Max value cant be smaller than the min value'.
	max := aNumber
]

{ #category : #accessing }
RTSlider >> min [
	^ min
]

{ #category : #accessing }
RTSlider >> min: aNumber [
	self assert: [ aNumber <= max ] description: 'Min value cant be bigger than the max value'.
	min := aNumber
]

{ #category : #public }
RTSlider >> moveBelow [
	position := #moveBelow
]

{ #category : #hooks }
RTSlider >> renderIn: aView [

	| extremity1 extremity2 line cursor dragAndConstraint trachelShape aValue | 
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
	
	"We prepare a label if necessary"
	labelled ifTrue: [ 
		cursor @ (RTLabelled new text: 0).
		trachelShape := cursor attributeAt: #RTLabelledLabel ].
	
	"We compute the slider value, and call the callback"
	cursor when: TRMouseDragging do: [ :evt | 
		aValue := (cursor position x - extremity1 position x) / (extremity2 position x - extremity1 position x).
		aValue := (aValue * (max - min)) + min.
		callback rtValue: aValue.
		labelled ifTrue: [ trachelShape text: (useIntegerLabel ifTrue: [ (aValue round: 0) asInteger ] ifFalse: [ aValue round: 2 ]) asString ] ].

	"We keep track of the elements we add in the view"
	sliderElements := RTGroup new.
	sliderElements add: cursor.
	sliderElements add: extremity1.
	sliderElements add: extremity2.

]

{ #category : #accessing }
RTSlider >> useIntegerLabel [
	"sets the display of the slider's label using an integral value instead of a floating point one
	ex:
		slider useIntegerLabel
	"
	useIntegerLabel := true
]
