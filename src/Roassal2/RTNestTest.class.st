Class {
	#name : #RTNestTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Core'
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
RTNestTest >> testChangeExtent [
	| view el innerElement1 innerElement2 
		elExtent elPosition extent1 extent2 position1 position2 ratio |
	view := RTView new.
	el := (RTBox new color: Color red) element.
	innerElement1 := (RTBox new size: 10) element.
	innerElement2 := (RTBox new size: 20) element.
	el translateTo: 100 @ 50.
	RTNest
		new 
		layout: RTGridLayout new;
		on: el nest: (Array with: innerElement1 with: innerElement2).
	view add: el; add: innerElement1; add: innerElement2.
	elExtent := el extent.
	elPosition := el position.
	extent1 := innerElement1 extent.
	extent2 := innerElement2 extent.
	position1 := innerElement1 position.
	position2 := innerElement2 position.
	ratio := 0.5.

	el extent: el extent * ratio.
	self assert: el position equals: (100 @ 50).
	self assert: el extent equals: elExtent * ratio.

	self assert: innerElement1 extent equals: extent1 * ratio.
	self assert: innerElement2 extent equals: extent2 * ratio.
	self assert: innerElement1 position equals: elPosition + ((position1 - elPosition) * ratio).
	self assert: innerElement2 position equals: elPosition + ((position2 - elPosition) * ratio).
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

	self assert: innerElement1 position y = 45.
	self assert: el position y = 50.
	self assert: innerElement2 position y = 50.
	self assert: 50 = el position y.
]

{ #category : #'composed shape' }
RTNestTest >> testDragAndDrop [
	| v shape es outer  inner |
	v := RTView new.
	shape := RTMultiCompositeShape new.
	shape add: RTBox new.
	shape add: RTBox new.
	
	es := shape elementsOn: #(1).
	v addAll: es.
	outer := es anyOne.
	
	RTNest new
		for: es
		inShape: #first
		add: [ :group :model | 
			inner := (RTBox new color: Color blue) elementOn: 'hello'.
			group add: inner ].
		
	self assert: outer position equals: 0 @ 5.0.
	self assert: inner position equals: 0 @ 0.	
		
	outer translateBy: 5 @ 5.
	self assert: outer position equals: 5 @ 10.0.
	self assert: inner position equals: 5 @ 5.	
	
	
	
]

{ #category : #'composed shape' }
RTNestTest >> testDragAndDrop2 [
	| v shape e inner |
	v := RTView new.
	shape := RTBox new.
	
	e := shape element.
	
	inner := (RTBox new color: Color blue) element.
	RTNest new on: e nest: (RTGroup with: inner).
		
	self assert: e position equals: 0 @ 0.
	self assert: inner position equals: 0 @ 0.	
		
	e translateBy: 5 @ 5.
	self assert: e position equals: 5 @ 5.
	self assert: inner position equals: 5 @ 5
]

{ #category : #'composed shape' }
RTNestTest >> testDragAndDropWithoutComposite [
	| v shape es outer  inner |
	v := RTView new.
	shape := RTBox new.
	
	es := shape elementsOn: #(1).
	v addAll: es.
	outer := es anyOne.
	
	RTNest new
		for: es
		add: [ :group :model | 
			inner := (RTBox new color: Color blue) elementOn: 'hello'.
			group add: inner ].
		
	self assert: outer position equals: 0 @ 0.
	self assert: inner position equals: 0 @ 0.	
		
	outer translateBy: 5 @ 5.
	self assert: outer position equals: 5 @ 5.
	self assert: inner position equals: 5 @ 5.	
	
	
	
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
RTNestTest >> testForAdd [

	| v es positions |
	v := RTView new.
	es := RTBox elementsOn: (1 to: 5).
	v addAll: es.
	es @ RTDraggable.

	RTNest new
		for: es
		add: [ :group :model | 
			group addAll: ((RTBox new color: Color blue) elementsOn: (1 to: model)).
			RTGridLayout on: group.
		].

	RTGridLayout on: es.
	
	positions := 
((Array new: 20) at: 1 put: ((7.5@7.5)); at: 2 put: ((32.5@7.5)); at: 3 put: ((62.5@12.5)); at: 4 put: ((12.5@42.5)); at: 5 put: ((47.5@42.5)); at: 6 put: ((8.0@8.0)); at: 7 put: ((28.0@8.0)); at: 8 put: ((38.0@8.0)); at: 9 put: ((58.0@8.0)); at: 10 put: ((68.0@8.0)); at: 11 put: ((58.0@18.0)); at: 12 put: ((8.0@38.0)); at: 13 put: ((18.0@38.0)); at: 14 put: ((8.0@48.0)); at: 15 put: ((18.0@48.0)); at: 16 put: ((38.0@38.0)); at: 17 put: ((48.0@38.0)); at: 18 put: ((58.0@38.0)); at: 19 put: ((38.0@48.0)); at: 20 put: ((48.0@48.0)); yourself).
	self assert: (v elements collect: #position) asArray equals: positions
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

	self assert: el1 position equals: (0.5@ (-25/2)).	
	self assert: el2 position equals: (0.5@(25/2)).
	self assert: host position equals: (0@0).
]

{ #category : #'composed shape' }
RTNestTest >> testInnerElement1 [

	| v shape e innerBox innerElement |
	v := RTView new.

	shape := RTMultiCompositeShape new.
	shape add: (RTBox new size: 20; color: (Color green alpha: 0.3)).
	shape add: (RTBox new size: 20; color: (Color blue alpha: 0.3)) translateBy: 0 @ 20.

	e := shape elementOn: 1.
	v add: e.

	innerBox := RTBox new size: 10; color: (Color red alpha: 0.9).
	innerElement := innerBox elementOn: 2.
	v add: innerElement.

	RTNest new
		onTrachelShape: e trachelShape shapes second nest: (Array with: innerElement).  

	self assert: innerElement position equals: 0 @ 10
]

{ #category : #'composed shape' }
RTNestTest >> testInnerElement2 [

	| v shape e innerBox innerElements |
	v := RTView new.
	
	shape := RTMultiCompositeShape new.
	shape add: (RTBox new size: 20; color: (Color green alpha: 0.3)).
	shape add: (RTBox new size: 20; color: (Color blue alpha: 0.3)) translateBy: 0 @ 20.

	e := shape elementOn: 1.
	v add: e.

	innerBox := RTBox new size: 10; color: (Color red alpha: 0.9).
	innerElements := innerBox elementsOn: #(2 3).
	v addAll: innerElements.
	RTGridLayout on: innerElements.

	RTNest new
		onTrachelShape: e trachelShape shapes second nest: innerElements.  

	self assert: (innerElements collect: #position) asArray equals: (Array with: (-7.0@10.0) with: (8.0@10.0))
]

{ #category : #'composed shape' }
RTNestTest >> testInnerElement3 [

	| v shape e innerBox innerElements |

	v := RTView new.

	shape := RTMultiCompositeShape new.
	shape add: (RTBox new size: 20; color: (Color green alpha: 0.3)).
	shape add: (RTBox new size: 20; color: (Color blue alpha: 0.3)) translateBy: 0 @ 20.

	e := shape elementOn: 1.

	innerBox := RTBox new size: 10; color: (Color red alpha: 0.9).
	innerElements := innerBox elementsOn: #(2 3).
	
	RTVerticalLineLayout on: innerElements.

	RTNest new
		onTrachelShape: e trachelShape shapes second nest: innerElements.  

	e trachelShape vertical.
	
	v add: e.
	v addAll: innerElements.
	
	self assert: (innerElements collect: #position) asArray equals: (Array with: (0 @ 5.0) with: (0 @ 25.0))
]

{ #category : #'multi line' }
RTNestTest >> testMultiline [


	| v b e |
	v := RTView new.
	b := (RTBox new color: (Color red alpha: 0.3)) element.
	e := RTLabel elementOn: 'Hello
	World
	Bonjour
	Blah
	'.
	v add: b.
	v add: e.

	RTNest new on: b nest: (Array with: e).

	self assert: (RTNest new encompassingRectangleOf: (Array with: e)) extent equals: e encompassingRectangle extent.
	
	"This has to be fixed."
	"self assert: (b encompassingRectangle extent) equals: (e encompassingRectangle extent + (10 @ 10)) "
]

{ #category : #'multi line' }
RTNestTest >> testMultiline02 [


	| v b e |
	v := RTView new.
	b := (RTBox new color: (Color red alpha: 0.3)) element.
	e := RTLabel elementOn: 'Hello
	World
	Bonjour
	Blah
	'.
	v add: b.
	v add: e.

	RTNest new on: b nest: (Array with: e).

	self assert: (RTNest new encompassingRectangleOf: (Array with: e)) extent equals: e encompassingRectangle extent.
	
	"This has to be fixed"
	"self assert: (b encompassingRectangle extent) equals: (e encompassingRectangle extent + (10 @ 10))" 
]

{ #category : #'multi line' }
RTNestTest >> testMultiline03 [


	| v b e |
	v := RTView new.
	b := (RTBox new color: (Color red alpha: 0.3)) element.
	e := RTLabel elementOn: 'Hello
	World
	Bonjour
	Blah
	'.

	RTNest new on: b nest: (Array with: e).

	self assert: (RTNest new encompassingRectangleOf: (Array with: e)) extent equals: e encompassingRectangle extent.
	"self assert: (b encompassingRectangle extent) equals: (e encompassingRectangle extent + (10 @ 10)) "
]

{ #category : #'multi line' }
RTNestTest >> testMultiline04 [


	| v b e |
	v := RTView new.
	b := (RTBox new color: (Color red alpha: 0.3)) element.
	e := RTLabel elementOn: 'Hello
	World
	Bonjour
	Blah
	'.

	RTNest new on: b nest: (Array with: e).
	v add: b.
	v add: e.
	
	self assert: (RTNest new encompassingRectangleOf: (Array with: e)) extent equals: e encompassingRectangle extent.
	"self assert: (b encompassingRectangle extent) equals: (e encompassingRectangle extent + (10 @ 10)) "
]

{ #category : #tests }
RTNestTest >> testResizableInnerNode [
	"If we resize an inner node, the outter node should be resized"
	| outter inner |
	outter := RTBox element.
	inner := (RTBox new color: Color blue) element.

	self deny: inner trachelShape hasCallback.
	self deny: outter trachelShape hasCallback.
	RTNest new 
		onResizable: outter nest: (Array with: inner).
"	self deny: outter trachelShape hasCallback."
	self assert: inner trachelShape hasCallback.
	
	self assert: outter encompassingRectangle extent = (15 @ 15).
	self assert: inner encompassingRectangle extent = (5 @ 5).
	
	inner extent: 10 @ 10.
	self assert: inner encompassingRectangle extent = (10 @ 10).
	self assert: outter encompassingRectangle extent = (20 @ 20).
	

]

{ #category : #tests }
RTNestTest >> testResizableInnerNodeAndTranslateInnerNode [
	"If we resize an inner node, the outter node should be resized"
	| outter inner |
	outter := RTBox element.
	inner := (RTBox new color: Color blue) element.

	self deny: inner trachelShape hasCallback.
	self deny: outter trachelShape hasCallback.
	RTNest new 
		onResizable: outter nest: (Array with: inner).

	self assert: inner trachelShape hasCallback.
	
	self assert: outter encompassingRectangle extent = (15 @ 15).
	self assert: inner encompassingRectangle extent = (5 @ 5).

	inner translateBy: 5 @ 5.
	self assert: inner encompassingRectangle extent = (5 @ 5).
	self assert: outter encompassingRectangle extent = (15 @ 15).
	

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
	self assert: inner position = ((1 / 2) @ (1 / 2)).

	el translateTo: 100 @ 50.
	self assert: el position = (100 @ 50).
	self assert: inner position =  ((201/2)@(101/2)).

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
	innerElement2 := shape element.
	
	view add: innerElement.
	view add: innerElement2.
	
	RTNest
		new 
		layout: RTGridLayout new;
		on: el nest: (Array with: innerElement with: innerElement2).
		
	view add: el.
	
	self assert: el position = (100 @ 50).

	self assert: el trachelShape width = 25.
	self assert: el trachelShape height = 15.
	
	self assert: (innerElement2 position - innerElement position) = (10 @ 0) 
	
]
