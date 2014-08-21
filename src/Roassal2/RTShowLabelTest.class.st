"
A RTShowLabelTest is a test class for testing the behavior of RTShowLabel
"
Class {
	#name : #RTShowLabelTest,
	#superclass : #TestCase,
	#instVars : [
		'box',
		'view'
	],
	#category : #'Roassal2-Tests'
}

{ #category : #tests }
RTShowLabelTest >> testBasic [
	view := RTView new.
	box := RTBox new size: 30; elementOn: 'Hi'.
	view add: box.
	self assert: view canvas shapes size equals: 1.

	box @ RTShowLabel.
	self assert: view canvas shapes size equals: 1.

	box testCaseAnnounce: TRMouseEnter.
	self assert: view canvas shapes size equals: 2.
	
	box testCaseAnnounce: TRMouseLeave.
	self assert: view canvas shapes size equals: 1.

]
