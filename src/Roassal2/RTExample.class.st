Class {
	#name : #RTExample,
	#superclass : #RTObject,
	#category : #Roassal2
}

{ #category : #animations }
RTExample >> animationTest [
	"
	self new animationTest
	"
	| view circle |
	view := RTView new.
	circle := (RTEllipse new size: 40; color: (Color purple alpha: 0.2)) element.
	view add: circle.
	view addAnimation: (RTLinearMove to: 100 @ 100 during: 2 on: circle). 

	view open.
	^ view
]

{ #category : #'as yet unclassified' }
RTExample >> basic [
	"
	self new basic
	"
	
	| view |
	view := RTView new.
	view add: (RTBox element translateTo: 20 @ 20; yourself).
	view open
]

{ #category : #'as yet unclassified' }
RTExample >> circles [
	"
	self new circles
	"

	| view shape el |
	view := RTView new.
	shape := RTEllipse new color: (Color purple alpha: 0.2); size: 80.
	100 timesRepeat: [ 
		el := shape element translateTo: 500 atRandom @ 500 atRandom.
		el @ RTDraggable.
		view add: el. 
		view addAnimation: (RTLinearMove to: 500 atRandom @ 500 atRandom during: 2 on: el).
	].	
	view open
]

{ #category : #'as yet unclassified' }
RTExample >> growingSquares [
	"
	self new growingSquares
	"
	
	| view shape |
	view := RTView new.

	shape := RTBox new size: [ :e | e model yourself ].
	1 to: 100 do: [ :i |
		view add: ((shape elementOn: i) translateTo: 20 @ 20; yourself).
	].
	RTGridLayout on: view elements.
	
	view open
]

{ #category : #'as yet unclassified' }
RTExample >> highlightSquare [
	"
	self new highlightSquare
	"
	
	| view shape el |
	view := RTView new.

	shape := RTBox new size: [ :e | e model yourself ].
	1 to: 100 do: [ :i |
		el := shape elementOn: i.
		el translateTo: 20 @ 20.
		el on: TRMouseEnter do: [ :e | e shape color: Color red. e signalUpdate ].
		el on: TRMouseLeave do: [ :e | e shape color: Color gray. e signalUpdate ].
		el on: TRMouseDragging do: [ :e | e shape translateBy: e step. e signalUpdate ].
		view add: el.
	].
	RTGridLayout on: view elements.
	
	view open
]

{ #category : #'as yet unclassified' }
RTExample >> linkedSquares [
	"
	self new linkedSquares
	"
	| view shape  fromEl toEl edge |
	view := RTView new.

	shape := RTBox new size: 90; color: (Color blue alpha: 0.1).
	fromEl := shape element.
	fromEl translateTo: 20 @ 30.
	fromEl @ RTDraggable.

	toEl := shape element.
	toEl translateTo: 200 @ 80.
	toEl @ RTDraggable.
	
	edge := RTLine edgeFrom: fromEl to: toEl.  	
	view add: fromEl; add: toEl; add: edge.

	view open.
	view inspect
]

{ #category : #'as yet unclassified' }
RTExample >> manySquares [
	"
	self new manySquares
	"
	
	| view shape el |
	view := RTView new.

	shape := RTBox new.
	1 to: 7000 do: [ :i |
		el := shape elementOn: i.
		el translateTo: 20 @ 20.
		el @ RTHighlightable.
		el @ RTDraggable.
		view add: el.
	].
	RTGridLayout new gapSize: 1; on: view elements.
	
	view open
]
