Class {
	#name : #TRLabelShape,
	#superclass : #TRShape,
	#instVars : [
		'text',
		'font',
		'fontSize'
	],
	#category : #'Trachel-Core'
}

{ #category : #configuration }
TRLabelShape class >> defaultFontSize [
	^ 12
]

{ #category : #configuration }
TRLabelShape class >> getFontForSize: aNumber [

   ^ LogicalFont familyName: StandardFonts defaultFont familyName pointSize: aNumber

]

{ #category : #configuration }
TRLabelShape class >> widthOfText: aString fontSize: aNumber [
	^ (self getFontForSize: aNumber) widthOfString: aString
]

{ #category : #visitor }
TRLabelShape >> accept: aVisitor [
	aVisitor visitLabelShape: self
]

{ #category : #accessing }
TRLabelShape >> ascent [
	^ font ascent
]

{ #category : #accessing }
TRLabelShape >> center [
	^ self position
]

{ #category : #initialization }
TRLabelShape >> defaultFontSize [
	^ self class defaultFontSize
]

{ #category : #accessing }
TRLabelShape >> descent [
	^ font descent
]

{ #category : #drawing }
TRLabelShape >> drawOn: athensCanvas [
	"self drawEncompassingRectangleOn: athensCanvas color: (Color gray alpha: 0.1)."
	athensCanvas pathTransform restoreAfter: [
		"Draw the label centered on the position"
		athensCanvas pathTransform
			translateBy: position asIntegerPoint;
			translateBy: ((self width / -2) @ (self height / 2)) asIntegerPoint;
			translateBy: (0 @ self descent negated) asIntegerPoint.
			"scaleBy: (fontSize / 10)."
		athensCanvas setFont: font.
		athensCanvas setPaint: color.
		athensCanvas drawString: text
		]
]

{ #category : #accessing }
TRLabelShape >> encompassingRectangle [
	| w h |
	w := self width.
	h := self height.
	^ position + ((w / -2) @ (h / -2)) extent: (w @ h)
]

{ #category : #accessing }
TRLabelShape >> font [
	^ font
]

{ #category : #accessing }
TRLabelShape >> fontSize [
	^ fontSize
]

{ #category : #accessing }
TRLabelShape >> fontSize: aNumber [
	font := self class getFontForSize: aNumber.
	fontSize := aNumber
]

{ #category : #accessing }
TRLabelShape >> height [
	^ font height
]

{ #category : #testing }
TRLabelShape >> includesPoint: aPoint [
	^ self encompassingRectangle containsPoint: aPoint
]

{ #category : #initialization }
TRLabelShape >> initialize [
	super initialize.
	text := 'Trachel label'.
	self fontSize: self defaultFontSize
]

{ #category : #public }
TRLabelShape >> leftPosition: aPosition [
	self position: (aPosition - ((self width / -2) @ 0) ) asIntegerPoint
]

{ #category : #accessing }
TRLabelShape >> position [
	^ position
]

{ #category : #accessing }
TRLabelShape >> position: aPosition [
	position := aPosition
]

{ #category : #accessing }
TRLabelShape >> text [
	^ text
]

{ #category : #accessing }
TRLabelShape >> text: aText [
	text := aText
]

{ #category : #public }
TRLabelShape >> text: aText on: aPosition [
	self text: aText.
	self position: aPosition
]

{ #category : #public }
TRLabelShape >> translateBy: step [
	position := position + step.
]

{ #category : #public }
TRLabelShape >> translateTo: aPoint [
	position := aPoint
]

{ #category : #accessing }
TRLabelShape >> width [
	^ (font widthOfString: text)
]
