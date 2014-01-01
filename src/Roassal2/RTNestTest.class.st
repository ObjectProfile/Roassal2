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
	
	self assert: el position asIntegerPoint = (100 @ 50).
	self assert: el2 position asIntegerPoint = (100 @ 50).

	self assert: el trachelShape width = 15.
	self assert: el trachelShape height = 15.
	
	self assert: el2 trachelShape width = 5.
	self assert: el2 trachelShape height = 5.
]

{ #category : #tests }
RTNestTest >> testDifferentSizes [
	| view el innerElement1 innerElement2 |
	view := RTView new.
	el := (RTBox new color: Color red) element.
	innerElement1 := (RTBox new size: 10) element.
	innerElement2 := (RTBox new size: 20) element.
	el translateTo: 100 @ 50.
	RTNest
		new 
		layout: RTGridLayout new;
		on: el nest: (Array with: innerElement1 with: innerElement2).

	view add: el.
	view add: innerElement1.
	view add: innerElement2.

	self assert: el position = (100 @ 50).
	self assert: el trachelShape width = 45.
	self assert: el trachelShape height = 30.

	self assert: innerElement1 position y = el position y.
	self assert: innerElement2 position y = el position y.
]

{ #category : #encompassing }
RTNestTest >> testEncompassingRectangle [

	| e1 e2 r |
	e1 := (RTBox new size: 10) element.
	e2 := (RTBox new size: 30) element.
	
	r := RTNest new encompassingRectangleOf: (Array with: e1 with: e2).
	self assert: r = ((-15 @ -15) extent: (30 @ 30))
]

{ #category : #encompassing }
RTNestTest >> testEncompassingRectangle2 [

	| e1 e2 r |
	e1 := (RTBox new size: 10) element.
	e2 := (RTBox new size: 30) element.
	e2 translateTo: (100 @ 80).
	r := RTNest new encompassingRectangleOf: (Array with: e1 with: e2).
	self assert: r = ((-5 @ -5) corner: (115 @ 95))
]

{ #category : #tests }
RTNestTest >> testInner [

	| view host el1 el2 edge |
	view := RTView new.
	host := (RTBox new color: (Color purple alpha: 0.5)) element.
	el1 := RTBox element. 
	el2 := RTBox element.
	edge := RTLine edgeFrom: el1 to: el2.
	view add: host; add: el1; add: el2; add: edge.

	RTTreeLayout new on: (Array with: el1 with: el2) edges: view edges.
	RTNest new on: host nest: (Array with: el1 with: el2).

	self assert: el1 position = (0.0@ -12).	
	self assert: el2 position = (0.0@13).
	self assert: host position = (0@0).
]

{ #category : #tests }
RTNestTest >> testSimpleExample [

	| view el shape inner |
	view := RTView new.
	el := (RTBox new color: (Color purple alpha: 0.3)) element.
	
	shape := RTBox new color: (Color purple alpha: 0.3).
	inner := (shape elementOn: #inner).

	view add: el.
	view add: inner.

	RTNest
		new 
		layout: RTGridLayout new;
		on: el nest: (Array with: inner).

	self assert: el position = (0 @ 0).
	self assert: inner position = (0 @ 0).

	el translateTo: 100 @ 50.
	self assert: el position = (100 @ 50).
	self assert: inner position = (100 @ 50).

	self assert: el trachelShape hasCallback.

	"This may change later"
	self deny: inner trachelShape hasCallback.
	
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
