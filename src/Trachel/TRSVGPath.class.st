Class {
	#name : #TRSVGPath,
	#superclass : #TRShape,
	#instVars : [
		'borderWidth',
		'fillColor',
		'pathString',
		'curves',
		'polygons',
		'rectangle'
	],
	#category : #'Trachel-Shapes'
}

{ #category : #visitor }
TRSVGPath >> accept: aVisitor [
	aVisitor visitSVGPath: self
]

{ #category : #private }
TRSVGPath >> basicEncompassingRectangle [
	^ rectangle
]

{ #category : #accessing }
TRSVGPath >> borderWidth: width [
	borderWidth := width.
]

{ #category : #accessing }
TRSVGPath >> center [
	^ self encompassingRectangle center 
]

{ #category : #accessing }
TRSVGPath >> centeredPath: aPathString [
	self path: aPathString.
	self correctCurvesAndPolygonsToZero.
]

{ #category : #accessing }
TRSVGPath >> color [
	^ fillColor
]

{ #category : #accessing }
TRSVGPath >> color: aColor [
	^ self fillColor: aColor
]

{ #category : #private }
TRSVGPath >> computeCurves [
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
	
	pathWithSpaceBeforeMinus := pathString copyReplaceAll: '-' with: ' -' asTokens: false.
	tokens := pathWithSpaceBeforeMinus findTokens: 'AaMmLlZzCcSsQqTtHhVv, ' keep: 'AaMmLlZzCcSsQqTtHhVv'.
	
	stream := ReadStream on: tokens.
	nextPoint := [ (Float readFrom: stream next) @ (Float readFrom: stream next) ].
	
	[ stream atEnd ] whileFalse: [ 
		token := stream next.
		token = 'M' ifTrue: [ p := nextPoint value. answer add: #m -> (Array with: p). initialPoint := nil. cp1 := nil. cp2 := nil ].
		token = 'm' ifTrue: [ p := p + (nextPoint value). answer add: #m -> (Array with: p). initialPoint := nil. cp1 := nil. cp2 := nil ].

		(token = 'Z' or: [ token = 'z' ]) ifTrue: [ answer add: #l -> (Array with: initialPoint). initialPoint := nil ].

		token = 'L' ifTrue: [ t := nextPoint value. answer add: #l -> (Array with: t). p := t. cp1 := nil. cp2 := nil ].
		token = 'l' ifTrue: [ t := p + (nextPoint value). answer add: #l -> (Array with: t). p := t. cp1 := nil. cp2 := nil ].
		
		token = 'V' ifTrue: [ t := (p x) @ (Float readFrom: stream next). answer add: #l -> (Array with: t). p := t. cp1 := nil. cp2 := nil ].
		token = 'v' ifTrue: [ t := p + (0 @ (Float readFrom: stream next)). answer add: #l -> (Array with: t). p := t. cp1 := nil. cp2 := nil ].
		
		token = 'H' ifTrue: [ t := (Float readFrom: stream next) @ (p y). answer add: #l -> (Array with: t). p := t. cp1 := nil. cp2 := nil ].
		token = 'h' ifTrue: [ t := p + ((Float readFrom: stream next) @ 0). answer add: #l -> (Array with: t). p := t. cp1 := nil. cp2 := nil ].
		
		token = 'C' ifTrue: [
			cp1 := nextPoint value. cp2 := nextPoint value.
			t := nextPoint value.
			answer add: #c -> (Array with: t with: cp1 with: cp2). p := t. cp1 := nil ].
		token = 'c' ifTrue: [ 
			cp1 := p + (nextPoint value). cp2 := p + (nextPoint value).
			t := p + (nextPoint value).
			answer add: #c -> (Array with: t with: cp1 with: cp2). p := t. cp1 := nil ].
		
		token = 'S' ifTrue: [ 
			cp1 := (cp2 isNil ifTrue: [ p ] ifFalse: [ p + (p - cp2) ]). cp2 := nextPoint value.
			t := nextPoint value.
			answer add: #c -> (Array with: t with: cp1 with: cp2). p:= t. cp1 := nil ].
		token = 's' ifTrue: [ 
			cp1 := (cp2 isNil ifTrue: [ p ] ifFalse: [ p + (p - cp2) ]). cp2 := p + nextPoint value.
			t := p + nextPoint value.
			answer add: #c -> (Array with: t with: cp1 with: cp2 ). p:= t. cp1 := nil ].
		
		token = 'Q' ifTrue: [
			cp1 := nextPoint value. t := nextPoint value.
			answer add: #q -> (Array with: t with: cp1). p := t. cp2 := nil ].
		token = 'q' ifTrue: [ 
			cp1 := p + (nextPoint value). t := p + (nextPoint value).
			answer add: #q -> (Array with: t with: cp1). p := t. cp2 := nil ].
		
		token = 'A' ifTrue: [ self halt. ].
		token = 'a' ifTrue: [ | r xAxisRot largeArcFlag sweepFlag angle flag |
			r := nextPoint value.
			xAxisRot := (Float readFrom: stream next).
			largeArcFlag := (Float readFrom: stream next).
			sweepFlag := (Float readFrom: stream next).
			t := p + (nextPoint value).
			angle := 10.
			flag := false.
			answer add: #a -> (Array with: t with: angle with: flag).
			p := t. cp2 := nil. cp1 := nil. ].
		
		token = 'T' ifTrue: [
			cp1 := (cp1 isNil ifTrue: [ p ] ifFalse: [ p + (p - cp1) ]). t := nextPoint value.
			answer add: #q -> (Array with: t with: cp1). p := t. cp2 := nil ].
		token = 't' ifTrue: [ 
			cp1 := (cp1 isNil ifTrue: [ p ] ifFalse: [ p + (p - cp1) ]). t := p + (nextPoint value).
			answer add: #q -> (Array with: t with: cp1). p := t. cp2 := nil ].
		
		initialPoint ifNil: [ initialPoint := p ].
 	].
	curves := answer asArray
]

{ #category : #hooks }
TRSVGPath >> computePath [
	path := (self athensCanvas createPath: [ :builder |
			builder absolute.
			curves do: [ :c |
				c key = #m ifTrue: [ builder moveTo: (c value at: 1) ].
				c key = #l ifTrue: [ builder lineTo: (c value at: 1) ].
				c key = #c ifTrue: [ builder curveVia: (c value at: 2) and: (c value at: 3) to: (c value at: 1) ].
				c key = #q ifTrue: [ builder curveVia: (c value at: 2) to: (c value at: 1) ]. ]
		])
]

{ #category : #private }
TRSVGPath >> computePolygons [
	| separatedPaths |
	separatedPaths := self separateSubPaths.
	polygons := OrderedCollection new.
	separatedPaths
		do: [ :eachPath | 
			| eachPolygon |
			eachPolygon := OrderedCollection new.
			eachPath
				do: [ :curve | 
					curve key = 'm'
						ifFalse: [ eachPolygon add: curve value first ] ].
			polygons add: eachPolygon ].	
]

{ #category : #private }
TRSVGPath >> computeRectangle [
	| allPoints |
	allPoints := polygons inject: #() into: [ :acc :next | acc , next ].
	rectangle := Rectangle encompassing: allPoints.
	^ allPoints
]

{ #category : #private }
TRSVGPath >> correctCurvesAndPolygonsToZero [
	"Center of polygons is stored in originalPosition and the center is moved to 0@0."
	| originalPosition |
	self computeRectangle.
	originalPosition := rectangle center.
	curves
		do: [ :eachCurve | eachCurve value doWithIndex: [ :eachPoint :index | eachCurve value at: index put: eachPoint - originalPosition ] ].
	polygons
		do: [ :eachPolygon | eachPolygon doWithIndex: [ :eachPoint :index | eachPolygon at: index put: eachPoint - originalPosition ] ].
	self computeRectangle.
]

{ #category : #accessing }
TRSVGPath >> curves [
	curves isNil ifFalse: [ ^ curves ].
	self computeCurves.
	self computePolygons.
	^ curves
]

{ #category : #accessing }
TRSVGPath >> curves: anArray [
	curves := anArray.
	self computePolygons.
	
]

{ #category : #drawing }
TRSVGPath >> drawOn: aCanvas [
	| pt |
	pt := aCanvas pathTransform.
	pt restoreAfter: [
		pt multiplyBy: matrix asFloatTransform.
		aCanvas setShape: self path.
		fillColor isNotNil ifTrue: [ aCanvas setPaint: fillColor; draw ].
		(aCanvas setStrokePaint: strokePaint) width: borderWidth.
		aCanvas draw
	]
]

{ #category : #accessing }
TRSVGPath >> encompassingRectangle [
	^ self transformedEncompassingRectangle
]

{ #category : #accessing }
TRSVGPath >> extent [
	^ rectangle extent.
]

{ #category : #accessing }
TRSVGPath >> fillColor: aColor [
	fillColor := aColor
]

{ #category : #accessing }
TRSVGPath >> height [
	^ self encompassingRectangle height
]

{ #category : #testing }
TRSVGPath >> includesPoint: aPoint [
	|apt invertedPoint |
	invertedPoint := matrix inverseTransform: aPoint.
	apt := AthensPolygonTester new.
	^ polygons anySatisfy: [ :eachPolygon | ((apt polygon: eachPolygon) includesPoint: invertedPoint) ]
]

{ #category : #initialization }
TRSVGPath >> initialize [
	super initialize.
	polygons := #().
	borderWidth := 0.
	fillColor := Color black.
	rectangle := Rectangle origin: 0@0 corner: 0@0.
]

{ #category : #accessing }
TRSVGPath >> path: aPathString [
	pathString := aPathString.
	curves := nil.
	self curves.
	self computeRectangle.
]

{ #category : #accessing }
TRSVGPath >> pathString [
	^ pathString
]

{ #category : #actions }
TRSVGPath >> reset [
	super resetPath.
	curves := nil
]

{ #category : #private }
TRSVGPath >> separateSubPaths [
	| separatedPaths subPath |
	separatedPaths := OrderedCollection new.
	subPath := OrderedCollection new.
	
	curves do: [ :c |
		c key = 'm' ifTrue: [ 
			subPath ifNotEmpty: [ separatedPaths add: subPath ]. 
			subPath:= OrderedCollection new ].
		subPath add: c.
	].
	separatedPaths add: subPath.
	^ separatedPaths
]

{ #category : #accessing }
TRSVGPath >> setExtent: anExtent [

	rectangle := rectangle topLeft extent: anExtent
]

{ #category : #accessing }
TRSVGPath >> strokeWidth [
	^ borderWidth
]

{ #category : #accessing }
TRSVGPath >> width [
	^ self encompassingRectangle width
]
