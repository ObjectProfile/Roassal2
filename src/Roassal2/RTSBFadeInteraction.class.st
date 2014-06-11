"
A RTFadeInteraction is a roassal2 interaction that allows to an element of sunburst  and its path to stand out, this works with the RTMouseEnter/RTMouseLeave events.

Instance Variables
	action:		a block closure

action
	- When one element of sunburst is pointed, the fade action works over the other elements, when this happen, the action block is called with the element's model as an argument.

"
Class {
	#name : #RTSBFadeInteraction,
	#superclass : #RTInteraction,
	#instVars : [
		'action'
	],
	#category : #'Roassal2-Builder-Sunburst'
}

{ #category : #'initialize-release' }
RTSBFadeInteraction class >> action: ablock [
	| inst |
	inst := self new.
	inst action: ablock.
	^ inst.
]

{ #category : #computing }
RTSBFadeInteraction >> action: ablock [
	action := ablock
]

{ #category : #computing }
RTSBFadeInteraction >> children: element [
	(element attributes includesKey: #sbChildren) ifTrue: [ 
		^ element attributes at: #sbChildren ]
	ifFalse: [ ^ #() ].
]

{ #category : #computing }
RTSBFadeInteraction >> fade: element [
	| color |
	color := element shape color rtValue: element.
	element attributes at: #scolor put: element shape color.
	element view addAnimation: (RTColorTransitionAnimation new toColor:(color alpha: 0.2) during: 0.25 on: element).

	"element trachelShape color: (color alpha: 0.2).
	element trachelShape signalUpdate."
]

{ #category : #computing }
RTSBFadeInteraction >> fade: element element: target [
	"recursive fade the elements"
	
	| res v |
	res := true.
	(element = target) ifTrue: [ res := false. ].
	
	(self children: element) do: [ :node | 
		v := self fade: node element element: target.
		v ifTrue: [ self fade: node element ]
		ifFalse: [ res := false. ].
	].

	^ res.
	
]

{ #category : #computing }
RTSBFadeInteraction >> focus: element [
	| parent |
	parent := self parentOf: element.
	parent ifNil: [ ^ self ].
	self fade: parent element: element.
	
	
]

{ #category : #hooks }
RTSBFadeInteraction >> initializeElement: element [
	element when: TRMouseEnter do: [ :event | self focus: element. 
		action ifNotNil: [ action value: element model ] ].
	element when: TRMouseLeave do: [ :event | self restore: element ].
]

{ #category : #computing }
RTSBFadeInteraction >> parentOf: element [
	
	| e |
	e := element view elements first.
	^ e
]

{ #category : #computing }
RTSBFadeInteraction >> restore: element [
	| color |
	element view elements do: [:e |
		(e attributes includesKey: #scolor) ifTrue: [ 
			color := e attributes at: #scolor.
			e view addAnimation: (RTColorTransitionAnimation new 
				toColor: (color rtValue: e) during: 0.25 on: e ).
			"e trachelShape color: (color rtValue: e).
			e trachelShape signalUpdate" ].
		]
	
]
