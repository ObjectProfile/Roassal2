"
A ROAbstractPopupTest is xxxxxxxxx.

Instance Variables
	popup:		<Object>
	view:		<Object>

popup
	- xxxxx

view
	- xxxxx

"
Class {
	#name : #RTPopupTest,
	#superclass : #RTTest,
	#instVars : [
		'view',
		'popup'
	],
	#category : #'Roassal2-Core'
}

{ #category : #running }
RTPopupTest >> setUp [
	super setUp.
	view := RTView new.
]

{ #category : #tests }
RTPopupTest >> test [
	| el |
	el := RTElement on: 123.
	el + RTBox.
	el @ RTPopup.

	view add: el.	
	
	self assert: el view == view.
	
	self assert: view numberOfElements = 1.
	el announce: TRMouseEnter.
	self assert: view numberOfElements = 2.
	el announce: TRMouseLeave.
	self assert: view numberOfElements = 1.
]
