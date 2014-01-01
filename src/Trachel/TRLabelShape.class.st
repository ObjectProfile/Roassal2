Class {
	#name : #TRLabelShape,
	#superclass : #TRShape,
	#instVars : [
		'text',
		'position',
		'font'
	],
	#category : #Trachel
}

{ #category : #drawing }
TRLabelShape >> drawOn: athensCanvas [
 
	athensCanvas pathTransform restoreAfter: [
		"Draw the label centered on the position"
		athensCanvas pathTransform 
			translateBy: position + ((self width / -2) @ (self height / 2)) asIntegerPoint;
			scaleBy: 2.
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
	^ (position - ((w @ h) / 2)) extent: (w @ h)
]

{ #category : #accessing }
TRLabelShape >> font [
	^ font
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
	position := 0 @ 0.
	text := 'Trachel label'.
	font := LogicalFont familyName: 'Arial' pointSize: 20.
]

{ #category : #public }
TRLabelShape >> leftPosition: aPosition [
	self position: (aPosition - ((self width / -2) @ 0) ) asIntegerPoint
]

{ #category : #accessing }
TRLabelShape >> position: aPosition [
	position := aPosition
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
	^ (font widthOfString: text) * 2
]
