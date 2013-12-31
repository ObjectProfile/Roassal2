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
		athensCanvas pathTransform 
			translateBy: position;
			scaleBy: 2.
		athensCanvas setFont: font.
		athensCanvas setPaint: Color black.
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

{ #category : #initialization }
TRLabelShape >> initialize [
	super initialize.
	position := 0 @ 0.
	text := 'Trachel label'.
	font := LogicalFont familyName: 'Arial' pointSize: 20.
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

{ #category : #accessing }
TRLabelShape >> width [
	^ (font widthOfString: text) * 2
]
