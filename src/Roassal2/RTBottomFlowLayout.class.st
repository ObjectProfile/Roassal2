Class {
	#name : #RTBottomFlowLayout,
	#superclass : #RTAbstractFlowLayout,
	#category : #'Roassal2-Layouts'
}

{ #category : #hook }
RTBottomFlowLayout >> doExecute: nodeElements [ 
	| x y maxLastLineHeight lineHeights lineNumber |
	x := self gapSize.
	y := self gapSize.
	maxLastLineHeight := 0.
	lineHeights := OrderedCollection new.
	lineNumber := 1.
	nodeElements do: 
		[ :aNodeFigure | 
		x := x + aNodeFigure width + (2 * self gapSize).
		maxLastLineHeight := maxLastLineHeight max: aNodeFigure height.
		x > self maxWidth ifTrue: 
			[ lineHeights addLast: maxLastLineHeight.
			x := self gapSize.
			maxLastLineHeight := 0 ] ].
	lineHeights addLast: maxLastLineHeight.
	x := self gapSize.
	nodeElements do: 
		[ :aNodeFigure | 
		| lineHeight |
		lineHeight := lineHeights at: lineNumber.
		translator translate: aNodeFigure to: x @ (y + lineHeight - aNodeFigure height).
		x := x + aNodeFigure width + (2 * self gapSize).
		x > self maxWidth ifTrue: 
			[ x := self gapSize.
			y := y + (2 * self gapSize) + lineHeight.
			lineNumber := lineNumber + 1 ].
		self step ]
]
