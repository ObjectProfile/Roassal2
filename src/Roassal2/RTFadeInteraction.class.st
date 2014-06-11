Class {
	#name : #RTFadeInteraction,
	#superclass : #RTInteraction,
	#instVars : [
		'action'
	],
	#category : #'Roassal2-Builder-Sunburst'
}

{ #category : #computing }
RTFadeInteraction >> action: ablock [
	action := ablock
]

{ #category : #computing }
RTFadeInteraction >> children: element [
	(element attributes includesKey: #sbChildren) ifTrue: [ 
		^ element attributes at: #sbChildren ]
	ifFalse: [ ^ #() ].
]

{ #category : #computing }
RTFadeInteraction >> fade: element [
	| color |
	color := element shape color rtValue: element.
	element attributes at: #scolor put: element shape color.
	element trachelShape color: (color alpha: 0.2).
	element trachelShape signalUpdate.
]

{ #category : #computing }
RTFadeInteraction >> fade: element element: target [
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
RTFadeInteraction >> focus: element [
	| parent |
	parent := self parentOf: element.
	parent ifNil: [ ^ self ].
	self fade: parent element: element.
	
	
]

{ #category : #hooks }
RTFadeInteraction >> initializeElement: element [
	element when: TRMouseEnter do: [ :event | self focus: element. 
		action ifNotNil: [ action value: element model ] ].
	element when: TRMouseLeave do: [ :event | self restore: element ].
]

{ #category : #computing }
RTFadeInteraction >> parentOf: element [
	| e |
	e := element view elements first.
	^ e
]

{ #category : #computing }
RTFadeInteraction >> restore: element [
	| color |
	element view elements do: [:e |
		(e attributes includesKey: #scolor) ifTrue: [ 
			color := e attributes at: #scolor.
			e trachelShape color: (color rtValue: e).
			e trachelShape signalUpdate ].
		]
	
]
