Class {
	#name : #RTComposerTest,
	#superclass : #RTTest,
	#instVars : [
		'composer',
		'view'
	],
	#category : #'Roassal2-Builder-Composer'
}

{ #category : #running }
RTComposerTest >> setUp [
	super setUp.
	composer := RTComposer new.
	view := composer view
]

{ #category : #tests }
RTComposerTest >> testAbove [
	| e1 e2 |
	e1 := RTBox element.
	view add: e1.
	composer group: #first.
	self assert: e1 position equals: (0 @ 0).

	e2 := RTBox element.
	view add: e2.
	composer group: #second. 
	composer move: #second above: #first.

	self assert: e1 position equals: (0 @ 0).	
	self assert: e1 position x equals: e2 position x.
	self assert: e2 position y equals: -25.0.
]

{ #category : #tests }
RTComposerTest >> testBackground [

	| compo b group1 group2 |
	compo := RTComposer new.

	b := RTMondrian new.
	b view: compo view.
	group1 := b nodes: (1 to: 3).
	b build.
	compo group: #g1.

	b := RTMondrian new.
	b view: compo view.
	group2 := b nodes: (1 to: 4).
	b build.
	compo group: #g2. 

	compo layout: RTVerticalLineLayout new alignCenter.
	self assert: group1 center equals: 25 @ 3.
	self assert: group2 center equals: 25 @ 18.
	
	compo setBackgroundForGroup: #g1 color: Color red.
	self assert: group1 center equals: 25 @ 3.
	self assert: group2 center equals: 25 @ 18.
	
]

{ #category : #tests }
RTComposerTest >> testBelow [
	| e1 e2 |
	e1 := RTBox element.
	view add: e1.
	composer group: #first.
	self assert: e1 position equals: (0 @ 0).

	e2 := RTBox element.
	view add: e2.
	composer group: #second. 
	composer move: #second below: #first.

	self assert: e1 position equals: (0 @ 0).	
	self assert: e1 position x equals: e2 position x.
	self assert: e2 position y equals: 25.0.
]

{ #category : #tests }
RTComposerTest >> testGroup [

	| e |
	self assert: composer newElementsAsGroup isEmpty.
	self assert: composer allGroupedElements isEmpty.
	self assert: composer currentElementsAsGroup isEmpty.
	e := RTEllipse element.
	composer view add: e.
	
	self assert: composer allGroupedElements isEmpty.
	self assert: composer currentElementsAsGroup asArray equals: (Array with: e).
	self assert: composer newElementsAsGroup asArray equals: (Array with: e).
	composer group: #first.
		
	self assert: composer newElementsAsGroup isEmpty.
	self assert: composer allGroupedElements asArray equals: (Array with: e). 
]

{ #category : #tests }
RTComposerTest >> testOnTheLeftOf [
	| e1 e2 |
	e1 := RTBox element.
	view add: e1.
	composer group: #first.
	self assert: e1 position equals: (0 @ 0).

	e2 := RTBox element.
	view add: e2.
	composer group: #second. 
	composer move: #second onTheLeftOf: #first.

	self assert: e1 position equals: (0 @ 0).	
	self assert: e1 position y equals: e2 position y.
	self assert: e2 position x equals: -25.5.
]

{ #category : #tests }
RTComposerTest >> testOnTheRightOf [
	| e1 e2 |
	e1 := RTBox element.
	view add: e1.
	composer group: #first.
	self assert: e1 position equals: (0 @ 0).

	e2 := RTBox element.
	view add: e2.
	composer group: #second. 
	composer move: #second onTheRightOf: #first.

	self assert: e1 position equals: (0 @ 0).	
	self assert: e1 position y equals: e2 position y.
	self assert: e2 position x equals: 25.
]

{ #category : #tests }
RTComposerTest >> testPropagateHighlight [

	| e1 e2 e3 |
	e1 := (RTBox new color: Color gray) elementOn: 1.
	composer view add: e1.
	composer propagateHighlight. 
	composer group: #first.
	
	e2 := (RTEllipse new color: Color gray) elementOn: 1.
	composer view add: e2.
	composer group: #second.
	
	e3 := (RTBox new color: Color gray) elementOn: 1.
	composer view add: e3.
	composer propagateHighlight.
	composer group: #third.
	
	
	composer move: #second onTheRightOf: #first.
	composer move: #third onTheRightOf: #second.
	
	e1 announce: TRMouseEnter.
	self assert: e1 trachelShape color ~~ Color gray.
	self assert: e2 trachelShape color ~~ Color gray.
	self assert: e3 trachelShape color ~~ Color gray.
	e1 announce: TRMouseLeave.
	
	self assert: e1 trachelShape color == Color gray.
	self assert: e2 trachelShape color == Color gray.
	self assert: e3 trachelShape color == Color gray.

	e3 announce: TRMouseEnter.
	self assert: e1 trachelShape color ~~ Color gray.
	self assert: e2 trachelShape color ~~ Color gray.
	self assert: e3 trachelShape color ~~ Color gray.
	e3 announce: TRMouseLeave.

	e2 announce: TRMouseEnter.
	self assert: e1 trachelShape color == Color gray.
	self assert: e2 trachelShape color == Color gray.
	self assert: e3 trachelShape color == Color gray.
	e2 announce: TRMouseLeave.

]

{ #category : #tests }
RTComposerTest >> testopeningEmpty [

	composer open delete.
	self assert: composer gap > 0
]

{ #category : #tests }
RTComposerTest >> with0Arg [
	^ #metaObject
		run: #selector
		with: #()
		in: self
]
