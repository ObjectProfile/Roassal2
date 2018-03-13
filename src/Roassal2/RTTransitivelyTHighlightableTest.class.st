Class {
	#name : #RTTransitivelyTHighlightableTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Core-Tests'
}

{ #category : #tests }
RTTransitivelyTHighlightableTest >> testBasicNoCycle [

	| v eb element allShapes |
	v := RTView new.
	v addAll: (RTBox elementsOn: (1 to: 3)).
	RTGridLayout on: v elements.
	
	eb := RTEdgeBuilder new.
	eb view: v.
	eb useAssociations: { 1 -> 2 . 2 -> 3 }.
	
	self assert: (v canvas shapes allSatisfy: [ :s | s color = RTShape defaultColor ]).
	element := v elementFromModel: 1.
	element @ (RTTransitivelyHighlightable new color: Color red).
	element announce: TRMouseEnter new.
	
	allShapes := v canvas shapes select: [ :s | s class == TRBoxShape ].
	self assert: (allShapes allSatisfy: [ :s | s color = Color red ]).
]

{ #category : #tests }
RTTransitivelyTHighlightableTest >> testBasicNoCycleAndIncoming [

	| v eb element allShapes |
	v := RTView new.
	v addAll: (RTBox elementsOn: (1 to: 3)).
	RTGridLayout on: v elements.
	
	eb := RTEdgeBuilder new.
	eb view: v.
	eb useAssociations: { 1 -> 2 . 2 -> 3 }.
	
	self assert: (v canvas shapes allSatisfy: [ :s | s color = RTShape defaultColor ]).
	element := v elementFromModel: 3.
	element @ (RTTransitivelyHighlightable new focusOnIncomingElements; color: Color red).
	element announce: TRMouseEnter new.
	
	allShapes := v canvas shapes select: [ :s | s class == TRBoxShape ].
	self assert: (allShapes allSatisfy: [ :s | s color = Color red ]).
]

{ #category : #tests }
RTTransitivelyTHighlightableTest >> testBasicWithCycle [

	| v eb element allShapes |
	v := RTView new.
	v addAll: (RTBox elementsOn: (1 to: 3)).
	RTGridLayout on: v elements.
	
	eb := RTEdgeBuilder new.
	eb view: v.
	eb useAssociations: { 1 -> 2 . 2 -> 3 . 3 -> 1}.
	
	self assert: (v canvas shapes allSatisfy: [ :s | s color = RTShape defaultColor ]).
	element := v elementFromModel: 1.
	element @ (RTTransitivelyHighlightable new color: Color red).
	element announce: TRMouseEnter new.
	
	allShapes := v canvas shapes select: [ :s | s class == TRBoxShape ].
	self assert: (allShapes allSatisfy: [ :s | s color = Color red ]).
]
