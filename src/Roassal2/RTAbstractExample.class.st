Class {
	#name : #RTAbstractExample,
	#superclass : #RTObject,
	#category : #'Roassal2-ExampleBrowser'
}

{ #category : #'as yet unclassified' }
RTAbstractExample >> installOn: aView [
	| el |
	el := (RTLabel new text: (self label)) element.
	el @ RTHighlightable.
	aView add: el
]

{ #category : #'as yet unclassified' }
RTAbstractExample >> installTitle: aTitle code: sourceCode [
	"SourceCode should be a complete example, executable within a workspace"
	
	"
	
	RTRoassalExample new installTitle: 'Bezier' 
		code:
		'| v shape  edge els |
v := RTView new.
shape := RTEllipse new size: 10; color: (Color purple alpha: 0.3).
els := (shape elementsOn: (1 to: 6)) @ RTDraggable.
v addAll: els .
RTHorizontalLineLayout on: v elements.

v elements first translateBy: -50 @ 50.
v elements third translateBy: -10 @ 20.
v elements fifth translateBy: 0 @ -60.
v elements last translateBy: 150 @ 100.

edge := (RTBezierLine new controllingElements: v elements) edgeFrom: els first to: els last.
v add: edge.

v open.
v canvas'
	"
	| morph form |
	morph := (Compiler evaluate: sourceCode) morph. 
	form := Form extent: 500 @ 500 depth: 32.
	morph drawOn: form getCanvas.
	
	"Check users of Base64MimeConverter to see how to convert a form into a 64 mime string"
	
	
	self halt.
]

{ #category : #'as yet unclassified' }
RTAbstractExample >> label [
	^ 'fill please'
]
