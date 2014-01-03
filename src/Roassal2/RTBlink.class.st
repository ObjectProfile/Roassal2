"
A ROBlink is xxxxxxxxx.

"
Class {
	#name : #RTBlink,
	#superclass : #RTAction,
	#category : #'Roassal2-Core'
}

{ #category : #configuration }
RTBlink class >> defaultColor [
	^ Color red
]

{ #category : #util }
RTBlink class >> highlight: element [
	self highlight: element color: self defaultColor
]

{ #category : #util }
RTBlink class >> highlight: element color: aColor [
	self set: element color: aColor
]

{ #category : #public }
RTBlink class >> highlightElements: elements [
	^ elements do: [ :el | self highlight: el ] 
 
]

{ #category : #public }
RTBlink class >> highlightElements: elements color: aColor [
	^ elements do: [ :el | self highlight: el color: aColor ] 
 
]

{ #category : #public }
RTBlink class >> highlightIncomingEdgesOf: element [
	"Blink all the edges that leave the node element"
	element view elementsAsEdge 
		do: [ :edg | (edg to == element) ifTrue: [ self highlight: edg ] ].
]

{ #category : #public }
RTBlink class >> highlightOutgoingEdgesOf: element [
	"Blink all the edges that leave the node element"
	element view elementsAsEdge 
		do: [ :edg | (edg from == element) ifTrue: [ self highlight: edg ] ].
]

{ #category : #public }
RTBlink class >> incomingEdgesOf: element [
	"Blink all the edges that leave the node element"
	element view raw elementsAsEdge 
		do: [ :edg | (edg from == element) ifTrue: [ ROBlink on: edg ] ].
]

{ #category : #testing }
RTBlink class >> isBlinking: element [
	^ element attributes includesKey: #oldColor
]

{ #category : #testing }
RTBlink class >> isHighlighted: element [
	^ element attributes includesKey: #oldColor
]

{ #category : #public }
RTBlink class >> on: element [

	^ self new on: element
]

{ #category : #public }
RTBlink class >> outgoingEdgesOf: element [
	"Blink all the edges that leave the node element"
	element view elementsAsEdge 
		do: [ :edg | (edg to == element) ifTrue: [ ROBlink on: edg ] ].
]

{ #category : #util }
RTBlink class >> set: element color: aColor [
	| shape |
	shape := element shape.
	(element attributes includesKey: #oldColor)
		ifFalse: 
			[ element attributes at: #oldColor put: element trachelShape color.
				element trachelShape
					 color: aColor;
					 signalUpdate ]
]

{ #category : #util }
RTBlink class >> unhighlight: element [
	| shape |
	(self isHighlighted: element) ifFalse: [ ^ self ].
	shape := element trachelShape.
	shape color: (element attributes at: #oldColor).
	element attributes removeKey: #oldColor. 
	element trachelShape signalUpdate
]

{ #category : #public }
RTBlink class >> unhighlightElements: elements [
	^ elements do: [ :el | self unhighlight: el ] 
 
]

{ #category : #public }
RTBlink class >> unhighlightOutgoingEdgesOf: element [
	"Blink all the edges that leave the node element"
	element view elementsAsEdge 
		do: [ :edg | (edg from == element) ifTrue: [ self unhighlight: edg ] ].
]

{ #category : #configuration }
RTBlink >> defaultColor [
	^ self class defaultColor
]

{ #category : #util }
RTBlink >> highlight: element [
	^ self class highlight: element
]

{ #category : #util }
RTBlink >> highlight: element color: aColor [
	^ self class highlight: element color: aColor
]

{ #category : #testing }
RTBlink >> isHighlighted: element [
	^ self class isHighlighted: element
]

{ #category : #configuration }
RTBlink >> nbOfSecondsLightOn [
	^ 1
]

{ #category : #public }
RTBlink >> on: element [
	self highlight: element.
	^ RTNopAnimation new
		waitFor: self nbOfSecondsLightOn;
		after: [ self unhighlight: element ]
]

{ #category : #util }
RTBlink >> set: element color: aColor [
	^ self class set: element color: aColor
]

{ #category : #util }
RTBlink >> unhighlight: element [
	^ self class unhighlight: element
]
