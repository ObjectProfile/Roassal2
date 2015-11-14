Class {
	#name : #RTGTContext,
	#superclass : #RTTest,
	#category : #'Roassal2GT-Glamour-Context'
}

{ #category : #tests }
RTGTContext >> testGetContextFor [

	| prez view context |
	prez := GLMRoassal2Presentation new.
	view := RTView new.
	self deny: view hasAttributes.
	context := prez getContextFor: view.
	self assert: context notNil.
	self assert: context class equals: RTAbstractViewContext defaultContextClass.
	self assert: (context class inheritsFrom: RTAbstractViewContext).
	self assert: view hasAttributes.
]

{ #category : #tests }
RTGTContext >> testdefaultContextClass [
	self assert: RTAbstractViewContext defaultContextClass notNil.
	self assert: RTAbstractViewContext defaultContextClass isBehavior.
]

{ #category : #tests }
RTGTContext >> testuseContextToInitialize [

	| prez view |
	prez := GLMRoassal2Presentation new.
	view := RTView new.
	self assert: view announcer numberOfSubscriptions = 0.
	prez useContextToInitialize: view.
	self assert: view announcer numberOfSubscriptions > 0
]
