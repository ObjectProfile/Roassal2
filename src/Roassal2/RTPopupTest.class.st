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
	#category : 'Roassal2-Core'
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
	self assert: view numberOfElements = 3.
	el announce: TRMouseLeave.
	self assert: view numberOfElements = 1.
]

{ #category : #tests }
RTPopupTest >> testWithMultiLine [


	| v e p |
	v := RTView new.

	e := (RTBox new size: 40) elementOn: 'Hello
	World
	Bonjour
	Blah'.

	v add: e.

	self assert: v numberOfElements = 1.
	self assert: v canvas numberOfShapes = 1.

	p := RTPopup new.
	p createAndShowPopupFor: e event: TRMouseEnter new.
	
	self assert: v numberOfElements = 3.
	self assert: v canvas numberOfShapes = 1.
	self assert: v canvas numberOfFixedShapes = 5.

]

{ #category : #tests }
RTPopupTest >> testWithOneLine [


	| v e p |
	v := RTView new.

	e := (RTBox new size: 40) elementOn: 'Hello'.

	v add: e.

	self assert: v numberOfElements = 1.
	self assert: v canvas numberOfShapes = 1.

	p := RTPopup new.
	p createAndShowPopupFor: e event: TRMouseEnter new.
	
	self assert: v numberOfElements = 3.
	self assert: v canvas numberOfShapes = 1.
	self assert: v canvas numberOfFixedShapes = 2.

]
