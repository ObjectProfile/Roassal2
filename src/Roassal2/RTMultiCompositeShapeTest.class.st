Class {
	#name : #RTMultiCompositeShapeTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Core'
}

{ #category : #tests }
RTMultiCompositeShapeTest >> testColor [

	| v box s e |
	v := RTView new.
	box := RTBox new.
	s := RTMultiCompositeShape new.
	s add: box.
	s color: Color red.
	e := s element.
	v add: e.
	
	self assert: e trachelShape shapes first color equals: Color red
]

{ #category : #tests }
RTMultiCompositeShapeTest >> testSetColorOnEmpty [

	self should: [ RTMultiCompositeShape new color: Color blue ] raise: Error
]

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

{ #category : #tests }
RTMultiCompositeShapeTest >> testVerticalLayoutAndTranslation [

	| v s e positions b1 b2 tb1 tb2 |
	v := RTView new.
	b1 := RTBox new color: Color red; size: 16.
	b2 := RTBox new color: Color blue; size: 16.
	s := RTMultiCompositeShape new.
	s add: b1.
	s add: b2.
	s vertical.

	e := s element.
	v add: e @ RTDraggable.
	
	self assert: (e trachelShape offsets asArray) equals: (Array with: (0@0) with: (0@16.0)).

	tb1 := e trachelShape shapes first.
	tb2 := e trachelShape shapes second.
	self assert: (e trachelShape offsetOf: tb1) equals: 0 @ 0.
	self assert: (e trachelShape offsetOf: tb2) equals: 0 @ 16.0.

	positions := (e trachelShape shapes collect: #position) asArray.	
	self assert: positions equals: (Array with: (0@0) with: (0@16.0)).

	e translateTo: 0 @ 0.
	
	positions := (e trachelShape shapes collect: #position) asArray.
	self assert: positions equals: (Array with: (0@0) with: (0@16.0)).
	
]
