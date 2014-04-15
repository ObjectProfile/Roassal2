Class {
	#name : #RTFlowLayout,
	#superclass : #RTAbstractFlowLayout,
	#category : #'Roassal2-Layouts'
}

{ #category : #hook }
RTFlowLayout >> doExecute: elements [ 
	| x y maxLastLineHeight |
	x := self gapSize.
	y := self gapSize.
	maxLastLineHeight := 0.
	elements do: 
		[ :anElement | 
		translator translateTopLeftOf: anElement to: x @ y.
		x := x + anElement width + (2 * self gapSize).
		maxLastLineHeight := maxLastLineHeight max: anElement height.
		x > self maxWidth ifTrue: 
			[ x := self gapSize.
			y := y + (2 * self gapSize) + maxLastLineHeight.
			maxLastLineHeight := 0 ] ]
]
