"
I am interaction which allows view to be zoomed with a mouce wheel.
"
Class {
	#name : #RTZoomableView,
	#superclass : #RTInteraction,
	#category : #'Roassal2-Core'
}

{ #category : #hooks }
RTZoomableView >> initializeElement: aView [
	aView canvas when: TRMouseWheelEvent do: [ :e |
		| scale |
		scale := aView canvas camera scale.
		e direction = #up ifTrue: [ scale := scale * 1.25 ].
		e direction = #down ifTrue: [ scale := scale / 1.25 ].
		aView canvas camera scale: scale.
		aView signalUpdate ]
]
