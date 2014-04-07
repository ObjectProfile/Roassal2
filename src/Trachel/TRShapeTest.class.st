Class {
	#name : #TRShapeTest,
	#superclass : #TRTest,
	#category : #'Trachel-Core'
}

{ #category : #composite }
TRShapeTest >> testChangingColorOfAComposite [

	| c s1 s2 cs |
	c := TRCanvas new.
	s1 := TRBoxShape new size: 50.
	s2 := TRBoxShape new size: 40.
	cs := TRCompositeShape with: s1 with: s2.
	c addShape: cs.
	cs color: Color red.
	
	self assert: s1 color = Color red.
	self assert: s2 color ~= Color red.
]

{ #category : #composite }
TRShapeTest >> testExtendingAComposite [

	| c s1 s2 cs |
	c := TRCanvas new.
	s1 := TRBoxShape new size: 50.
	s2 := TRBoxShape new size: 40.
	cs := TRCompositeShape with: s1 with: s2.
	c addShape: cs.
	cs extent: 100 @ 80.
	
	self assert: s1 extent = (100 @ 80).
	self assert: s2 extent = (100 @ 80).
]

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
