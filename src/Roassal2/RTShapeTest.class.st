Class {
	#name : #RTShapeTest,
	#superclass : #RTTest,
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTShapeTest >> testColoredShape [

	| shape el |
	shape := RTBox new color: Color red.
	el := shape element.
	RTView new add: el; createAndFillCanvas.
	self assert: el trachelShape color = Color red
]

{ #category : #'as yet unclassified' }
RTShapeTest >> testElementCreation [

	| s |
	s := RTBox new.
	self assert: s element shape == s
]

{ #category : #'as yet unclassified' }
RTShapeTest >> testInstance [

	| s |
	self assert: RTBox instance class == RTBox.
	self assert: RTBox instance ~~ RTBox instance.
	
	s := RTBox instance.
	self assert: s instance == s.
]

{ #category : #'as yet unclassified' }
RTShapeTest >> testLabel [
	| label1 label2 el |
	label1 := RTLabel new.
	label2 := RTLabel new text: [ :e | e model, '2' ].
	el := RTElement on: 'hello'.
	self assert: (label1 textFor: el) = 'hello'.
	self assert: (label2 textFor: el) = 'hello2'.
]

{ #category : #'as yet unclassified' }
RTShapeTest >> testShapeCreation [

	self assert: RTBox element shape class == RTBox
]
