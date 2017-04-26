Class {
	#name : #RTDominanceTreeLayoutTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Layouts-Tests'
}

{ #category : #tests }
RTDominanceTreeLayoutTest >> testReverse [
	| v elements lineShape edge layout compositeShape |
	v := RTView new.
	elements := RTBox elementsOn: (1 to: 3).
	elements @ RTPopup.
	v addAll: elements.
	lineShape := RTArrowedLine new.
	edge := lineShape
		color: Color red;
		edgeFrom: elements first to: elements second.
	v add: edge.
	edge := lineShape
		color: Color red;
		edgeFrom: elements first to: elements third.
	v add: edge.
	layout := RTDominanceTreeLayout new.
	layout verticallyReverse.
	layout horizontallyReverse.
	layout on: elements.
	
	compositeShape := edge trachelShape.
	self assert: compositeShape class equals: TRCompositeShape.
	self assert: compositeShape shapes first class equals: TRLineShape.
	self assert: compositeShape shapes second class equals: TRSimpleArrowShape.
	self assert: compositeShape shapes second from equals: compositeShape shapes first from.
	self assert: compositeShape shapes second to equals: compositeShape shapes first to.
]
