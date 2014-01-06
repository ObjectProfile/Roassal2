"
I am a Spec model to embed Roassal2 visualizations
"
Class {
	#name : #RoassalModel,
	#superclass : #AbstractWidgetModel,
	#instVars : [
		'script'
	],
	#category : #Roassal2Spec
}

{ #category : #specs }
RoassalModel class >> defaultSpec [
	<spec>
	
	^ #(MorphicRoassalAdapter
		adapt: #(model))
]

{ #category : #initialize }
RoassalModel >> initialize [

	super initialize.

	script := [ :view :canvas | ] asValueHolder.
	script whenChangedDo: [ self changed: #applyScript with: #() ]
]

{ #category : #accessing }
RoassalModel >> script [

	^ script value
]

{ #category : #accessing }
RoassalModel >> script: aBlock [

	script value: aBlock
]
