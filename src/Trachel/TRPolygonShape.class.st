"
I am shape which builds closed path following ordered collection of vertices.

"
Class {
	#name : #TRPolygonShape,
	#superclass : #TRShape,
	#instVars : [
		'vertices'
	],
	#category : #'Trachel-Core'
}

{ #category : #private }
TRPolygonShape >> computePath [
	canvas ifNil: [ ^ self ].
	path := self athensCanvas
		createPath: [ :builder | 
			builder
				absolute;
				moveTo: vertices last.
			vertices do: [ :v |
				builder lineTo: v ].
			builder closePath ]
]

{ #category : #accessing }
TRPolygonShape >> encompassingRectangle [
	^ vertices min corner: vertices max
]

{ #category : #accessing }
TRPolygonShape >> height [
^ self encompassingRectangle height 
]

{ #category : #testing }
TRPolygonShape >> includesPoint: point [

  ^ ( AthensPolygonTester new polygon: vertices ) includesPoint: point.
"self encompassingRectangle containsPoint: point"
]

{ #category : #actions }
TRPolygonShape >> translateBy: aPoint [
	vertices := vertices collect:[ :each | each + aPoint].
	self triggerCallbacksForStep: aPoint.
	self computePath
]

{ #category : #actions }
TRPolygonShape >> translateTo: aPoint [
| dist |
	dist := aPoint - self encompassingRectangle center.
	self translateBy: dist.
]

{ #category : #accessing }
TRPolygonShape >> vertices: aCollection [ 
	vertices := aCollection
]

{ #category : #accessing }
TRPolygonShape >> width [
^ self encompassingRectangle width
]
