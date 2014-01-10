"
I am an interaction to translate the view as my parent.
The difference is that I only allow horizontal translations
"
Class {
	#name : #RTHorizontalDraggableView,
	#superclass : #RTConstrainedDraggableView,
	#category : #'Roassal2-Core'
}

{ #category : #initialize }
RTHorizontalDraggableView >> initialize [

	super initialize.
	self constraint: [ :point | point x @ 0 ]
]
