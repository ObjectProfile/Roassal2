"
I am a view interaction allowing horizontal translation.

In addition, I hold a block allowing constraints on the translations
"
Class {
	#name : #RTConstrainedDraggableView,
	#superclass : #RTDraggableView,
	#instVars : [
		'constraint'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'instance creation' }
RTConstrainedDraggableView class >> constraint: constraint [

	^ self new
		constraint: constraint;
		yourself
]

{ #category : #accessing }
RTConstrainedDraggableView >> constraint: anObject [
	
	constraint := anObject
]

{ #category : #initialize }
RTConstrainedDraggableView >> initialize [

	super initialize.

	constraint := [ :point | point ].
]

{ #category : #hooks }
RTConstrainedDraggableView >> initializeElement: aView [

	aView canvas 
		when: TRMouseDragging 
		do: [ :e || translation |
			translation := constraint value: e step negated.
			aView canvas camera translateBy: translation.
			e signalUpdate ]
]
