Class {
	#name : #TRSVGPath,
	#superclass : #TRShape,
	#instVars : [
		'borderWidth',
		'fillColor',
		'scale',
		'paths',
		'pathPoints',
		'points',
		'curves',
		'rotationAngle',
		'rectangle',
		'pathStr'
	],
	#category : #'Trachel-Core'
}

{ #category : #visitor }
TRSVGPath >> accept: aVisitor [
	aVisitor visitSVGPath: self
]

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
	curves isNil ifFalse: [ ^ curves ].
	curves := self processPath.
	self processCurves.
	^ curves
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
	scale := 1.
	paths := #().
	pathPoints := #().
	points := #().
	rotationAngle := 0.
	rectangle := Rectangle origin: 0@0 corner: 0@0.
]

{ #category : #accessing }
TRSVGPath >> path: aPathString [
	pathStr := aPathString.
	self updateCurves: self curves.
]

{ #category : #accessing }
TRSVGPath >> pathString [
	^pathStr
]

{ #category : #'as yet unclassified' }
TRSVGPath >> processCurves [
	paths := self separateSubPaths: curves.
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

{ #category : #'as yet unclassified' }
TRSVGPath >> processPath [
	"This method parse the path"
	"
	A complete description may be found on http://www.w3.org/TR/SVG/paths.html#PathData
	So far, we only consider the following SVG tokens:
	
	M = Move to - absolute
	m = Move to - relative
	
	Z or z = Close path
	
	L = Line to - absolute
	l = Line to - relative
	
	The description of SVG path, says that M and m may accept more than one coordinates. In practices, this is rarely the case. 	
	"
	| p initialPoint answer tokens stream token t pathWithSpaceBeforeMinus cp1 cp2 nextPoint|
	p := 0 @ 0.
	initialPoint := nil.
	answer := OrderedCollection new.
	
	pathWithSpaceBeforeMinus := pathStr copyReplaceAll: '-' with: ' -' asTokens: false.
	tokens := pathWithSpaceBeforeMinus findTokens: 'MmLlZzCcSsQqTtHhVv, ' keep: 'MmLlZzCcSsQqTtHhVv'.
	stream := ReadStream on: tokens.
	nextPoint := [ (Float readFrom: stream next) @ (Float readFrom: stream next) ].
	
	[ stream atEnd ] whileFalse: [ 
		token := stream next.
		token = 'M' ifTrue: [ p := nextPoint value. answer add: #m -> {p}. initialPoint := nil. cp1 := nil. cp2 := nil ].
		token = 'm' ifTrue: [ p := p + (nextPoint value). answer add: #m -> {p}. initialPoint := nil. cp1 := nil. cp2 := nil ].

		(token = 'Z' or: [ token = 'z' ]) ifTrue: [ answer add: #l -> {initialPoint}. initialPoint := nil ].

		token = 'L' ifTrue: [ t := nextPoint value. answer add: #l -> {t}. p := t. cp1 := nil. cp2 := nil ].
		token = 'l' ifTrue: [ t := p + (nextPoint value). answer add: #l -> {t}. p := t. cp1 := nil. cp2 := nil ].
		
		token = 'V' ifTrue: [ t := (p x) @ (Float readFrom: stream next). answer add: #l -> {t}. p := t. cp1 := nil. cp2 := nil ].
		token = 'v' ifTrue: [ t := p + (0 @ (Float readFrom: stream next)). answer add: #l -> {t}. p := t. cp1 := nil. cp2 := nil ].
		
		token = 'H' ifTrue: [ t := (Float readFrom: stream next) @ (p y). answer add: #l -> {t}. p := t. cp1 := nil. cp2 := nil ].
		token = 'h' ifTrue: [ t := p + ((Float readFrom: stream next) @ 0). answer add: #l -> {t}. p := t. cp1 := nil. cp2 := nil ].
		
		token = 'C' ifTrue: [
			cp1 := nextPoint value. cp2 := nextPoint value.
			t := nextPoint value.
			answer add: #c -> {t. cp1. cp2}. p := t. cp1 := nil ].
		token = 'c' ifTrue: [ 
			cp1 := p + (nextPoint value). cp2 := p + (nextPoint value).
			t := p + (nextPoint value).
			answer add: #c -> {t. cp1. cp2}. p := t. cp1 := nil ].
		
		token = 'S' ifTrue: [ 
			cp1 := (cp2 isNil ifTrue: [ p ] ifFalse: [ p + (p - cp2) ]). cp2 := nextPoint value.
			t := nextPoint value.
			answer add: #c -> { t. cp1. cp2. }. p:= t. cp1 := nil ].
		token = 's' ifTrue: [ 
			cp1 := (cp2 isNil ifTrue: [ p ] ifFalse: [ p + (p - cp2) ]). cp2 := p + nextPoint value.
			t := p + nextPoint value.
			answer add: #c -> { t. cp1. cp2. }. p:= t. cp1 := nil ].
		
		token = 'Q' ifTrue: [
			cp1 := nextPoint value. t := nextPoint value.
			answer add: #q -> {t. cp1}. p := t. cp2 := nil ].
		token = 'q' ifTrue: [ 
			cp1 := p + (nextPoint value). t := p + (nextPoint value).
			answer add: #q -> {t. cp1}. p := t. cp2 := nil ].
		
		token = 'T' ifTrue: [
			cp1 := (cp1 isNil ifTrue: [ p ] ifFalse: [ p + (p - cp1) ]). t := nextPoint value.
			answer add: #q -> {t. cp1}. p := t. cp2 := nil ].
		token = 't' ifTrue: [ 
			cp1 := (cp1 isNil ifTrue: [ p ] ifFalse: [ p + (p - cp1) ]). t := p + (nextPoint value).
			answer add: #q -> {t. cp1}. p := t. cp2 := nil ].
		
		initialPoint ifNil: [ initialPoint := p ].
 	].
	^ answer asArray
]

{ #category : #actions }
TRSVGPath >> rotateBy: anAngle [
	|center|
	center := self center / scale.
	
	self updateCurves: (self curves collect: [ :c |
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
	| disp |
	disp := (aPoint - position) / scale.
	super translateTo: aPoint.
	self updateCurves: (self curves collect: [ :c |
		c key -> (c value collect: [ :p | p + disp ])]).
	rectangle := rectangle translateBy: disp.
]

{ #category : #'as yet unclassified' }
TRSVGPath >> updateCurves: someCurves [
	curves := someCurves.
	self processCurves.
]
