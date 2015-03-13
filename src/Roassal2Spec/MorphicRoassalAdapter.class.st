"
I am bridging RoassalModel and RTView
"
Class {
	#name : #MorphicRoassalAdapter,
	#superclass : #AbstractMorphicAdapter,
	#instVars : [
		'view',
		'canvas'
	],
	#category : #Roassal2Spec
}

{ #category : #specs }
MorphicRoassalAdapter class >> defaultSpec [

	^ #(RTViewForSpec
		whenLastEventChangedDo: #(model whenLastEventChangedBlock))
]

{ #category : #private }
MorphicRoassalAdapter >> adapt: aComposableModel [

	super adapt: aComposableModel.
	
	view := widget.
	canvas := view setUpCanvas.
	widget := canvas buildMorph.
	widget
		setProperty: #model toValue: self;
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	
	self basicApplyScript
	
]

{ #category : #private }
MorphicRoassalAdapter >> applyScript [

	self freeCanvas.
	self basicApplyScript
]

{ #category : #private }
MorphicRoassalAdapter >> basicApplyScript [

	self model script 
		cull: view 
		cull: canvas.
		
	self widgetDo: [ :w | w startStepping ]
]

{ #category : #private }
MorphicRoassalAdapter >> buildWidget [

	^ SpecInterpreter 
		private_interpretASpec: self class defaultSpec 
		model: self 
		selector: nil
]

{ #category : #private }
MorphicRoassalAdapter >> freeCanvas [
	
	view := RTViewForSpec new
		whenLastEventChangedDo: self whenLastEventChangedBlock;
		yourself.
	canvas := view setUpCanvas.
	widget extent: canvas extent.

	widget canvas: canvas.
]

{ #category : #protocol }
MorphicRoassalAdapter >> view [

	^ view
]

{ #category : #protocol }
MorphicRoassalAdapter >> whenLastEventChangedBlock [

	^ [ :evt | self model lastEvent: evt ]
]
