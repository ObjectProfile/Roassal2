Class {
	#name : #RTInteractiveViewContext,
	#superclass : #RTAbstractViewContext,
	#category : #'Roassal2GT-Glamour-Context'
}

{ #category : #hooks }
RTInteractiveViewContext >> registerCallbacks [
	"Do nothing. No callback has to be registered"

	self makeViewAutomaticallyResizable
]
