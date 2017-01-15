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
RTTreeLayoutTest >> testAttachPoint [
	| v es edge |
	v := RTView new.
	es := RTBox new size: 10; elementsOn: #(1 2).
	v addAll: es.
	edge := RTLine new color: Color red; edgeFrom: es first to: es second.
	v add: edge.

	RTTreeLayout on: es.

	self assert: edge trachelShape from equals: 10 @ 15.
	self assert: edge trachelShape to equals: 10 @ 35.
]

{ #category : #tests }
RTTreeLayoutTest >> testAttachPointNo [
	| v es edge |
	v := RTView new.
	es := RTBox new size: 10; elementsOn: #(1 2).
	v addAll: es.
	edge := RTLine new color: Color red; edgeFrom: es first to: es second.
	v add: edge.

	RTTreeLayout new doNotAttachPoint; on: es.

	self assert: edge trachelShape from equals: es first center.
	self assert: edge trachelShape to equals: es second center
]

{ #category : #tests }
RTTreeLayoutTest >> testBasic [
	| layout |
	layout := RTTreeLayout new.
	self assert: layout shouldSetDefaultAttachPoint.
	layout doNotAttachPoint.
	self deny: layout shouldSetDefaultAttachPoint.
]

{ #category : #tests }
RTTreeLayoutTest >> testNotAddingAttachPoint [
	| v es lineShape l |
	v := RTView new.
	es := RTBox elementsOn: (1 to: 2).
	v addAll: es.
	lineShape := RTLine new.
	l := lineShape edgeFrom: es first to: es second.
	v add: l.

	self assert: lineShape attachPoint class equals: RTCenteredAttachPoint.
	RTHorizontalTreeLayout new
		doNotAttachPoint;
		on: es.
	self assert: lineShape attachPoint class equals: RTCenteredAttachPoint
]
