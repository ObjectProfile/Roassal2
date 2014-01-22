"
I am a Spec model to embed Roassal2 visualizations
"
Class {
	#name : #RoassalModel,
	#superclass : #AbstractWidgetModel,
	#instVars : [
		'script',
		'lastEvent'
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

	script := [ :v :canvas | ] asValueHolder.
	script whenChangedDo: [ :s | self refresh ].
	lastEvent := nil asValueHolder.
]

{ #category : #accessing }
RoassalModel >> lastEvent [

	^ lastEvent value
]

{ #category : #accessing }
RoassalModel >> lastEvent: aBlock [

	lastEvent value: aBlock
]

{ #category : #protocol }
RoassalModel >> refresh [

	self changed: #applyScript with: #()
]

{ #category : #accessing }
RoassalModel >> script [

	^ script value
]

{ #category : #accessing }
RoassalModel >> script: aBlock [

	script value: aBlock
]

{ #category : #'protocol-events' }
RoassalModel >> whenLastEventChangedDo: aBlock [

	lastEvent whenChangedDo: aBlock
]
