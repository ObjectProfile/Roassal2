"
Class implementing a slider with two cursors, useful for selection of intervals
"
Class {
	#name : #RTDoubleSlider,
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
RTDoubleSlider >> build [
	| allElements res |
	allElements := view elements.
	res := super build.
	TRConstraint move: sliderElements below: allElements.
	^ res
]

{ #category : #accessing }
RTDoubleSlider >> callback [
	^ callback
]

{ #category : #accessing }
RTDoubleSlider >> callback: aTwoArgBlock [
	"everytime the slider is moved the aTwoArgBlock will be evaluated with 2 arguments which correspond 
	to the position of the 2 cursors of the double slider, from the configured min value to the configured max value"
	callback := aTwoArgBlock
]

{ #category : #hooks }
RTDoubleSlider >> createShapeBuilder [
	"RTBox new color: (Color red alpha: 0.5); width: 15; height: 20"
	^ super createShapeBuilder
		rectangle;
		color: (Color red alpha: 0.5);
		width: 10;
		height: 20;
		yourself
]

{ #category : #examples }
RTDoubleSlider >> example01 [
	| v label1 label2 doubleSlider composer |
	v := RTView new.
	
	composer := RTComposer new.
	composer view: v.
	
	label1 := RTLabel elementOn: 0.
	v add: label1.
	composer group: label1.
	
	label2 := RTLabel elementOn: 0.
	v add: label2.
	composer group: label2.
	
	doubleSlider := RTDoubleSlider new.
	doubleSlider view: v.
	doubleSlider labeled.
	doubleSlider callback: [ :cursor1 :cursor2 | 
		label1 model: cursor1 * 100.
		label1 updateShape.
		label2 model: cursor2 * 100.
		label2 updateShape. ].
	doubleSlider moveBelow.
	doubleSlider build.
	composer group: doubleSlider.
	
	composer layout: (RTVerticalLineLayout new gapSize: 25; center).
	v
	 
]

{ #category : #initialization }
RTDoubleSlider >> initialize [
	super initialize.
	labelled := false.
	callback := [ :arg1 :arg2 | ].
	sliderElements := #().
	min := 0.0.
	max := 1.0.
	useIntegerLabel := false.
]

{ #category : #accessing }
RTDoubleSlider >> isLabelled [
	^labelled
]

{ #category : #accessing }
RTDoubleSlider >> labeled [
	labelled := true
]

{ #category : #accessing }
RTDoubleSlider >> labelled [
	self labeled
]

{ #category : #accessing }
RTDoubleSlider >> max [
	^ max
]

{ #category : #accessing }
RTDoubleSlider >> max: aNumber [
	self assert: [ min <= aNumber ] description: 'Max value cant be smaller than the min value'.
	max := aNumber
]

{ #category : #accessing }
RTDoubleSlider >> min [
	^ min
]

{ #category : #accessing }
RTDoubleSlider >> min: aNumber [
	self assert: [ aNumber <= max ] description: 'Min value cant be bigger than the max value'.
	min := aNumber
]

{ #category : #public }
RTDoubleSlider >> moveBelow [
	position := #moveBelow
]

{ #category : #hooks }
RTDoubleSlider >> renderIn: aView [

	| extremity1 extremity2 line cursorMin draggableMin labelMin cursorMax draggableMax labelMax positionMin positionMax |
	
	"create base elements (line and extremes)"
	extremity1 := (RTBox new width: 5; height: 10) element.
	extremity2 := (RTBox new width: 5; height: 10) element.
	line := (RTLine new width: 5) edgeFrom: extremity1 to: extremity2.
	aView add: extremity1.
	aView add: extremity2.
	aView add: line.
	extremity2 translateTo: 200 @ 0.
	
	"cursors"
	cursorMin := self elementOn: nil.
	cursorMax := self elementOn: nil.

	"set draggable interactions"
	draggableMin := RTConstrainedDraggable new.
	draggableMin rectangle: [ :someElement | extremity1 position corner: extremity2 position ].
	cursorMin @ draggableMin.
	aView add: cursorMin.
	cursorMin translateTo: 0 @ 0.

	draggableMax := RTConstrainedDraggable new.
	draggableMax rectangle: [ :someElement | extremity1 position corner: extremity2 position ].
	cursorMax @ draggableMax.
	aView add: cursorMax.
	cursorMax translateTo: 200 @ 0.
		
	"set labels if necessary"
	labelled ifTrue: [
		positionMin := (cursorMin position x - extremity1 position x) / (extremity2 position x - extremity1 position x).
		positionMin := (positionMin * (max - min)) + min.
		positionMin := useIntegerLabel ifTrue: [ (positionMin round: 0) asInteger ] ifFalse: [ positionMin round: 2 ].
		
		positionMax := (cursorMax position x - extremity1 position x) / (extremity2 position x - extremity1 position x).
		positionMax := (positionMax * (max - min)) + min.
		positionMax := useIntegerLabel ifTrue: [ (positionMax round: 0) asInteger ] ifFalse: [ positionMax round: 2 ].

		cursorMin @ (RTLabeled new text: positionMin).
		labelMin := cursorMin attributeAt: #RTLabelledLabel. 
		cursorMax @ (RTLabeled new text: positionMax).
		labelMax := cursorMax attributeAt: #RTLabelledLabel ].

	"compute the cursors values and call callbacks"
	cursorMin when: TRMouseDragging do: [ :evt | 
		"bound the cursorMin's position"
		(cursorMin position x) > (cursorMax position x)
			ifTrue: [ cursorMin translateTo: (cursorMax position x @ cursorMin position y) ].
		
		"calculate the positions of the cursors"
		positionMin := (cursorMin position x - extremity1 position x) / (extremity2 position x - extremity1 position x).
		positionMin := (positionMin * (max - min)) + min.
		positionMax := (cursorMax position x - extremity1 position x) / (extremity2 position x - extremity1 position x).
		positionMax := (positionMax * (max - min)) + min.

		callback rtValue: (Array with: positionMin with: positionMax).
		labelled ifTrue: [ labelMin text: (useIntegerLabel ifTrue: [ (positionMin round: 0) asInteger ] ifFalse: [ positionMin round: 2 ]) asString ] ].

	cursorMax when: TRMouseDragging do: [ :evt | 
		"bound the cursorMax's position"
		(cursorMin position x) > (cursorMax position x)
			ifTrue: [ cursorMax translateTo: (cursorMin position x @ cursorMax position y) ].

		"calculate the positions of the cursors"
		positionMin := (cursorMin position x - extremity1 position x) / (extremity2 position x - extremity1 position x).
		positionMin := (positionMin * (max - min)) + min.
		positionMax := (cursorMax position x - extremity1 position x) / (extremity2 position x - extremity1 position x).
		positionMax := (positionMax * (max - min)) + min.

		callback rtValue: (Array with: positionMin with: positionMax).
		labelled ifTrue: [ labelMax text: (useIntegerLabel ifTrue: [ (positionMax round: 0) asInteger ] ifFalse: [ positionMax round: 2 ]) asString ] ].

	"keep track of the elements added to the view"
	sliderElements := RTGroup new.
	sliderElements add: cursorMin.
	sliderElements add: cursorMax.
	sliderElements add: extremity1.
	sliderElements add: extremity2.

]

{ #category : #accessing }
RTDoubleSlider >> useIntegerLabel [
	"sets the display of the slider's label using an integral value instead of a floating point one
	ex:
		slider useIntegerLabel
	"
	useIntegerLabel := true
]

{ #category : #accessing }
RTDoubleSlider >> usingIntegerLabel [
	^useIntegerLabel
]
