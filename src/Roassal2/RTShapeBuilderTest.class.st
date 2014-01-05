Class {
	#name : #RTShapeBuilderTest,
	#superclass : #RTTest,
	#instVars : [
		'builder'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #running }
RTShapeBuilderTest >> setUp [

	builder := RTShapeBuilder new
]

{ #category : #tests }
RTShapeBuilderTest >> testBasic [

	self assert: builder shape class == RTNoShape
]

{ #category : #tests }
RTShapeBuilderTest >> testBox [
	builder rectangle.
	self assert: builder shape class == RTBox
]

{ #category : #tests }
RTShapeBuilderTest >> testBoxWithDimensions [
	| shape |
	builder rectangle width: [ :v | v + 3 ].
	shape := builder shape.
	self assert: shape class == RTBox.
	self assert: (shape widthFor: (RTElement on: 5)) = 8
]

{ #category : #tests }
RTShapeBuilderTest >> testLine [
	builder line.
	self assert: builder shape class == RTLine
]
