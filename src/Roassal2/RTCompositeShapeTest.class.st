Class {
	#name : #RTCompositeShapeTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Core'
}

{ #category : #'label size' }
RTCompositeShapeTest >> testLabelSize [
	| v s1 s2 c labels |
	v := RTView new.

	s1 := (RTEllipse new size: #yourself; color: (Color blue alpha: 0.4)).
	s2 := (RTLabel new text: 'Hello World'; height: 10).

	c := RTCompositeShape new 
			shape1: s1; 
			shape2: s2.

	v addAll: (c elementsOn: #(30 60 80)).
	
	labels := v canvas shapes select: [ :s | s class ==  TRLabelShape ].
	self assert: (labels allSatisfy: [ :lbl | lbl fontSize = 10 ]).
	
]

{ #category : #tests }
RTCompositeShapeTest >> testOffset [

	| v s1 s2 c shapes |
	v := RTView new.

	s1 := (RTEllipse new size: #yourself; color: (Color blue alpha: 0.4)).
	s2 := (RTBox new size: #yourself; color: (Color green alpha: 0.4)).
	c := RTCompositeShape new 
			shape1: s1; 
			shape2: s2;
			offset2: 30 @ 30.

	v add: (c elementOn: 80).
	
	self assert: v numberOfElements = 1.
	self assert: v canvas numberOfShapes = 2.
	
	self assert: v elements first trachelShape offset2 = (30 @ 30).
	
	shapes := v canvas shapes.
	self assert: shapes first position = (0 @ 0).
	self assert: shapes second position = (30@30)
]

{ #category : #tests }
RTCompositeShapeTest >> testOffset2 [

	| v s1 s2 c shapes el |
	v := RTView new.

	s1 := (RTEllipse new size: #yourself; color: (Color blue alpha: 0.4)).
	s2 := (RTBox new size: #yourself; color: (Color green alpha: 0.4)).
	c := RTCompositeShape new 
			shape1: s1; 
			shape2: s2;
			offset2: 30 @ 30.
	el := c elementOn: 80.
	v add: el.

	el trachelShape translateBy: 5 @ 5.	

	shapes := v canvas shapes.
	self assert: shapes first position = (5 @ 5).
	self assert: shapes second position = (35 @ 35)
]

{ #category : #tests }
RTCompositeShapeTest >> testOffset3 [

	| v s1 s2 c shapes el |
	v := RTView new.

	s1 := (RTEllipse new size: #yourself; color: (Color blue alpha: 0.4)).
	s2 := (RTBox new size: #yourself; color: (Color green alpha: 0.4)).
	c := RTCompositeShape new 
			shape1: s1; 
			shape2: s2;
			offset2: 30 @ 30.
	el := c elementOn: 80.
	v add: el.

	el trachelShape translateBy: 5 @ 5.	
	el trachelShape translateBy: 5 @ 5.

	shapes := v canvas shapes.
	self assert: shapes first position = (10 @ 10).
	self assert: shapes second position = (40 @ 40)
]

{ #category : #tests }
RTCompositeShapeTest >> testOffset4 [

	| v s1 s2 c shapes el |
	v := RTView new.

	s1 := (RTEllipse new size: #yourself; color: (Color blue alpha: 0.4)).
	s2 := (RTBox new size: #yourself; color: (Color green alpha: 0.4)).
	c := RTCompositeShape new 
			shape1: s1; 
			shape2: s2;
			offset2: 30 @ 30.
	el := c elementOn: 80.
	v add: el.
	el translateBy: 5 @ 5.	
	el translateBy: 5 @ 5.

	shapes := v canvas shapes.
	self assert: shapes first position = (10 @ 10).
	self assert: shapes second position = (40 @ 40)
]
