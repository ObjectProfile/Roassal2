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
	#category : #'Roassal2-Core-Tests'
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
RTPopupTest >> testPopup [

	| v es |
	v := RTView new.

	es := RTLabel elementsOn: (1 to: 10).

	v addAll: es.

	es @ (RTPopup new 
		named: #yourself
		background: Color blue
		group: [ :group :el |  
	 
			group addAll: (RTEllipse elementsOn: (1 to: el model)).
			RTWeightedCircleLayout new
				initialRadius: 50;
				on: group.
			]).

	RTHorizontalLineLayout on: es.
	
	es first announce: TRMouseEnter new
]

{ #category : #'multi lines' }
RTPopupTest >> testWithMultiLine [
	| v e p |
	v := RTView new.

	e := (RTBox new size: 40) elementOn: 'Hello
	World
	Bonjour
	Blah'.

	v add: e.

	self assert: v numberOfElements equals: 1.
	self assert: v canvas numberOfShapes equals: 1.
	self assert: v canvas numberOfFixedShapes equals: 0.

	p := RTPopup new.
	p createAndShowPopupFor: e event: TRMouseEnter new.
	
	self assert: v numberOfElements = 3.
	self assert: v canvas numberOfShapes = 1.
	self assert: v canvas numberOfFixedShapes = 5.

]

{ #category : #'multi lines' }
RTPopupTest >> testWithMultiLine02 [
	| v e  |
	v := RTView new.

	e := (RTBox new size: 40) elementOn: 'Hello
	World
	Bonjour
	Blah'.

	v add: e.
	e @ RTPopup.
	RTPopup resetLastPopup.
	
	"Entering"
	e announcer announce: TRMouseEnter new.
	self assert: v numberOfElements equals: 3.
	self assert: v canvas numberOfShapes equals: 1.
	self assert: v canvas numberOfFixedShapes equals: 5.

	"Leaving"
	e announcer announce: TRMouseLeave new.
	self assert: v numberOfElements equals: 1.
	self assert: v canvas numberOfShapes equals: 1.
	self assert: v canvas numberOfFixedShapes equals: 0.

	
	
]

{ #category : #'multi lines' }
RTPopupTest >> testWithMultiLine03 [
	| v e  p |
	v := RTView new.

	e := (RTBox new size: 40) elementOn: 'Hello
	World
	Bonjour
	Blah'.

	v add: e.
	e @ RTPopup.
	RTPopup resetLastPopup.
	
	"Entering"
	p := RTPopup new.
	p createAndShowPopupFor: e event: TRMouseEnter new.
	self assert: v numberOfElements equals: 3.
	self assert: v canvas numberOfShapes equals: 1.
	self assert: v canvas numberOfFixedShapes equals: 5.

	"Leaving"
	p removeLastPopup.

	self assert: v numberOfElements equals: 1.
	self assert: v canvas numberOfShapes equals: 1.
	self assert: v canvas numberOfFixedShapes equals: 0.

	
	
]

{ #category : #'multi lines' }
RTPopupTest >> testWithMultiLine04 [
	| v e  p secondElement firstElement |
	v := RTView new.

	e := (RTBox new size: 40) elementOn: 'Hello
	World
	Bonjour
	Blah'.

	v add: e.
	e @ RTPopup.
	
	"Entering"
	p := RTPopup new.
	RTPopup resetLastPopup.
	p createAndShowPopupFor: e event: TRMouseEnter new.
	self assert: v numberOfElements equals: 3.
	self assert: v canvas numberOfShapes equals: 1.
	self assert: v canvas numberOfFixedShapes equals: 5.

	"Leaving"
	firstElement := RTPopup lastPopup first.
	secondElement := RTPopup lastPopup second.
	self assert: secondElement shape class equals: RTLabel.
	self deny: secondElement isFixed.
	firstElement remove.
	secondElement remove.

	self assert: v numberOfElements equals: 1.
	self assert: v canvas numberOfShapes equals: 1.
	self assert: v canvas numberOfFixedShapes equals: 0.

	
	
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
	RTPopup resetLastPopup.
	p createAndShowPopupFor: e event: TRMouseEnter new.
	
	self assert: v numberOfElements = 3.
	self assert: v canvas numberOfShapes = 1.
	self assert: v canvas numberOfFixedShapes = 2.

]

{ #category : #tests }
RTPopupTest >> testWithSymbol [

	| v e p |
	v := RTView new.
	e := (RTBox new size: 40) elementOn: #symbol.
	v add: e.

	self assert: v numberOfElements = 1.
	self assert: v canvas numberOfShapes = 1.

	p := RTPopup new.
	p createAndShowPopupFor: e event: TRMouseEnter new.
	
	self assert: v numberOfElements = 3.
	self assert: v canvas numberOfShapes = 1.
	self assert: v canvas numberOfFixedShapes = 2.

]
