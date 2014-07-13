Class {
	#name : #RTMultiCompositeShapeTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Core'
}

{ #category : #tests }
RTMultiCompositeShapeTest >> testTranslationBy [

	| view shape el ps ps2 |
	view := RTView new.
	shape := RTMultiCompositeShape new.
	shape add: (RTBox new color: Color blue; height: 20; width: 15).
	shape add: (RTBox new color: Color white; height: 20; width: 15) translateBy: 15 @ 0.
	shape add: (RTBox new color: Color red; height: 20; width: 15) translateBy: 30 @ 0.

	el := shape element.
	el @ RTDraggable.
	view add: el.

	self assert: view canvas numberOfShapes equals: 3.
	self assert: el shape class equals: RTMultiCompositeShape.
	
	ps := view canvas shapes collect: #position.
	self assert: ps equals: (Array with: (0@0) with: (15@0) with: (30@0)).
	
	el translateBy: 10 @ 5.
	ps2 := view canvas shapes collect: #position.
	self assert: ps2 equals: (ps + (10 @ 5)).
]

{ #category : #tests }
RTMultiCompositeShapeTest >> testTranslationTo [

	| view shape el ps ps2 |
	view := RTView new.
	shape := RTMultiCompositeShape new.
	shape add: (RTBox new color: Color blue; height: 20; width: 15).
	shape add: (RTBox new color: Color white; height: 20; width: 15) translateBy: 15 @ 0.
	shape add: (RTBox new color: Color red; height: 20; width: 15) translateBy: 30 @ 0.

	el := shape element.
	el @ RTDraggable.
	view add: el.

	self assert: view canvas numberOfShapes equals: 3.
	self assert: el shape class equals: RTMultiCompositeShape.
	
	ps := view canvas shapes collect: #position.
	self assert: ps equals: (Array with: (0@0) with: (15@0) with: (30@0)).

	el translateTo: 10 @ 5.
	ps2 := view canvas shapes collect: #position.
	self assert: ps2 equals: (ps + (10 @ 5)).
]
