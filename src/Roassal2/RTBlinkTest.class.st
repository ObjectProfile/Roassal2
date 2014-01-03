Class {
	#name : #RTBlinkTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Core'
}

{ #category : #tests }
RTBlinkTest >> testBlink [

	| view el canvas |
	view := RTView new.
	el := RTBox element.
	view add: el.
	canvas := view createAndFillCanvas.

	self assert: el shape color ~= Color red.
	self deny: canvas hasAnimation.
	
	RTBlink on: el in: view.
	self assert: el trachelShape color = Color red.
	self assert: canvas hasAnimation.
]

{ #category : #tests }
RTBlinkTest >> testBlink [

	| view el canvas |
	view := RTView new.
	el := RTBox element.
	view add: el.
	canvas := view createAndFillCanvas.

	self assert: el shape color ~= Color red.
	self deny: canvas hasAnimation.
	
	RTBlink on: el in: view.
	self assert: el trachelShape color = Color red.
	self assert: canvas hasAnimation.
]

{ #category : #tests }
RTBlinkTest >> testHighlighting [

	| view el canvas originalColor |
	view := RTView new.
	el := RTBox element.
	view add: el.
	canvas := view createAndFillCanvas.

	originalColor := el trachelShape color.

	RTBlink highlight: el.
	self assert: el trachelShape color = Color red.


	RTBlink unhighlight: el.
	self assert: el trachelShape color = originalColor.
]

{ #category : #tests }
RTBlinkTest >> testHighlighting [

	| view el canvas originalColor |
	view := RTView new.
	el := RTBox element.
	view add: el.
	canvas := view createAndFillCanvas.

	originalColor := el trachelShape color.

	RTBlink highlight: el.
	self assert: el trachelShape color = Color red.


	RTBlink unhighlight: el.
	self assert: el trachelShape color = originalColor.
]
