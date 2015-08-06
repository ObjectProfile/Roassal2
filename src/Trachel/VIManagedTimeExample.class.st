Class {
	#name : #VIManagedTimeExample,
	#superclass : #TRObject,
	#category : #'Trachel-Viva'
}

{ #category : #examples }
VIManagedTimeExample >> example01 [

	| v timer t e |
	v := RTView new.

	timer := VITimer new cycleLength: 2.
	t := VIAnimatedValue new.
	t evaluator: [ :time | 0 interpolateTo: 100 at: time ].
	t timer: timer.
	timer start.
	timer repeat.

	e := (RTEllipse new size: 30) element.

	v add: e.
	e translateTo: t @ t.

	v addMenu: 'refresh' callback: [ v signalUpdate ].
	v
]

{ #category : #examples }
VIManagedTimeExample >> example02 [

	| v timer t e slider |
	v := RTView new.

	timer := VIManualTimer new.

	t := VIAnimatedValue new.
	t evaluator: [ :time | 0 interpolateTo: 100 at: time ].
	t timer: timer.
	
	e := (RTEllipse new size: 30) element.

	v add: e.
	e translateTo: t @ t.

	"label := RTLabel elementOn: 0.
	v add: label."
	
	slider := RTSlider new.
	slider view: v.
	slider labelled.
	slider callback: [ :aValue | timer value: aValue  ].
	slider build.
	
	v
]
