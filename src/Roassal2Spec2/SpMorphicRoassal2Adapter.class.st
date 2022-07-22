Class {
	#name : #SpMorphicRoassal2Adapter,
	#superclass : #SpAbstractMorphicAdapter,
	#instVars : [
		'view',
		'canvas'
	],
	#category : #'Roassal2Spec2-Core'
}

{ #category : #initialization }
SpMorphicRoassal2Adapter >> adapt: aComposableModel [

	self basicAdapt: aComposableModel.

	view := widget.
	canvas := view setUpCanvas.
	widget := canvas buildMorph.

	self addSettingsTo: self widget.
	self addKeyBindingsTo: self widget.
	self addEventsTo: self widget.

	widget
		setProperty: #model toValue: self;
		hResizing: #spaceFill;
		vResizing: #spaceFill.

	self basicApplyScript
]

{ #category : #'scripting actions' }
SpMorphicRoassal2Adapter >> applyScript [
	| extent |
	extent := canvas extent.
	self freeCanvas.
	self basicApplyScript.
	canvas extent: extent.
	
]

{ #category : #'scripting actions' }
SpMorphicRoassal2Adapter >> basicApplyScript [

	self model script cull: view cull: canvas.

	self widgetDo: #startStepping.
	view when: TRMouseEnter do: [ widget takeKeyboardFocus ]
]

{ #category : #factory }
SpMorphicRoassal2Adapter >> buildWidget [

	^ RTView new
]

{ #category : #'scripting actions' }
SpMorphicRoassal2Adapter >> freeCanvas [
	view := self buildWidget.
	canvas := view setUpCanvas.

	widget canvas: canvas.
	canvas morph: widget.
	widget extent: canvas extent
]

{ #category : #accessing }
SpMorphicRoassal2Adapter >> view [

	^ view
]
