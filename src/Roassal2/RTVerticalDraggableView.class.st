"
I am an interaction to translate the view as my parent.
The difference is that I only allow horizontal translations
"
Class {
	#name : #RTVerticalDraggableView,
	#superclass : #RTConstrainedDraggableView,
	#category : #'Roassal2-Core'
}

{ #category : #initialize }
RTVerticalDraggableView >> initialize [

	super initialize.
	self constraint: [ :point | 0 @ point y ]
]
