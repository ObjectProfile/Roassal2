Class {
	#name : #RTAbstractViewContext,
	#superclass : #RTObject,
	#instVars : [
		'view'
	],
	#category : #'Roassal2GT-Glamour-Context'
}

{ #category : #public }
RTAbstractViewContext >> adjustView: aView [
	self assert: [ aView isKindOf: RTView ] description: 'Only a roassal view may be provided'.
	view := aView.
	self registerCallbacks
]

{ #category : #accessing }
RTAbstractViewContext >> canvas [
	^ view canvas
]

{ #category : #'available callbacks' }
RTAbstractViewContext >> makeViewAutomaticallyResizable [
	self canvas
		when: TRResizeCanvasEvent
		do: [ :evt | self canvas focusOnCenterScaled ]
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
