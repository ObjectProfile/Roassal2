Class {
	#name : #RTInteractiveViewContext,
	#superclass : #RTAbstractViewContext,
	#category : #'Roassal2GT-Glamour-Context'
}

{ #category : #'as yet unclassified' }
RTInteractiveViewContext class >> isDefault [
	^ true
]

{ #category : #hooks }
RTInteractiveViewContext >> registerCallbacks [
	"Do nothing. No callback has to be registered"

	self makeViewAutomaticallyResizable.
	self makeAllElementsInTheViewAsSelectable.
]
