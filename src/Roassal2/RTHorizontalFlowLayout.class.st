"
A RTHorizontalFlowLayout is a FlowLayout horizontaly arranged,  right queued at default.

"
Class {
	#name : #RTHorizontalFlowLayout,
	#superclass : #RTAbstractFlowLayout,
	#category : #'Roassal2-Layouts'
}

{ #category : #hook }
RTHorizontalFlowLayout >> doExecute: elements [ 
	| x y maxLastLineWidth nextElement maxNextLineWidth|
	x := self gapSize.
	y := self gapSize.
	maxLastLineWidth := 0.
	maxNextLineWidth := 0.
	nextElement := elements first.
	
	elements do:
		[ :anElement | 
		
		self isAlignBottom ifTrue: [ 
			translator translate: anElement to: ((x @ y) + ((anElement width / -2) @ (anElement height / 2))).
			(nextElement = elements last) ifFalse:  [nextElement := (elements after: anElement) ].
			y := y + anElement height + (2 * self gapSize).
			y > (self maxWidth rtValue: elements) ifTrue: 
				[ y := self gapSize.
				maxNextLineWidth := self maxNextLineWidthFrom: nextElement for: elements.
				x := x + (2 * self gapSize) + maxNextLineWidth.
				maxNextLineWidth := 0.
				maxLastLineWidth := 0.
				]
		].
	
	self isAlignCenter ifTrue: [ 
		translator translate: anElement to: ((x @ y) + (0 @ (anElement width / 2))).
			(nextElement = elements last) ifFalse:  [nextElement := (elements after: anElement) ].
			y := y + anElement height + (2 * self gapSize).
			maxLastLineWidth := maxLastLineWidth max: (anElement width).
			y > (self maxWidth rtValue: elements) ifTrue: 
				[ y := self gapSize.
				maxNextLineWidth := self maxNextLineWidthFrom: nextElement for: elements.
				x := x + (2 * self gapSize) + (maxNextLineWidth /2) + (maxLastLineWidth /2).
				maxNextLineWidth := 0.
				maxLastLineWidth := 0.
				]
			].	
			
		self isAlignTop ifTrue: [ 
			translator translateTopLeftOf: anElement to: x @ y.
			y := y + anElement height + (2 * self gapSize).
			maxLastLineWidth := maxLastLineWidth max: (anElement width ).
			y > (self maxWidth rtValue: elements) ifTrue: 
				[ y := self gapSize.
				x := x + (2 * self gapSize) + maxLastLineWidth.
				maxLastLineWidth := 0 ] 
			].
		].
]

{ #category : #'initialize-release' }
RTHorizontalFlowLayout >> initialize [
	super initialize.
	self alignTop.
]

{ #category : #'as yet unclassified' }
RTHorizontalFlowLayout >> maxNextLineWidthFrom: anElement for: elements [
	| nextLineY maxNextLineWidth |
	maxNextLineWidth := 0.
	nextLineY := self gapSize.
	[ nextLineY < (self maxWidth rtValue: elements) ] whileTrue: [
		nextLineY := nextLineY + (2 * self gapSize) + (anElement height).
		maxNextLineWidth := maxNextLineWidth max: (anElement width).	
		(anElement = elements last) ifFalse:  [anElement := (elements after: anElement)]
		].
	^ maxNextLineWidth
]
