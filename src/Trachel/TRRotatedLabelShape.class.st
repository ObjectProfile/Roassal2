Class {
	#name : #TRRotatedLabelShape,
	#superclass : #TRLabelShape,
	#instVars : [
		'angle'
	],
	#category : #'Trachel-Core'
}

{ #category : #accessing }
TRRotatedLabelShape >> angleInDegree: anAngle [
	angle := anAngle
]

{ #category : #drawing }
TRRotatedLabelShape >> drawOn: athensCanvas [
	"self drawEncompassingRectangleOn: athensCanvas color: (Color green alpha: 0.1)."
	athensCanvas pathTransform restoreAfter: [
		"Draw the label centered on the position"
		athensCanvas pathTransform 
			translateBy: position asIntegerPoint;
			rotateByDegrees: angle;
			translateBy: ((self notRotatedWidth / -2) @ (self notRotatedHeight / 2)) asIntegerPoint;
			translateBy: (0 @ font descent negated) asIntegerPoint.
		athensCanvas setFont: font.
		athensCanvas setPaint: color.
		athensCanvas drawString: text
	].
]

{ #category : #accessing }
TRRotatedLabelShape >> encompassingRectangle [

	| w h transformation translation notRotatedRectangle rotatedRectangle topLeft topRight bottomRight bottomLeft |
	w := self notRotatedWidth.
	h := self notRotatedHeight.
	transformation := AthensAffineTransform new 
						rotateByDegrees: angle;
						translateBy: ((w / -2) @ (h / 2)) asIntegerPoint.
	notRotatedRectangle  := 0 @ h negated corner: (w @ 0).
	topLeft := transformation transform: notRotatedRectangle topLeft.
	topRight := transformation transform: notRotatedRectangle topRight.
	bottomRight := transformation transform: notRotatedRectangle bottomRight.
	bottomLeft := transformation transform: notRotatedRectangle bottomLeft.
	rotatedRectangle := 
		({ topLeft x. topRight x. bottomRight x. bottomLeft x} min @
		{ topLeft y. topRight y. bottomRight y. bottomLeft y} min) corner:
		({ topLeft x. topRight x. bottomRight x. bottomLeft x} max @
		{ topLeft y. topRight y. bottomRight y. bottomLeft y} max).
	translation := AthensAffineTransform new
					translateBy: position asIntegerPoint.
	^ (translation transform: rotatedRectangle topLeft)
	 	corner: (translation transform: rotatedRectangle bottomRight)
	
]

{ #category : #accessing }
TRRotatedLabelShape >> height [

	^ self encompassingRectangle height
]

{ #category : #initialization }
TRRotatedLabelShape >> initialize [
	super initialize.
	angle := 0.
]

{ #category : #accessing }
TRRotatedLabelShape >> notRotatedHeight [
	^ font height
]

{ #category : #accessing }
TRRotatedLabelShape >> notRotatedWidth [
	^ (font widthOfString: text)
]

{ #category : #accessing }
TRRotatedLabelShape >> width [

	^ self encompassingRectangle width
]
