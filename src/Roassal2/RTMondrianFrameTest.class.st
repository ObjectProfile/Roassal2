Class {
	#name : #RTMondrianFrameTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Builder-NewMondrian'
}

{ #category : #tests }
RTMondrianFrameTest >> testDefault [

	self assert: RTMondrianFrame new topElements isEmpty
]

{ #category : #tests }
RTMondrianFrameTest >> testDefaultDepth [

	self assert: RTMondrianFrame new depth equals: 0
]

{ #category : #tests }
RTMondrianFrameTest >> testDefaultElements [

	self assert: RTMondrianFrame new elements isEmpty
]
