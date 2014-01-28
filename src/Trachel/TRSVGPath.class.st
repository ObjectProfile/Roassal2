Class {
	#name : #TRSVGPath,
	#superclass : #TRShape,
	#instVars : [
		'borderWidth',
		'fillColor',
		'scale',
		'position',
		'paths',
		'pathPoints',
		'points',
		'curves',
		'rotationAngle',
		'rectangle'
	],
	#category : #'Trachel-Core'
}

{ #category : #accessing }
TRSVGPath >> angle [
	^ rotationAngle
]

{ #category : #accessing }
TRSVGPath >> borderColor: aColor [
	self strokeColor: aColor
]

{ #category : #accessing }
TRSVGPath >> borderWidth: width [
	borderWidth := width.
]

{ #category : #accessing }
TRSVGPath >> center [
	^ rectangle center
]

{ #category : #accessing }
TRSVGPath >> color [
	^ fillColor
]

{ #category : #accessing }
TRSVGPath >> color: aColor [
	^ self fillColor: aColor
]

{ #category : #hooks }
TRSVGPath >> computePath [
	path := (self athensCanvas createPath: [ :builder |
			builder absolute.
			curves do: [ :c |
				c key = 'm' ifTrue: [ builder moveTo: (c value at: 1) ].
				c key = 'l' ifTrue: [ builder lineTo: (c value at: 1) ].
				c key = 'c' ifTrue: [ builder curveVia: (c value at: 2) and: (c value at: 3) to: (c value at: 1) ].
				c key = 'q' ifTrue: [ builder curveVia: (c value at: 2) to: (c value at: 1) ]. ]
		])
]

{ #category : #accessing }
TRSVGPath >> curves [
	^ curves
]

{ #category : #accessing }
TRSVGPath >> curves: someCurves [
	curves := someCurves.
	paths := self separateSubPaths: someCurves.
	pathPoints := OrderedCollection new.
	paths do: [ :p |
		|pts|
		pts := OrderedCollection new.
		p do: [ :curve |
			curve key = 'm' ifFalse: [pts add: (curve value at: 1) * scale]
		].
		pathPoints add: pts.
	].
	points := pathPoints inject: #() into: [ :acc :next | acc, next ].
	position := self encompassingRectangle center.
]

{ #category : #drawing }
TRSVGPath >> drawOn: aCanvas [
	| pt |
	pt := aCanvas pathTransform.
	pt restoreAfter: [
		pt scaleBy: scale.
		aCanvas setShape: self path.
		fillColor isNotNil ifTrue: [ aCanvas setPaint: fillColor; draw ].
		(aCanvas setStrokePaint: strokePaint) width: borderWidth.
		aCanvas draw
	]
]

{ #category : #accessing }
TRSVGPath >> encompassingRectangle [
	rectangle := Rectangle encompassing: points.
	^ rectangle
]

{ #category : #drawing }
TRSVGPath >> figure: aCanvas [
	^ aCanvas createPath: [:builder |
		builder
			absolute;
			moveTo: 100@200 ;
			curveVia: 100@100 and: 250@100 to: 250@ 200;
			curveVia: 250@300 and: 400@300 to: 400@200 ]
	
]

{ #category : #accessing }
TRSVGPath >> fillColor: aColor [
	fillColor := aColor
]

{ #category : #testing }
TRSVGPath >> includesPoint: aPoint [
	|apt|
	apt := AthensPolygonTester new.
	^ pathPoints inject: false into: [ :res :p |
		res or: ((apt polygon: p) includesPoint: aPoint)
	]
]

{ #category : #initialization }
TRSVGPath >> initialize [
	super initialize.
	curves := #().
	paths := #().
	pathPoints := #().
	points := #().
	rotationAngle := 0.
	rectangle := Rectangle origin: 0@0 corner: 0@0.
]

{ #category : #actions }
TRSVGPath >> rotateBy: anAngle [
	|center|
	center := self center / scale.
	
	self curves: (self curves collect: [ :c |
		c key -> (c value collect: [ :p |
			| pp cosTheta sinTheta |
			pp := p - center.
			cosTheta := anAngle cos.
			sinTheta := anAngle sin.
			(pp x * cosTheta - (pp y * sinTheta)) @ (pp x * sinTheta + (pp y * cosTheta))
			+ center.
		])]).
	
	rotationAngle := rotationAngle + anAngle.
	^ rotationAngle.
]

{ #category : #actions }
TRSVGPath >> rotateTo: anAngle [
	^ self rotateBy: anAngle - rotationAngle.
]

{ #category : #accessing }
TRSVGPath >> scale [
	^ scale
]

{ #category : #accessing }
TRSVGPath >> scale: aNumber [
	scale := aNumber
]

{ #category : #hooks }
TRSVGPath >> separateSubPaths: someCurves [
	| subPath |
	paths := OrderedCollection new.
	subPath := OrderedCollection new.
	
	someCurves do: [ :c |
		c key = 'm' ifTrue: [ paths add: subPath. subPath:= OrderedCollection new ].
		subPath add: c.
	].
	paths add: subPath.
	^ paths
]

{ #category : #actions }
TRSVGPath >> translateTo: aPoint [
	|disp|
	super translateTo: aPoint.
	disp := (aPoint - position) / scale.
	position := aPoint.
	self curves: (self curves collect: [ :c |
		c key -> (c value collect: [ :p | p + disp ])]).
	rectangle := rectangle translateBy: disp.
]
