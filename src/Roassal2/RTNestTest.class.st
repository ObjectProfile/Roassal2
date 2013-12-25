Class {
	#name : #RTNestTest,
	#superclass : #RTTest,
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTNestTest >> testBasic [
	| view el el2 |
	view := RTView new.
	el := (RTBox new color: Color red) element.
	el2 := RTBox element.
	el translateTo: 100 @ 50.
	RTNest
		new 
		layout: RTGridLayout new;
		on: el nest: (Array with: el2).

	view add: el.
	view add: el2.
	
	self assert: el position = (100 @ 50).
	self assert: el2 position = (100 @ 50).

	self assert: el shape width = 15.
	self assert: el shape height = 15.
	
	self assert: el2 shape width = 5.
	self assert: el2 shape height = 5.
]

{ #category : #'as yet unclassified' }
RTNestTest >> testDefault [

	self assert: RTNest new layout class = RTHorizontalLineLayout
	 
]
