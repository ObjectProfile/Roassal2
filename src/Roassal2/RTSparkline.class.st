Class {
	#name : #RTSparkline,
	#superclass : #RTAbstractElementShape,
	#instVars : [
		'valueBlock',
		'borderWidth'
	],
	#category : #'Roassal2-Sparkline'
}

{ #category : #'as yet unclassified' }
RTSparkline >> initialize [
	super initialize.
	borderWidth := 1.
	borderColor := Color black.
	self color: Color white
]

{ #category : #'as yet unclassified' }
RTSparkline >> trachelShapeFor: anElement [
	| shape |
	shape := TRSVGPath new.
	shape strokePaint: (borderColor rtValue: anElement).
	shape borderWidth: (borderWidth rtValue: anElement).
	shape fillColor: (self fillColor rtValue: anElement).
	self updateFor: anElement trachelShape: shape.
	^ shape
]

{ #category : #'as yet unclassified' }
RTSparkline >> updateFor: element trachelShape: trachelShape [

	| vs p path x y stepHorizontal stepVertical w h min max ny |
	vs := self valuesFor: element.
	w := self widthFor: element.
	h := self heightFor: element.
	stepHorizontal := w / vs size.
	min := vs min.
	max := vs max.
	stepVertical := h / (max - min).
	
	p := (element position - ((w / 2) @ (h negated / 2))) asIntegerPoint.
	path := 'M', p x asString, ',', p y asString.

	x := p x.
	y := p y.
	
	vs do: [ :v |
		x := x + stepHorizontal.
		ny := (v * stepVertical).
		path := path, 'L', x asInteger asString, ',', (y - ny) asInteger asString.
	].
	trachelShape resetPath.
	trachelShape path: path.
	
	
]

{ #category : #'as yet unclassified' }
RTSparkline >> values: aBlockOrASymbol [
	valueBlock := aBlockOrASymbol
]

{ #category : #'as yet unclassified' }
RTSparkline >> valuesFor: anElement [
	^ valueBlock rtValue: anElement model
]
