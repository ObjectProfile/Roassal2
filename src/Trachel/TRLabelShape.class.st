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

{ #category : #private }
TRLabelShape >> basicEncompassingRectangle [
	| w h |
	w := self textWidth.
	h := self textHeight.
	^ ((w / -2) @ (h / -2)) extent: (w @ h)
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
	"self drawEncompassingRectangleOn: athensCanvas."
	athensCanvas pathTransform restoreAfter: [
		"Draw the label centered on the position"
		athensCanvas pathTransform
			multiplyBy: matrix asFloatTransform;
			translateBy: ((self textWidth / -2) @ (self textHeight / 2)) asFloatPoint;
			translateBy: (0 @ self descent negated) asFloatPoint.
		athensCanvas setFont: font.
		athensCanvas setPaint: color.
		athensCanvas drawString: text
	]
]

{ #category : #accessing }
TRLabelShape >> encompassingRectangle [
	^ self transformedEncompassingRectangle 
]

{ #category : #accessing }
TRLabelShape >> extent [
	^ self encompassingRectangle extent
]

{ #category : #accessing }
TRLabelShape >> extent: newExtent [
	"Labels cannot have their extent changed."
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

	^ self encompassingRectangle height
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

{ #category : #private }
TRLabelShape >> textHeight [
	"without any transformation"
	^ font height
]

{ #category : #private }
TRLabelShape >> textWidth [
	"without any transformation"
	^ (font widthOfString: text)
]

{ #category : #public }
TRLabelShape >> translateLeftTo: aPosition [
	self translateTo: (aPosition - ((self width / -2) @ 0) ) asIntegerPoint
]

{ #category : #public }
TRLabelShape >> translateRightTo: aPosition [
	self translateTo: (aPosition + ((self width / -2) @ 0) ) asIntegerPoint
]

{ #category : #accessing }
TRLabelShape >> width [

	^ self encompassingRectangle width
]
