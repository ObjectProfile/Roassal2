Class {
	#name : #TRShapeTest,
	#superclass : #TRTest,
	#category : #'Trachel-Core'
}

{ #category : #NoShape }
TRShapeTest >> testAddingNoShape [

	| c |
	c := TRCanvas new.
	c addShape: (TRNoShape new).
	self assert: c numberOfShapes = 0
]

{ #category : #bitmap }
TRShapeTest >> testBitmapIncludesPoint [

	| s c |
	s := TRBitmapShape new form: (Form extent: 20 @ 20 depth: 32).
	c := TRCanvas new.
	c addShape: s.
	
	self assert: (s includesPoint: 0 @ 0).
	self assert: (s includesPoint: -9 @ -9).
	self assert: (s includesPoint: 9 @ 9).
	self deny: (s includesPoint: 19 @ 19).
]

{ #category : #composite }
TRShapeTest >> testBoxTransformation [

	| canvas box |
	canvas := TRCanvas new.
	box := TRBoxShape new size: 10.
	canvas addShape: box.
	"regular rectangle"
	self assert: box position equals: 0 @ 0.
	self assert: box encompassingRectangle equals: (-5 @ -5 corner: 5 @ 5).
	self assert: box encompassingRectangle center equals: box position.
	self assert: box width equals: 10.
	self assert: box height equals: 10.
	self assert: box extent equals: 10 @ 10.
	self assert: (box includesPoint: 0 @ 0).
	self deny: (box includesPoint: 10 @ 10).
	"translated rectangle"
	box translateTo: 10@10.
	self assert: box position equals: 10 @ 10.
	self assert: box encompassingRectangle equals: (5 @ 5 corner: 15 @ 15).
	self assert: box encompassingRectangle center equals: box position.
	self assert: box width equals: box encompassingRectangle width.
	self assert: box height equals: box encompassingRectangle height.
	self assert: box extent equals: box encompassingRectangle extent.
	self assert: (box includesPoint: 5 @ 5).
	self deny: (box includesPoint: 4 @ 10).
	"rotated rectangle"
	box rotateByDegrees: 45.
	self assert: box position equals: 10 @ 10.
	self assert: box encompassingRectangle rounded equals: (3 @ 3 corner: 17 @ 17).
	self assert: box encompassingRectangle center equals: box position.
	self assert: box width equals: box encompassingRectangle width.
	self assert: box height equals: box encompassingRectangle height.
	self assert: box extent equals: box encompassingRectangle extent.
	self assert: (box includesPoint: 10 @ 4).
	self deny: (box includesPoint: 6 @ 6).
	"scaled rectangle"
	box scaleBy: 2.
	self assert: box position equals: 10 @ 10.
	self assert: box encompassingRectangle rounded equals: (-4 @ -4 corner: 24 @ 24).
	self assert: box encompassingRectangle center equals: box position.
	self assert: box width equals: box encompassingRectangle width.
	self assert: box height equals: box encompassingRectangle height.
	self assert: box extent equals: box encompassingRectangle extent.
	self assert: (box includesPoint: 10 @ -3).
	self deny: (box includesPoint: 0 @ 0).
	"translated rectangle"
	box translateTo: 20 @ 20.
	self assert: box position equals: 20 @ 20.
	self assert: box encompassingRectangle rounded equals: (6 @ 6 corner: 34 @ 34).
	self assert: box encompassingRectangle center equals: box position.
	self assert: box width equals: box encompassingRectangle width.
	self assert: box height equals: box encompassingRectangle height.
	self assert: box extent equals: box encompassingRectangle extent.
	self assert: (box includesPoint: 20 @ 7).
	self deny: (box includesPoint: 10 @ 10).
	"back to regular rectangle"
	box rotateByDegrees: -45.
	box scaleBy: 0.5.
	self assert: box position equals: 20 @ 20.
	self assert: box encompassingRectangle equals: (15 @ 15 corner: 25 @ 25).
	self assert: box encompassingRectangle center equals: box position.
	self assert: box width equals: box encompassingRectangle width.
	self assert: box height equals: box encompassingRectangle height.
	self assert: box extent equals: box encompassingRectangle extent.
	self assert: (box includesPoint: 16 @ 16).
	self deny: (box includesPoint: 10 @ 10).
	"set width"
	box width: 20.
	self assert: box position equals: 20 @ 20.
	self assert: box encompassingRectangle rounded equals: (10 @ 15 corner: 30 @ 25).
	self assert: box encompassingRectangle center equals: box position.
	self assert: box width equals: 20.
	self assert: box height equals: 10.
	self assert: box extent equals: 20 @ 10.
	"set height"
	box height: 20.
	self assert: box position equals: 20 @ 20.
	self assert: box encompassingRectangle rounded equals: (10 @ 10 corner: 30 @ 30).
	self assert: box encompassingRectangle center equals: box position.
	self assert: box width equals: 20.
	self assert: box height equals: 20.
	self assert: box extent equals: 20 @ 20.
	"set extent"
	box extent: 30 @ 30.
	self assert: box position equals: 20 @ 20.
	self assert: box encompassingRectangle rounded equals: (5 @ 5 corner: 35 @ 35).
	self assert: box encompassingRectangle center equals: box position.
	self assert: box width equals: 30.
	self assert: box height equals: 30.
	self assert: box extent equals: 30 @ 30.

]

{ #category : #composite }
TRShapeTest >> testCenterOnAComposite [

	| c s1 s2 composite |
	c := TRCanvas new.
	s1 := TREllipseShape new size: 20.
	s2 := TREllipseShape new size: 20.
	composite := TRCompositeShape with: s1 with: s2.
	c addShape: composite.
	
	s2 translateTo: 50 @ 40.
	self assert: composite center = (25 @ 20)
	
]

{ #category : #lines }
TRShapeTest >> testCenterOnALine [

	| c l |
	c := TRCanvas new.
	
	l := TRLineShape new from: 50 @ 50 to: 120 @ 100.
	
	c addShape: l.
	
	self assert: l center = (85 @ 75)
	
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
	self assert: s2 color ~= Color red.
]

{ #category : #composite }
TRShapeTest >> testEllipseTransformation [

	| canvas ellipse |
	canvas := TRCanvas new.
	ellipse := TREllipseShape new size: 10.
	canvas addShape: ellipse.
	"regular rectangle"
	self assert: ellipse position equals: 0 @ 0.
	self assert: ellipse encompassingRectangle equals: (-5 @ -5 corner: 5 @ 5).
	self assert: ellipse encompassingRectangle center equals: ellipse position.
	self assert: ellipse width equals: 10.
	self assert: ellipse height equals: 10.
	self assert: ellipse extent equals: 10 @ 10.
	self assert: (ellipse includesPoint: 0 @ 0).
	self deny: (ellipse includesPoint: 10 @ 10).
	"translated rectangle"
	ellipse translateTo: 10@10.
	self assert: ellipse position equals: 10 @ 10.
	self assert: ellipse encompassingRectangle equals: (5 @ 5 corner: 15 @ 15).
	self assert: ellipse encompassingRectangle center equals: ellipse position.
	self assert: ellipse width equals: ellipse encompassingRectangle width.
	self assert: ellipse height equals: ellipse encompassingRectangle height.
	self assert: ellipse extent equals: ellipse encompassingRectangle extent.
	self assert: (ellipse includesPoint: 7 @ 7).
	self deny: (ellipse includesPoint: 4 @ 10).
	"rotated rectangle"
	ellipse rotateByDegrees: 45.
	self assert: ellipse position equals: 10 @ 10.
	self assert: ellipse encompassingRectangle rounded equals: (3 @ 3 corner: 17 @ 17).
	self assert: ellipse encompassingRectangle center equals: ellipse position.
	self assert: ellipse width equals: ellipse encompassingRectangle width.
	self assert: ellipse height equals: ellipse encompassingRectangle height.
	self assert: ellipse extent equals: ellipse encompassingRectangle extent.
	self assert: (ellipse includesPoint: 10 @ 7).
	self deny: (ellipse includesPoint: 6 @ 6).
	"scaled rectangle"
	ellipse scaleBy: 2.
	self assert: ellipse position equals: 10 @ 10.
	self assert: ellipse encompassingRectangle rounded equals: (-4 @ -4 corner: 24 @ 24).
	self assert: ellipse encompassingRectangle center equals: ellipse position.
	self assert: ellipse width equals: ellipse encompassingRectangle width.
	self assert: ellipse height equals: ellipse encompassingRectangle height.
	self assert: ellipse extent equals: ellipse encompassingRectangle extent.
	self assert: (ellipse includesPoint: 10 @ 0).
	self deny: (ellipse includesPoint: 0 @ 0).
	"translated rectangle"
	ellipse translateTo: 20 @ 20.
	self assert: ellipse position equals: 20 @ 20.
	self assert: ellipse encompassingRectangle rounded equals: (6 @ 6 corner: 34 @ 34).
	self assert: ellipse encompassingRectangle center equals: ellipse position.
	self assert: ellipse width equals: ellipse encompassingRectangle width.
	self assert: ellipse height equals: ellipse encompassingRectangle height.
	self assert: ellipse extent equals: ellipse encompassingRectangle extent.
	self assert: (ellipse includesPoint: 20 @ 14).
	self deny: (ellipse includesPoint: 10 @ 10).
	"back to regular rectangle"
	ellipse rotateByDegrees: -45.
	ellipse scaleBy: 0.5.
	self assert: ellipse position equals: 20 @ 20.
	self assert: ellipse encompassingRectangle equals: (15 @ 15 corner: 25 @ 25).
	self assert: ellipse encompassingRectangle center equals: ellipse position.
	self assert: ellipse width equals: ellipse encompassingRectangle width.
	self assert: ellipse height equals: ellipse encompassingRectangle height.
	self assert: ellipse extent equals: ellipse encompassingRectangle extent.
	self assert: (ellipse includesPoint: 17 @ 17).
	self deny: (ellipse includesPoint: 10 @ 10).
	"set width"
	ellipse width: 20.
	self assert: ellipse position equals: 20 @ 20.
	self assert: ellipse encompassingRectangle rounded equals: (10 @ 15 corner: 30 @ 25).
	self assert: ellipse encompassingRectangle center equals: ellipse position.
	self assert: ellipse width equals: 20.
	self assert: ellipse height equals: 10.
	self assert: ellipse extent equals: 20 @ 10.
	"set height"
	ellipse height: 20.
	self assert: ellipse position equals: 20 @ 20.
	self assert: ellipse encompassingRectangle rounded equals: (10 @ 10 corner: 30 @ 30).
	self assert: ellipse encompassingRectangle center equals: ellipse position.
	self assert: ellipse width equals: 20.
	self assert: ellipse height equals: 20.
	self assert: ellipse extent equals: 20 @ 20.
	"set extent"
	ellipse extent: 30 @ 30.
	self assert: ellipse position equals: 20 @ 20.
	self assert: ellipse encompassingRectangle rounded equals: (5 @ 5 corner: 35 @ 35).
	self assert: ellipse encompassingRectangle center equals: ellipse position.
	self assert: ellipse width equals: 30.
	self assert: ellipse height equals: 30.
	self assert: ellipse extent equals: 30 @ 30.

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

{ #category : #composite }
TRShapeTest >> testFixingComposite [

	| c s1 s2 composite |
	c := TRCanvas new.
	s1 := TREllipseShape new size: 20.
	s2 := TREllipseShape new size: 20.
	composite := TRCompositeShape with: s1 with: s2.
	c addShape: composite.

	self assert: c numberOfShapes = 2.
	self assert: c numberOfFixedShapes = 0.
	
	composite setAsFixed.

	self assert: c numberOfShapes = 0.
	self assert: c numberOfFixedShapes = 2
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
TRShapeTest >> testPositionDefaultCenteredSVGPath [
	| svg rectangle |
	svg := TRSVGPath new centeredPath: 'M 0 0 L 30 10 L 20 30 z'.
	rectangle := (Rectangle encompassing: {0@0. 30@10. 20@30}).
	self assert: svg position equals: (0 @ 0).
	self assert: svg center equals: (0 @ 0).
	self deny: svg position = rectangle center.
]

{ #category : #position }
TRShapeTest >> testPositionDefaultSVGPath [
	| svg rectangle |
	svg := TRSVGPath new path: 'M 0 0 L 30 10 L 20 30 z'.
	rectangle := (Rectangle encompassing: {0@0. 30@10. 20@30}).
	self assert: svg position equals: (0 @ 0).
	self assert: svg center equals: rectangle center.
	self deny: svg position = rectangle center.
]

{ #category : #position }
TRShapeTest >> testPositionDefaultSVGPathWithoutPath [

	self assert: TRSVGPath new position = (0 @ 0)
]

{ #category : #position }
TRShapeTest >> testPositionWithFloats [

	| box |
	box := TRBoxShape new.
	box translateTo: 1.1234 @ 1.1234.
	self assert: box position = (1.1234 @ 1.1234)
]

{ #category : #composite }
TRShapeTest >> testPushingBackAComposite [

	| c s1 s2 cs |
	c := TRCanvas new.
	s1 := TRBoxShape new size: 50.
	s2 := TRBoxShape new size: 40.
	cs := TRCompositeShape with: s1 with: s2.
	c addShape: (TREllipseShape new).
	c addShape: cs.
	
	cs pushBack.
	self assert: (c shapes collect: #class) asArray = (Array with: TRBoxShape with: TRBoxShape with: TREllipseShape )
]

{ #category : #composite }
TRShapeTest >> testPushingFrontAComposite [

	| c s1 s2 cs |
	c := TRCanvas new.
	s1 := TRBoxShape new size: 50.
	s2 := TRBoxShape new size: 40.
	cs := TRCompositeShape with: s1 with: s2.
	c addShape: cs.
	c addShape: (TREllipseShape new).
	
	cs pushFront.
	self assert: (c shapes collect: #class) asArray = (Array with: TREllipseShape with: TRBoxShape with:  TRBoxShape)
]

{ #category : #removing }
TRShapeTest >> testRemoving [
	| t callback shape canvas |
	t := nil.
	callback := TRRemoveCallback new.
	callback block: [ :aShape | t := aShape hash ].
	
	shape := TRBoxShape new size: 20.
	shape addCallback: callback.
	
	canvas := TRCanvas new.
	self assert: canvas numberOfShapes equals: 0.
	canvas addShape: shape.
	shape translateBy: 5 @ 5.
	self assert: t isNil.
	
	self assert: canvas numberOfShapes equals: 1.
	shape remove.
	self assert: t equals: shape hash.
	self assert: canvas numberOfShapes equals: 0.
]

{ #category : #position }
TRShapeTest >> testScaleBox [

	| box |
	box := TRBoxShape new.
	box scaleBy: 2.0.
	self assert: box scale equals: 2.0 @ 2.0.
]

{ #category : #position }
TRShapeTest >> testScaleSVG [

	| svg rectangle scaledRectangle |
	svg := TRSVGPath new path: 'M 0 0 L 30 10 L 20 30 z'.
	rectangle := svg encompassingRectangle. 
	svg scaleBy: 2.0.
	scaledRectangle := svg encompassingRectangle.
	self assert: svg scale equals: 2.0 @ 2.0.
	self deny: rectangle = scaledRectangle.
	self assert: rectangle width * 2.0 equals: scaledRectangle width.
	self assert: rectangle height * 2.0 equals: scaledRectangle height.
]
