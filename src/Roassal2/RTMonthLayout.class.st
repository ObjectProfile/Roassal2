"
This is a specific layout for month in RTCalendarBuilder
"
Class {
	#name : #RTMonthLayout,
	#superclass : #RTLayout,
	#instVars : [
		'gapSize'
	],
	#category : #'Roassal2-Builder-Calendar'
}

{ #category : #hook }
RTMonthLayout >> doExecute: elements [
	| prevWeek index first cellSize |
	first := elements first.
	prevWeek := first model weeks last.
	cellSize := first height / first model weeks size.
	index := 0.
	elements do: [ :e | | month |
		month := e model.
		"(prevWeek = month weeks first) ifTrue: [ index := index -1 ]."
		self flag: 'Need review this part'.
		index := index + month weeks size.
		prevWeek := month weeks last.
		e translateTo: 0@ ((index * cellSize)).
		 ].
	
]

{ #category : #accessing }
RTMonthLayout >> gapSize [
	^ gapSize
]

{ #category : #accessing }
RTMonthLayout >> gapSize: anObject [
	gapSize := anObject
]

{ #category : #'initialize-release' }
RTMonthLayout >> initialize [
	super initialize.
	self gapSize: 1
]
