Class {
	#name : #RTLabelTest,
	#superclass : #RTTest,
	#category : #Roassal2
}

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
RTLabelTest >> testLabel [
	| label1 label2 el |
	label1 := RTLabel new.
	label2 := RTLabel new text: [ :e | e model, '2' ].
	el := RTElement on: 'hello'.
	self assert: (label1 textFor: el) = 'hello'.
	self assert: (label2 textFor: el) = 'hello2'.
]

{ #category : #tests }
RTLabelTest >> testLabelAndElement [
	| label el |
	label := RTLabel new text: [ :e | e model ].
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
