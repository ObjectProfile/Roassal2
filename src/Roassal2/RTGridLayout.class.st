"
A ROGridLayout places elements as a grid.

Instance Variables
	gapSize:		<SmallInteger>
	lineItemsCountBlock:		<BlockContext>

gapSize
	- number of pixels between each elements, horizontally and vertically

lineItemsCountBlock
	- tells the amount of item per line should be used

"
Class {
	#name : #RTGridLayout,
	#superclass : #RTAbstractGridLayout,
	#category : #'Roassal2-Layouts'
}

{ #category : #hook }
RTGridLayout >> doExecute: elements [
	| pointer lineItemCount lineItemSize maxLastLineHeight originalGapLeft originalGapTop |
	originalGapLeft := self paddingLeftFor: elements.
	originalGapTop := self paddingTopFor: elements.
	
	pointer := originalGapLeft @ originalGapTop.
	lineItemSize := self lineItemsCountBlock roValue: elements.
	lineItemCount := 0.
	maxLastLineHeight := 0.
	elements
		do: [ :element | 
			translator translate: element to: (pointer "+ ((element width / 2) @ 0)" ).
			pointer := (pointer x + (element width) + (self gapSize * 2)) @ pointer y.
			lineItemCount := lineItemCount + 1.
			maxLastLineHeight := maxLastLineHeight max: element height.
			lineItemCount >= lineItemSize
				ifTrue: [ 
					pointer := originalGapLeft @ (pointer y + (self gapSize * 2) + maxLastLineHeight).
					
					maxLastLineHeight := 0.
					lineItemCount := 0 ].
			self step ].

]
