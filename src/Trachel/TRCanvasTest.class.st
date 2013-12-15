Class {
	#name : #TRCanvasTest,
	#superclass : #TestCase,
	#instVars : [
		'canvas'
	],
	#category : #Trachel
}

{ #category : #running }
TRCanvasTest >> setUp [

	canvas := TRCanvas new
]

{ #category : #tests }
TRCanvasTest >> testDefault [

	self assert: canvas shapes isEmpty
]

{ #category : #tests }
TRCanvasTest >> testShape [
	| shape |
	shape := canvas buildRectangle: (5 @ 5 extent: 20 @ 20) color: Color gray.
	self assert: shape notNil.

]

{ #category : #tests }
TRCanvasTest >> testShapes [

	canvas buildRectangle: (5 @ 5 extent: 20 @ 20) color: Color gray.
	canvas buildRectangle: (5 @ 5 extent: 20 @ 20) color: Color gray.
	self assert: canvas shapes size = 2
]
