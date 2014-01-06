Class {
	#name : #RTElementTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Core'
}

{ #category : #tests }
RTElementTest >> testAddingABoxAndEllipse [

	| view el1 el2 |
	view := RTView new.
	el1 := (RTBox new extent: 40 @ 20; color: Color purple) element.
	el1 translateTo: 50 @ 40.
	el2 := (RTEllipse new extent: 40 @ 20; color: Color blue) element.
	el2 translateTo: 150 @ 40.
	view add: el1; add: el2.
	
	self assert: el1 position = (50 @ 40).
	self assert: el1 trachelShape rectangle = ((30@30) corner: (70@50))
]

{ #category : #view }
RTElementTest >> testAddingAndRemoving [

	| view e tr |
	view := RTView new.
	tr := view canvas.
	e := RTBox element.
	
	self assert: e view isNil.
	self assert: tr numberOfShapes = 0.
	view add: e.
	self assert: e view == view.
	self assert: tr numberOfShapes = 1.
	
	e remove.
	self assert: view numberOfElements = 0.
	self assert: tr numberOfShapes = 0.
	self assert: e view isNil.
]

{ #category : #attributes }
RTElementTest >> testAttributes [
	| el |
	el := RTElement new.
	self deny: el hasAttributes.
	el attributes at: #oldColor put: Color black.
	self assert: el hasAttributes.
]

{ #category : #creating }
RTElementTest >> testCreatingMany [
	| els |
	els := RTBox elementsOn: (1 to: 20).
	self assert: els size = 20.
	self assert: (els collect: #model) asArray = (1 to: 20) asArray.
]

{ #category : #tests }
RTElementTest >> testDefault [
	| el |
	el := RTElement new.
	self assert: el position = (0 @ 0).
	"self assert: el width = 0.
	self assert: el height = 0."
]

{ #category : #interaction }
RTElementTest >> testDraggingCircle [

	| view shape el |
	view := RTView new.
	shape := RTEllipse new size: 40.
	el := shape element.
	view add: el.
	view createAndFillCanvas.
	
	self assert: el position = (0 @ 0).
	el translateBy: 100 @ 50.
	self assert: el position = (100 @ 50).
	
	self assert: el trachelShape rectangle = ((80@30) corner: (120@70))
]

{ #category : #tests }
RTElementTest >> testExtentAndWidthHeight [

	| shape |
	shape := RTBox new extent: 40 @ 20.
	self assert: (shape widthFor: RTElement new) = 40.
	self assert: (shape heightFor: RTElement new) = 20.
]

{ #category : #interaction }
RTElementTest >> testGrowing [

	| view el |
	view := RTView new.
	el := RTBox new size: 20; color: (Color purple alpha: 0.2); element.
	el @ RTDraggable.
	el translateTo: 100 @ 130.
	view add: el.
	
	
]

{ #category : #interaction }
RTElementTest >> testHighlighting [
	| el view |
	el := RTBox element.
	view := RTView new.
	view add: el.
	view createAndFillCanvas.
	
	self assert: el trachelShape color = RTBox new defaultColor.
	
	el trachelShape color: Color red.
	self assert: el trachelShape color = Color red.
]

{ #category : #tests }
RTElementTest >> testModel [
	self assert: (RTElement on: 10) model = 10
]

{ #category : #tests }
RTElementTest >> testRendering [

	| view el |
	view := RTView new.
	el := RTBox element.
	view add: el.
	
	self assert: el trachelShape notNil.
	self assert: el trachelShape class == TRBoxShape
]

{ #category : #tests }
RTElementTest >> testRenderingAndEvent [

	| view el trachelShape |
	view := RTView new.
	el := RTBox element.
	view add: el.
	view createAndFillCanvas.
	trachelShape := el trachelShape.
	self assert: el announcer == trachelShape announcer
]

{ #category : #tests }
RTElementTest >> testResizingAndDragging [

	| view box |
	view := RTView new.
	box := RTBox element.
	view add: box.
	view createAndFillCanvas.
	
	self assert: box extent = (5 @ 5).
	box trachelShape extent: 10 @ 10.
	self assert: box extent = (10 @ 10).

	box translateTo: 5 @ 5.
	self assert: box extent = (10 @ 10).
]

{ #category : #tests }
RTElementTest >> testSameNullShape [
	self assert: RTElement new shape == RTElement new shape.
	self assert: RTNoShape element shape == RTElement new shape.
]

{ #category : #tests }
RTElementTest >> testSize [
	| box el |
	box := RTBox new width: 10; height: 8.
	el := box element.
	
	self assert: el position = (0 @ 0).
	self assert: el height = 8.
	self assert: el width = 10
]

{ #category : #tests }
RTElementTest >> testSizeAndModel [
	| box el |
	box := RTBox new width: [ :e | e + 2 ]; height: [ :e | e + 3 ].
	el := box elementOn: 5.
	
	self assert: el position = (0 @ 0).
	self assert: el height = 8.
	self assert: el width = 7
]

{ #category : #tests }
RTElementTest >> testTrachelShape [

	self assert: RTBox element trachelShape notNil.
	self assert: RTBox element trachelShape class == TRBoxShape.

	self assert: (RTElement new + RTBox) trachelShape notNil.
]

{ #category : #tests }
RTElementTest >> testTranslationBy [
	| el |
	el := RTElement new.
	el translateBy: 15 @ 10.
	self assert: el position = (15 @ 10).

	el translateBy: 5 @ 10.
	self assert: el position = (20 @ 20).

]

{ #category : #tests }
RTElementTest >> testTranslationTo [
	| el |
	el := RTElement new.
	el translateTo: 15 @ 10.
	self assert: el position = (15 @ 10)
]

{ #category : #tests }
RTElementTest >> testWidthAndHeight [

	| view outter inner |
	view := RTView new.
	outter := RTBox element.
	inner := (RTBox new color: Color green) element.
	RTNest new on: outter nest: (Array with: inner).
	self assert: outter width = 15.
	self assert: outter height = 15.
	self assert: outter encompassingRectangle extent = (15 @ 15)
]

{ #category : #tests }
RTElementTest >> testWidthAndHeight2 [

	| view outter inners |
	view := RTView new.
	outter := RTBox element.
	inners := (RTBox new color: Color green) elementsOn: (1 to: 3).
	
	RTHorizontalLineLayout on: inners.
	RTNest new on: outter nest: inners.

	self assert: outter width = 45.
	self assert: outter height = 15.
	self assert: outter encompassingRectangle extent = (45 @ 15)
]
