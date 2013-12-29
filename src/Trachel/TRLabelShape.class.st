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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
TRLabelShape >> encompassingRectangle [
	| w h |
	w := self width.
	h := self height.
	^ (position - ((w @ h) / 2)) extent: (w @ h)
]

{ #category : #'as yet unclassified' }
TRLabelShape >> font [
	^ font
]

{ #category : #'as yet unclassified' }
TRLabelShape >> height [
	^ font height
]

{ #category : #'as yet unclassified' }
TRLabelShape >> initialize [
	super initialize.
	position := 0 @ 0.
	text := 'Trachel label'.
	font := LogicalFont familyName: 'Arial' pointSize: 20.
]

{ #category : #'as yet unclassified' }
TRLabelShape >> position: aPosition [
	position := aPosition
]

{ #category : #'as yet unclassified' }
TRLabelShape >> text: aText [
	text := aText
]

{ #category : #'as yet unclassified' }
TRLabelShape >> text: aText on: aPosition [
	self text: aText.
	self position: aPosition
]

{ #category : #'as yet unclassified' }
TRLabelShape >> width [
	^ font widthOfString: text
]
