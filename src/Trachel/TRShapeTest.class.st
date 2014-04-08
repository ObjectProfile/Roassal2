Class {
	#name : #TRShapeTest,
	#superclass : #TRTest,
	#category : #'Trachel-Core'
}

{ #category : #composite }
TRShapeTest >> testBoxTransformation [

	| canvas box |
	canvas := TRCanvas new.
	box := TRBoxShape new size: 10.
	canvas addShape: box.
	"regular rectangle"
	self assert: box position equals: 0 @ 0.
	self assert: box encompassingRectangle equals: (-5 @ -5 corner: 5 @ 5).
	self assert: (box includesPoint: 0 @ 0).
	self deny: (box includesPoint: 10 @ 10).
	"translated rectangle"
	box translateTo: 10@10.
	self assert: box position equals: 10 @ 10.
	self assert: box encompassingRectangle equals: (5 @ 5 corner: 15 @ 15).
	self assert: (box includesPoint: 5 @ 5).
	self deny: (box includesPoint: 4 @ 10).
	"rotated rectangle"
	box rotateByDegrees: 45.
	self assert: box position equals: 10 @ 10.
	self assert: box encompassingRectangle rounded equals: (3 @ 3 corner: 17 @ 17).
	self assert: (box includesPoint: 10 @ 4).
	self deny: (box includesPoint: 6 @ 6).
	"scaled rectangle"
	box scaleBy: 2.
	self assert: box position equals: 10 @ 10.
	self assert: box encompassingRectangle rounded equals: (-4 @ -4 corner: 24 @ 24).
	self assert: (box includesPoint: 10 @ -3).
	self deny: (box includesPoint: 0 @ 0).
	"translated rectangle"
	box translateTo: 20 @ 20.
	self assert: box position equals: 20 @ 20.
	self assert: box encompassingRectangle rounded equals: (6 @ 6 corner: 34 @ 34).
	self assert: (box includesPoint: 20 @ 7).
	self deny: (box includesPoint: 10 @ 10).
	"back to regular rectangle"
	box rotateByDegrees: -45.
	box scaleBy: 0.5.
	self assert: box position equals: 20 @ 20.
	self assert: box encompassingRectangle equals: (15 @ 15 corner: 25 @ 25).
	self assert: (box includesPoint: 16 @ 16).
	self deny: (box includesPoint: 10 @ 10).

]

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
	self assert: s2 color = Color red.
]

{ #category : #composite }
TRShapeTest >> testEllipseTransformation [

	| canvas box |
	canvas := TRCanvas new.
	box := TREllipseShape new size: 10.
	canvas addShape: box.
	"regular rectangle"
	self assert: box encompassingRectangle equals: (-5 @ -5 corner: 5 @ 5).
	self assert: (box includesPoint: 0 @ 0).
	self deny: (box includesPoint: 10 @ 10).
	"translated rectangle"
	box translateTo: 10@10.
	self assert: box encompassingRectangle equals: (5 @ 5 corner: 15 @ 15).
	self assert: (box includesPoint: 5 @ 5).
	self deny: (box includesPoint: 4 @ 10).
	"rotated rectangle"
	box rotateByDegrees: 45.
	self assert: box encompassingRectangle rounded equals: (3 @ 3 corner: 17 @ 17).
	self assert: (box includesPoint: 10 @ 4).
	self deny: (box includesPoint: 6 @ 6).
	"scaled rectangle"
	box scaleBy: 2.
	self assert: box encompassingRectangle rounded equals: (-4 @ -4 corner: 24 @ 24).
	self assert: (box includesPoint: 10 @ -3).
	self deny: (box includesPoint: 0 @ 0).

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
