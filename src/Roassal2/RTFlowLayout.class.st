Class {
	#name : #RTFlowLayout,
	#superclass : #RTAbstractFlowLayout,
	#instVars : [
		'alignment'
	],
	#category : #'Roassal2-Layouts'
}

{ #category : #alignment }
RTFlowLayout >> alignBottom [
	alignment := #bottom
]

{ #category : #alignment }
RTFlowLayout >> alignCenter [
	alignment := #center
]

{ #category : #alignment }
RTFlowLayout >> alignTop [
	alignment := #top
]

{ #category : #hook }
RTFlowLayout >> doExecute: elements [ 
	| x y maxLastLineHeight |
	x := self gapSize.
	y := self gapSize.
	maxLastLineHeight := 0.
	elements do: 
		[ :anElement | 
		self isAlignTop ifTrue: [ translator translateTopLeftOf: anElement to: x @ y ].
		self isAlignCenter ifTrue: [ translator translateCenterLeftOf: anElement to: x @ y ].
		self isAlignBottom ifTrue: [ translator translateBottomLeftOf: anElement to: x @ y ].
		
		x := x + anElement width + (2 * self gapSize).
		maxLastLineHeight := maxLastLineHeight max: (anElement height ).
		x > self maxWidth ifTrue: 
			[ x := self gapSize.
			y := y + (2 * self gapSize) + maxLastLineHeight.
			maxLastLineHeight := 0 ] ]
]

{ #category : #'initialize-release' }
RTFlowLayout >> initialize [
	super initialize.
	self alignTop
]

{ #category : #testing }
RTFlowLayout >> isAlignBottom [
	^ alignment = #bottom
]

{ #category : #testing }
RTFlowLayout >> isAlignCenter [
	^ alignment = #center
]

{ #category : #testing }
RTFlowLayout >> isAlignTop [
	^ alignment = #top
]
