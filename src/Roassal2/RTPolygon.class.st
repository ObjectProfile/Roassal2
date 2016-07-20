"
I am a shape which builds the polygon sequentialy conecting my vertices.

For example:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
| v  shape element |
v := RTView new.
shape := 
	RTPolygon new 
		vertices:{
		25 @ 00 .
		10 @ 50 .
		50 @ 20 .
		00 @ 20 .
		40 @ 50 }.
element := shape element.
v add: element.
v open
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
"
Class {
	#name : #RTPolygon,
	#superclass : #RTAbstractElementShape,
	#instVars : [
		'vertices'
	],
	#category : #'Roassal2-Shapes'
}

{ #category : #initialization }
RTPolygon >> initialize [
	super initialize.
	self vertices: #()
]

{ #category : #hooks }
RTPolygon >> trachelShapeClass [
	^ TRPolygonShape

]

{ #category : #hooks }
RTPolygon >> updateFor: anElement trachelShape: trachelShape [

	trachelShape isNil ifTrue: [ ^ self ].
	trachelShape
		color: (self colorFor: anElement);
		strokeWidth: (self borderWidthFor: anElement);
		strokePaint: (self borderColorFor: anElement);
		vertices: (self verticesFor: anElement);
		rotateByDegrees: (self rotationFor: anElement);
		scaleBy: (self scaleFor: anElement)
]

{ #category : #accessing }
RTPolygon >> vertices [
	^ vertices
]

{ #category : #accessing }
RTPolygon >> vertices: arrayOfPoints [
	self verticesElement: [ :e | arrayOfPoints rtValue: e model ].
]

{ #category : #accessing }
RTPolygon >> verticesElement: arrayOfPoints [
	vertices := arrayOfPoints
]

{ #category : #hooks }
RTPolygon >> verticesFor: anElement [
	^ vertices rtValue: anElement.
]
