"
A RTSelectable is an interaction that allows for element contained in a view to be selected and having a callback whenever the selection is changed
"
Class {
	#name : #RTSelectable,
	#superclass : #RTInteraction,
	#instVars : [
		'selectionCallback'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTSelectable >> clickOn: element [
	(self isSelected: element)
		ifTrue: [ self unselect: element ]
		ifFalse: [ self select: element ]
]

{ #category : #'as yet unclassified' }
RTSelectable >> evaluateCallback: selectedElements [

	selectionCallback value: selectedElements
	
]

{ #category : #'as yet unclassified' }
RTSelectable >> evaluateCallbackForElement: element [
	self evaluateCallback: (self selectedElementsFrom: element)
]

{ #category : #'as yet unclassified' }
RTSelectable >> initialize [
	super initialize.
	selectionCallback := [ :selectedElements | ]
]

{ #category : #'as yet unclassified' }
RTSelectable >> initializeElement: element [
	element when: TRMouseClick do: [ :event | self clickOn: event element ]
]

{ #category : #'as yet unclassified' }
RTSelectable >> isSelected: element [
	^ element attributeAt: #isSelected ifAbsent: [ false ]
]

{ #category : #'as yet unclassified' }
RTSelectable >> isViewBeenPreparedForDeselection: aView [

	^ aView attributeAt: #preparedForDeselection ifAbsent: [ false ]
]

{ #category : #'as yet unclassified' }
RTSelectable >> prepareViewBeenForDeselection: aView [
	"Make the view react when one click on the view. Element should be unselected"
	(self isViewBeenPreparedForDeselection: aView) 
		ifFalse: [
			aView when: TRMouseClick do: [ :evt | 
				aView elements do: [ :e | (self isSelected: e) ifTrue: [ self unselectNoCallback: e ] ].
				self evaluateCallback: RTGroup new ] ]
]

{ #category : #'as yet unclassified' }
RTSelectable >> select: element [
	element attributeAt: #oldColor put: element trachelShape color.
	element attributeAt: #isSelected put: true.
	element trachelShape color: Color red.
	self evaluateCallbackForElement: element.
	self prepareViewBeenForDeselection: element view
]

{ #category : #'as yet unclassified' }
RTSelectable >> selectedElementsFrom: element [
	^ element view elements select: [ :e | e attributeAt: #isSelected ifAbsent: [ false ] ]
]

{ #category : #accessing }
RTSelectable >> selectionCallback [
	^ selectionCallback
]

{ #category : #accessing }
RTSelectable >> selectionCallback: aOneArgBlock [
	"aOneArgBlock will be evaluated at each selection. 
	The collection of selected elements is provided to the block"
	selectionCallback := aOneArgBlock
]

{ #category : #'as yet unclassified' }
RTSelectable >> unselect: element [
	self unselectNoCallback: element.
	self evaluateCallbackForElement: element
]

{ #category : #'as yet unclassified' }
RTSelectable >> unselectNoCallback: element [
	element trachelShape color: (element attributeAt: #oldColor).
	element attributeAt: #isSelected put: false
]
