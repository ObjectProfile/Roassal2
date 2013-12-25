Class {
	#name : #RTNestTest,
	#superclass : #RTTest,
	#category : #Roassal2
}

{ #category : #tests }
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

	self assert: el trachelShape width = 15.
	self assert: el trachelShape height = 15.
	
	self assert: el2 trachelShape width = 5.
	self assert: el2 trachelShape height = 5.
]

{ #category : #tests }
RTNestTest >> testDefault [

	self assert: RTNest new layout class = RTHorizontalLineLayout
	 
]

{ #category : #tests }
RTNestTest >> testWithTwoInnerNodes [

	| view el shape innerElement innerElement2 |
	view := RTView new.
	el := (RTBox new width: 80; height: 40; color: (Color purple alpha: 0.3)) element.
	el translateTo: 100 @ 50.
	shape := RTBox new color: (Color red alpha: 0.3).
	innerElement := shape element.
	innerElement2  := shape element.
	
	view add: innerElement.
	view add: innerElement2.
	
	RTNest
		new 
		layout: RTGridLayout new;
		on: el nest: (Array with: innerElement with: innerElement2).
		
	view add: el.
	
	self assert: el position = (100 @ 50).

	self assert: el trachelShape width = 30.
	self assert: el trachelShape height = 15.
	
	self assert: (innerElement2 position - innerElement position) = (15 @ 0) 
	
]
