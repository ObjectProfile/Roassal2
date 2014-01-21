Class {
	#name : #RTLabelTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Core'
}

{ #category : #tests }
RTLabelTest >> testDefault [
	self assert: (RTLabel new heightFor: RTElement new) = TRLabelShape new defaultFontSize.
]

{ #category : #tests }
RTLabelTest >> testEncompassing [

	| lbl rec |
	lbl := (RTLabel elementOn: 'hello world').
	rec := lbl encompassingRectangle.
	self assert: rec class == Rectangle.
	self assert: rec center = (0 @ 0).
	self assert: rec extent > (10 @ 10)
]

{ #category : #tests }
RTLabelTest >> testHeight2 [
	| v label els |
	v := RTView new.
	label := RTLabel new.
	label height: [ :e | e model ].
	els := label elementsOn: (1 to: 3).
	self assert: els first trachelShape text = '1'.
	self assert: els first trachelShape fontSize = 1.

	self assert: els second trachelShape text = '2'.
	self assert: els second trachelShape fontSize = 2.

	self assert: els third trachelShape text = '3'.
	self assert: els third trachelShape fontSize = 3.
]

{ #category : #tests }
RTLabelTest >> testLabel [
	| label1 label2 el |
	label1 := RTLabel new.
	label2 := RTLabel new textElement: [ :e | e model, '2' ].
	el := RTElement on: 'hello'.
	self assert: (label1 textFor: el) = 'hello'.
	self assert: (label2 textFor: el) = 'hello2'.
]

{ #category : #tests }
RTLabelTest >> testLabelAndElement [
	| label el |
	label := RTLabel new textElement: [ :e | e model ].
	el := label elementOn: 'hello'.
	self assert: el width = (label widthFor: el)
]

{ #category : #tests }
RTLabelTest >> testLabelHeight [
	| label1 label2 el |
	label1 := RTLabel new text: 'hello'.
	label2 := RTLabel new text: 'hello world'.
	el := RTElement new.
	self assert: (label1 heightFor: el) = (label2 heightFor: el)
]

{ #category : #tests }
RTLabelTest >> testLabelWidth [
	| label1 label2 el |
	label1 := RTLabel new text: 'hello'.
	label2 := RTLabel new text: 'hello world'.
	el := RTElement new.
	self assert: (label1 widthFor: el) < (label2 widthFor: el)
]

{ #category : #tests }
RTLabelTest >> testText [
	| v label els |
	v := RTView new.
	label := RTLabel new.
	els := label elementsOn: (1 to: 30).
	self assert: els first trachelShape text = '1'.
	self assert: els second trachelShape text = '2'.
]
