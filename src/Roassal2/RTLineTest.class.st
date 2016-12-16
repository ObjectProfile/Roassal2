Class {
	#name : #RTLineTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Core-Tests'
}

{ #category : #tests }
RTLineTest >> testBasic [

	| e1 e2 l edge |
	e1 := RTBox elementOn: 5.
	e2 := RTBox elementOn: 10.

	l := RTLine new.
	l widthElement: [ :anEdge | anEdge from model ].	
	edge := l edgeFrom: e1 to: e2.

	self assert: edge trachelShape width equals: 5
]

{ #category : #tests }
RTLineTest >> testBasicError [

	| arrow |
	arrow := RTArrowedLine new
			color: Color red;
			edgeFrom: RTElement new to: RTElement new;
			withOffsetIfMultiple.
	self should: [ arrow element ] raise: Error
]

{ #category : #tests }
RTLineTest >> testSameColorThanEnding [

	| e1 e2 l |
	e1 := RTBox new color: Color blue; element.
	e2 := RTBox new color: Color red; element.
	l := RTLine new sameColorThanEnding;
			edgeFrom: e1 to: e2.
	self assert: l trachelShape color equals: e2 trachelShape color
]

{ #category : #tests }
RTLineTest >> testSameColorThanStarting [

	| e1 e2 l |
	e1 := RTBox new color: Color blue; element.
	e2 := RTBox new color: Color red; element.
	l := RTLine new sameColorThanStarting;
			edgeFrom: e1 to: e2.
	self assert: l trachelShape color equals: e1 trachelShape color
]

{ #category : #tests }
RTLineTest >> testSameColorThanStarting01 [

	| e1 e2 l |
	e1 := RTBox new color: Color blue; element.
	e2 := RTBox new color: Color red; element.
	l := RTLine new edgeFrom: e1 to: e2.
	self assert: l trachelShape color ~= e1 trachelShape color
]
