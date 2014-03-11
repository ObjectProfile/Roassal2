Class {
	#name : #TRShapeTest,
	#superclass : #TRTest,
	#category : #'Trachel-Core'
}

{ #category : #callback }
TRShapeTest >> testHasCallback [
	| s |
	s := TRBoxShape new.
	self deny: s hasEventCallback.
	s when: TRMouseClick do: [ :e | ].
	self assert: s hasEventCallback.
]

{ #category : #position }
TRShapeTest >> testPosition [

	| box |
	box := TRBoxShape new.
	box translateTo: 10 @ 20.
	self assert: box position = (10 @ 20)
]

{ #category : #position }
TRShapeTest >> testPositionDefault [

	self assert: TRBoxShape new position = (0 @ 0)
]

{ #category : #position }
TRShapeTest >> testPositionWithFloats [

	| box |
	box := TRBoxShape new.
	box translateTo: 1.1234 @ 1.1234.
	self assert: box position = (1.1234 @ 1.1234)
]
