"
I am shape which builds closed path following ordered collection of vertices.

"
Class {
	#name : #TRPolygonShape,
	#superclass : #TRShape,
	#instVars : [
		'vertices',
		'strokeWidth'
	],
	#category : #'Trachel-Core'
}

{ #category : #visitor }
TRPolygonShape >> accept: aVisitor [
	aVisitor visitPolygonShape: self
]

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

{ #category : #drawing }
TRPolygonShape >> drawOn: athensCanvas [
	| pt  scale ratio |
	pt := athensCanvas pathTransform.
	pt restoreAfter: [
		pt scaleBy: matrix sx @ matrix sy.
		
		athensCanvas
			setShape: self path.
		color isNotNil ifTrue: [ athensCanvas setPaint: color; draw ].
		
		self canvas ifNil: [ ^ self ].
	scale := self canvas camera scale.
	scale < 1 
		ifTrue: [ ratio := self strokeWidth ] 
		ifFalse: [ ratio := self strokeWidth / (scale ) ].
	^ strokePaint
		ifNotNil: [ 
			(athensCanvas setStrokePaint: strokePaint) width: ratio asFloat.
			athensCanvas drawShape: path]]
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

{ #category : #initialization }
TRPolygonShape >> initialize [
	super initialize.
	strokeWidth := 1.0
]

{ #category : #accessing }
TRPolygonShape >> strokeWidth [
	^ strokeWidth
]

{ #category : #accessing }
TRPolygonShape >> strokeWidth: aWidth [
	strokeWidth := aWidth
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
TRPolygonShape >> vertices [
	^ vertices
]

{ #category : #accessing }
TRPolygonShape >> vertices: aCollection [ 
	vertices := aCollection
]

{ #category : #accessing }
TRPolygonShape >> width [
	^ self encompassingRectangle width
]
