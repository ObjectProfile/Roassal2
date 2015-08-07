Class {
	#name : #RTTreeLayoutTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Layouts-Tests'
}

{ #category : #tests }
RTTreeLayoutTest >> testAddingAttachPoint [
	| v es lineShape l |
	v := RTView new.
	es := RTBox elementsOn: (1 to: 2).
	v addAll: es.
	lineShape := RTLine new.
	l := lineShape edgeFrom: es first to: es second.
	v add: l.
	
	self assert: lineShape attachPoint class equals: RTCenteredAttachPoint.
	RTHorizontalTreeLayout on: es.
	self assert: lineShape attachPoint class equals: RTHorizontalAttachPoint.
]

{ #category : #tests }
RTTreeLayoutTest >> testAddingAttachPointOnVertical [
	| v es lineShape l |
	v := RTView new.
	es := RTBox elementsOn: (1 to: 2).
	v addAll: es.
	lineShape := RTLine new.
	l := lineShape edgeFrom: es first to: es second.
	v add: l.
	
	self assert: lineShape attachPoint class equals: RTCenteredAttachPoint.
	RTTreeLayout on: es.
	self assert: lineShape attachPoint class equals: RTVerticalAttachPoint.
]

{ #category : #tests }
RTTreeLayoutTest >> testBasic [
	| layout |
	layout := RTTreeLayout new.
	self assert: layout shouldSetDefaultAttachPoint.
	layout doNotAttachPoint.
	self deny: layout shouldSetDefaultAttachPoint.
]
