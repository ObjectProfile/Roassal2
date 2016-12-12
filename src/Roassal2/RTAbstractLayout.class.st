Class {
	#name : #RTAbstractLayout,
	#superclass : #RTObject,
	#category : #'Roassal2-Layouts'
}

{ #category : #hook }
RTAbstractLayout >> doExecute: groupOfElements [
	"Performs the layout"

	self subclassResponsibility
]
