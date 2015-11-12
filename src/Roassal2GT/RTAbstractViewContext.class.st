Class {
	#name : #RTAbstractViewContext,
	#superclass : #RTObject,
	#instVars : [
		'view',
		'presentation'
	],
	#category : #'Roassal2GT-Glamour-Context'
}

{ #category : #public }
RTAbstractViewContext class >> createContext [
	"Define a new context in case none has been set"
	^ self defaultContextClass new
]

{ #category : #context }
RTAbstractViewContext class >> defaultContextClass [
	"Return the default context used by Glamour when no context is set"
	^ self withAllSubclasses detect: #isDefault
]

{ #category : #public }
RTAbstractViewContext class >> getContextFor: aView [
	"Return the context associated to the view. It none is defined, then this method create one, and set it in view."
	^ aView attributeAt: #GlamourContext ifAbsentPut: [ self createContext ].

]

{ #category : #testing }
RTAbstractViewContext class >> isDefault [
	^ false
]

{ #category : #public }
RTAbstractViewContext class >> setOnView: aView [
	aView attributeAt: #GlamourContext put: self new
]

{ #category : #public }
RTAbstractViewContext >> adjustView: aView inPresentation: aPresentation. [
	self view: aView.
	self presentation: aPresentation.
	self registerCallbacks
]

{ #category : #accessing }
RTAbstractViewContext >> canvas [
	^ view canvas
]

{ #category : #'available callbacks' }
RTAbstractViewContext >> makeAllElementsInTheViewAsSelectable [
	self view elements do: [:each |  
			each when: TRMouseLeftClick do: [ :event | 
				each model ifNotNil: [ self presentation selection: each model ] ] ].
]

{ #category : #'available callbacks' }
RTAbstractViewContext >> makeViewAutomaticallyResizable [
	self canvas
		when: TRResizeCanvasEvent
		do: [ :evt | 
			| es |
			es := self view elements asGroup encompassingRectangle. 
			(es width + es height) > 4000
				ifFalse: [ self canvas focusOnCenterScaled ] ]
]

{ #category : #accessing }
RTAbstractViewContext >> presentation [
	"Return the Roassal2Presentation in which I am used"
	^ presentation
]

{ #category : #accessing }
RTAbstractViewContext >> presentation: aPresentation [
	self assert: [ aPresentation isKindOf: GLMRoassal2Presentation ] description: 'Only a GLMRoassal2Presentation can be provided here'.
	presentation := aPresentation
]

{ #category : #hooks }
RTAbstractViewContext >> registerCallbacks [
	"This method should be overriden to define relevant callbacks"
	self subclassResponsibility
]

{ #category : #accessing }
RTAbstractViewContext >> view [
	^ view
]

{ #category : #accessing }
RTAbstractViewContext >> view: aView [
	self assert: [ aView isKindOf: RTView ] description: 'Only a roassal view may be provided'.
	view := aView
]
