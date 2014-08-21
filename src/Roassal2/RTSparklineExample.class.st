Class {
	#name : #RTSparklineExample,
	#superclass : #RTObject,
	#category : 'Roassal2-Sparkline'
}

{ #category : #'as yet unclassified' }
RTSparklineExample >> example01 [
	"
	self new example01
	"

	| v es |
	v := RTView new.
	es := (RTSparkline new 
				width: 50; height: 30;
				values: [ :cls | cls methods collect: #numberOfLinesOfCode ]) elementsOn:  { RTShape . RTBox }.
	es @ RTDraggable @ RTPopup.
	v addAll: es.
	RTHorizontalLineLayout on: es.
	v setDefaultMenu.
	v open.
	v
]

{ #category : #'as yet unclassified' }
RTSparklineExample >> example03 [
	"
	self new example03
	"

	| v e shape |
	v := RTView new.
	shape := RTSparkline new 
					width: 50;
					height: 50;
					values: ((1 to: 20) collect: #atRandom).
	e := shape element.
	e @ RTDraggable.
	v add: e.
	v add: (RTEllipse new color: (Color red alpha: 0.4); size: 5) element.
	
	v setDefaultMenu.
	v open
]
