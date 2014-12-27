Class {
	#name : #RTShapeBuilderTest,
	#superclass : #RTTest,
	#instVars : [
		'builder'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #running }
RTShapeBuilderTest >> setUp [

	builder := RTShapeBuilder new
]

{ #category : #'attach point' }
RTShapeBuilderTest >> testAttachPoint01 [

	builder line; verticalAttachPoint.
	self assert: RTVerticalAttachPoint equals: builder shape attachPoint class
]

{ #category : #'attach point' }
RTShapeBuilderTest >> testAttachPoint02 [

	builder line; horizontalAttachPoint.
	self assert: builder shape attachPoint class equals: RTHorizontalAttachPoint
]

{ #category : #'attach point' }
RTShapeBuilderTest >> testAttachPoint03 [

	builder line; centeredAttachPoint.
	self assert: builder shape attachPoint class equals: RTCenteredAttachPoint
]

{ #category : #tests }
RTShapeBuilderTest >> testBasic [

	self assert: builder shape class == RTNoShape
]

{ #category : #tests }
RTShapeBuilderTest >> testBox [
	builder rectangle.
	self assert: builder shape class == RTBox
]

{ #category : #tests }
RTShapeBuilderTest >> testBoxWithDimensions [
	| shape |
	builder rectangle width: [ :v | v + 3 ].
	shape := builder shape.
	self assert: shape class == RTBox.
	self assert: (shape widthFor: (RTElement on: 5)) = 8
]

{ #category : #'created elements' }
RTShapeBuilderTest >> testCreatingElements [
	builder rectangle.
	self assert: builder createdElements size = 0.
	builder elementsOn: (1 to: 10).
	self assert: builder createdElements size = 10.
	builder reset.
	self assert: builder createdElements size = 0.
]

{ #category : #ensure }
RTShapeBuilderTest >> testEnsure [

	builder rectangle color: Color red.
	self assert: builder current class equals: RTBox.
	self assert: ((builder current color) rtValue: RTElement new) equals: Color red.
	builder ensure: RTBox.
	self assert: ((builder current color) rtValue: RTElement new) equals: Color red.
]

{ #category : #ensure }
RTShapeBuilderTest >> testEnsure2 [

	builder rectangle color: Color red.
	builder ensure: RTEllipse.
	self assert: ((builder current color) rtValue: RTElement new) equals: (RTEllipse new color).
]

{ #category : #hasSetShape }
RTShapeBuilderTest >> testHasSetShape [

	self deny: builder hasSetShape.
	builder rectangle.
	self assert: builder hasSetShape.
	self deny: builder hasSetLineShape.
	
	builder line.
	self assert: builder hasSetShape.
	self assert: builder hasSetLineShape.
]

{ #category : #tests }
RTShapeBuilderTest >> testLine [
	builder line.
	self assert: builder shape class == RTLine
]

{ #category : #'linear fill color' }
RTShapeBuilderTest >> testLinearFillColorWithin [
	| elements m |
	m := (Array with: #(0) with: #(1) with: #(2)).
	builder rectangle linearFillColor: #first within: m.
	elements := builder elementsOn: m.
	
	self assert: elements first trachelShape color red > 0.9.
	self assert: elements first trachelShape color green > 0.9.
	self assert: elements first trachelShape color blue > 0.9.	
	self assert: elements third trachelShape color = Color black.
]

{ #category : #tests }
RTShapeBuilderTest >> testOrthoLine [

	| v eb |
	v := RTView new.
	v addAll: (RTBox new elementsOn: (1 to: 4)).

	eb := RTEdgeBuilder new.
	eb shape orthoHorizontalLine color: Color veryLightGray.
	eb view: v.
	eb objects: (1 to: 4) from: #yourself to: [ :vv | vv - 1 ].
	self assert: (v canvas shapes noneSatisfy: [ :s | s class == TRMultiCompositeShape ])

]

{ #category : #tests }
RTShapeBuilderTest >> testShape [
	| e1 e2 e3 |
	builder rectangle
		if: [ :o | o = 3 ] fillColor: Color blue;
		if: [ :o | o = 4 ] fillColor: Color red.
	e1 := builder elementOn: 3.
	e2 := builder elementOn: 4.
	e3 := builder elementOn: 5.
	
	self assert: (e1 shape colorFor: e1) = Color blue.
	self assert: e1 trachelShape color = Color blue.
	self assert: e2 trachelShape color = Color red.
	self assert: e3 trachelShape color = Color veryVeryLightGray.
]

{ #category : #tests }
RTShapeBuilderTest >> testShape2 [
	| e1 e2 e3 |
	builder rectangle
		ifElement: [ :el | el model = 3 ] fillColor: Color blue;
		ifElement: [ :el | el model = 4 ] fillColor: Color red.
	e1 := builder elementOn: 3.
	e2 := builder elementOn: 4.
	e3 := builder elementOn: 5.
	
	self assert: (e1 shape colorFor: e1) = Color blue.
	self assert: e1 trachelShape color = Color blue.
	self assert: e2 trachelShape color = Color red.
	self assert: e3 trachelShape color = Color veryVeryLightGray.
]

{ #category : #withText }
RTShapeBuilderTest >> testWithText [

	| v el |
	v := RTView new.
	builder := RTShapeBuilder new.
	builder circle 
				size: 50; 
				fillColor: (Color purple alpha: 0.3);
				withText.
	el := builder elementOn: 'hello'.
	v add: el.
	
	self assert: el shape class == RTMultiCompositeShape.
	
]

{ #category : #withText }
RTShapeBuilderTest >> testWithTextAndTranslation [

	| v el |
	v := RTView new.
	builder := RTShapeBuilder new.
	builder circle 
				size: 50; 
				fillColor: (Color purple alpha: 0.3);
				withText.
	el := builder elementOn: 'hello'.
	el translateTo: 20 @ 20.
	v add: el.
	
	self assert: el shape class == RTMultiCompositeShape.
	
]
