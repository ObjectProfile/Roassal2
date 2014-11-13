"
I am a shape which builds the polygon sequentialy conecting my vertices.

For example:
RTPolygon new 
	vertices:{
		25 @ 00 .
		10 @ 50 .
		50 @ 20 .
		00 @ 20 .
		40 @ 50 }.
"
Class {
	#name : #RTPolygon,
	#superclass : #RTAbstractElementShape,
	#instVars : [
		'vertices'
	],
	#category : #'Roassal2-Core'
}

{ #category : #hooks }
RTPolygon >> trachelShapeClass [
	^ TRPolygonShape

]

{ #category : #hooks }
RTPolygon >> updateFor: anElement trachelShape: trachelShape [

	trachelShape isNil ifTrue: [ ^ self ].
	trachelShape color: (self colorFor: anElement).
	trachelShape strokeWidth: (self borderWidthFor: anElement).
	trachelShape strokePaint: (self borderColorFor: anElement).
	trachelShape vertices: vertices
]

{ #category : #accessing }
RTPolygon >> vertices [
	^ vertices
]

{ #category : #accessing }
RTPolygon >> vertices: anObject [
	vertices := anObject
]
