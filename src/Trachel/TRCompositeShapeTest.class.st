Class {
	#name : #TRCompositeShapeTest,
	#superclass : #TRTest,
	#instVars : [
		'emptyShape',
		'multiShape',
		'box1',
		'box2',
		'canvas'
	],
	#category : #'Trachel-Core'
}

{ #category : #running }
TRCompositeShapeTest >> setUp [
	super setUp.
	
	emptyShape := TRMultiCompositeShape new.
	multiShape := TRMultiCompositeShape new.
	box1 := TRBoxShape new size: 20. 
	box2 := TRBoxShape new size: 30.
	multiShape addShape: box1; addShape: box2.
	canvas := TRCanvas new.
]

{ #category : #tests }
TRCompositeShapeTest >> testAddingShape [
	emptyShape addShape: TRLabelShape new.
	self assert: emptyShape numberOfShapes equals: 1.
	self assert: multiShape numberOfShapes equals: 2.
]

{ #category : #tests }
TRCompositeShapeTest >> testBasic [
	emptyShape addShape: TRLabelShape new.
	self assert: emptyShape numberOfShapes equals: 1.
	self assert: emptyShape element equals: nil
]

{ #category : #'testing translation' }
TRCompositeShapeTest >> testDefaultPosition [
	self assert: emptyShape position equals: 0 @ 0.
	self assert: multiShape position equals: 0 @ 0.
	self assert: box1 position equals: 0 @ 0.
	self assert: box2 position equals: 0 @ 0.
]

{ #category : #tests }
TRCompositeShapeTest >> testElement [
	emptyShape element: 10.
	self assert: emptyShape element equals: 10.
]

{ #category : #tests }
TRCompositeShapeTest >> testElementOnNonEmpty [
	| c |
	multiShape element: 10.
	self assert: box1 element equals: nil.
	self assert: box2 element equals: nil.
	
	c := TRCanvas new.
	c addShape: multiShape.
	multiShape element: 10.
	self assert: box1 element equals: 10.
	self assert: box2 element equals: 10
]

{ #category : #tests }
TRCompositeShapeTest >> testNoCanvas [
	self assert: box1 canvas equals: nil.
	self assert: multiShape canvas equals: nil
]

{ #category : #'testing layout' }
TRCompositeShapeTest >> testNoLayout [
	canvas addShape: multiShape.
	self assert: box1 position equals: 0 @ 0.
	self assert: box2 position equals: 0 @ 0.
]

{ #category : #tests }
TRCompositeShapeTest >> testNoShapeInEmptyShape [
	self assert: emptyShape numberOfShapes equals: 0
]

{ #category : #'testing translation' }
TRCompositeShapeTest >> testPositionWithOffset [

	| s |
	s := TRMultiCompositeShape new.
	s addShape: box1. 
	s addShape: box2 translateBy: 5 @ 4.
	canvas addShape: s.
	
	self assert: box1 position equals: ((-5/2)@ -2).
	self assert: box2 position equals: ((5/2)@2).

	s translateTo: 10 @ 5.
	self assert: s position equals: 10 @ 5.
	
	self assert: box1 position equals: ((-5/2)@ -2) + (10 @ 5).
	self assert: box2 position equals: ((5/2)@2) + (10 @ 5).


]

{ #category : #'testing translation' }
TRCompositeShapeTest >> testPositionWithOffsetTranslationBy [

	| s |
	s := TRMultiCompositeShape new.
	s addShape: box1. 
	s addShape: box2 translateBy: 5 @ 4.
	canvas addShape: s.
	
	self assert: box1 position equals: ((-5/2)@ -2).
	self assert: box2 position equals: ((5/2)@2).
	
	s translateBy: 10 @ 5.
	self assert: s position equals: 10 @ 5.
	self assert: box1 position equals: ((-5/2)@ -2) + (10 @ 5).
	self assert: box2 position equals: ((5/2)@2) + (10 @ 5).

]

{ #category : #tests }
TRCompositeShapeTest >> testSetCanvas [
	| c |
	c := TRCanvas new.
	multiShape canvas: c.
	self assert: box1 canvas equals: c.
	self assert: multiShape canvas equals: c
]

{ #category : #'testing translation' }
TRCompositeShapeTest >> testTranslation [

	multiShape translateTo: 5 @ 6.
	self assert: multiShape position equals: 5 @ 6.
	self assert: box1 position equals: 5 @ 6.
	self assert: box2 position equals: 5 @ 6.
]

{ #category : #'testing translation' }
TRCompositeShapeTest >> testTranslationBy [

	multiShape translateBy: 5 @ 6.
	self assert: multiShape position equals: 5 @ 6.
	self assert: box1 position equals: 5 @ 6.
	self assert: box2 position equals: 5 @ 6.
]

{ #category : #'testing translation' }
TRCompositeShapeTest >> testTranslationBy2 [

	multiShape translateBy: 5 @ 6.
	multiShape translateBy: 5 @ 6.
	self assert: multiShape position equals: 10 @ 12.
	self assert: box1 position equals: 10 @ 12.
	self assert: box2 position equals: 10 @ 12.
]

{ #category : #'testing layout' }
TRCompositeShapeTest >> testVerticalLayout [
	multiShape vertical.
	canvas addShape: multiShape.
	
	self assert: (multiShape offsetOf: box1) equals: 0 @ 0.
	self assert: (multiShape offsetOf: box2) equals: 0 @ 25.

	self assert: box1 position equals: 0 @ -12.5.
	self assert: box2 position equals: 0 @ 12.5.
	
	

]

{ #category : #'as yet unclassified' }
TRCompositeShapeTest >> testVerticalLayoutWithoutAddingToCanvas [
	multiShape vertical.
"	canvas addShape: multiShape."
	
	self assert: (multiShape offsetOf: box1) equals: 0 @ 0.
	self assert: (multiShape offsetOf: box2) equals: 0 @ 25.

	self assert: box1 position equals: 0 @ 0.
	self assert: box2 position equals: 0 @ 0.
	
	

]
