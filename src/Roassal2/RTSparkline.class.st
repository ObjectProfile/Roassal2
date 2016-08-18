Class {
	#name : #RTSparkline,
	#superclass : #RTAbstractElementShape,
	#instVars : [
		'valueBlock'
	],
	#category : #'Roassal2-Sparkline'
}

{ #category : #initialization }
RTSparkline >> initialize [
	super initialize.
	borderWidth := 1.
	borderColor := Color black.
	self color: Color white
]

{ #category : #public }
RTSparkline >> trachelShapeFor: anElement [
	| shape |
	shape := TRSVGPath new.
	shape strokePaint: (borderColor rtValue: anElement).
	shape borderWidth: (borderWidth rtValue: anElement).
	shape fillColor: (self fillColor rtValue: anElement).
	self updateFor: anElement trachelShape: shape.
	^ shape
]

{ #category : #hooks }
RTSparkline >> updateFor: element trachelShape: trachelShape [

	| vs p path x y stepHorizontal stepVertical w h min max ny |
	vs := self valuesFor: element.
	w := self widthFor: element.
	h := self heightFor: element.
	stepHorizontal := w / vs size.
	min := vs min.
	max := vs max.
	stepVertical := h / (max - min + 1).
	
	p := (element position - ((w / 2) @ (h negated / 2))).
	x := p x.
	y := p y.
	ny := vs first - min * stepVertical.
	path := 'M', x asFloat asString, ',', (y - ny) asFloat asString.
	
	vs size = 1
		ifTrue: [ 
			x := x + stepHorizontal.
			path := path, 'L', x asFloat asString, ',', (y - ny) asFloat asString ]
	
		ifFalse: [
			vs allButFirstDo: [ :v |
				x := x + stepHorizontal.
				ny := (v - min * stepVertical).
				path := path, 'L', x asFloat asString, ',', (y - ny) asFloat asString.
			] ].
	trachelShape resetPath.
	trachelShape path: path.
	
	"We manually specify the extent of the shape. If we do not do it, then the path will be used to determine the encompassing rectangle"
	trachelShape setExtent: w @ h
	
	
]

{ #category : #accessing }
RTSparkline >> values: aBlockOrASymbol [
	valueBlock := aBlockOrASymbol
]

{ #category : #querying }
RTSparkline >> valuesFor: anElement [
	^ valueBlock rtValue: anElement model
]
