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
	<spec>
	
	^ #(RTView)
]

{ #category : #private }
MorphicRoassalAdapter >> adapt: aComposableModel [

	super adapt: aComposableModel.
	view := widget.
	canvas := widget createAndFillCanvas.
	widget := canvas buildMorph.
	widget
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	
	self applyScript
	
]

{ #category : #private }
MorphicRoassalAdapter >> applyScript [
	
	self freeCanvas.
	
	self model script
		cull: view
		cull: canvas.
		
	self widgetDo: [ :w | w startStepping ]
]

{ #category : #private }
MorphicRoassalAdapter >> freeCanvas [
	
	view elements do: [ :e | view removeElement: e ].	
	self widgetDo: [ :w | w changed ]
]
