Class {
	#name : #TRRotatedLabelShape,
	#superclass : #TRLabelShape,
	#instVars : [
		'angle'
	],
	#category : #Trachel
}

{ #category : #'as yet unclassified' }
TRRotatedLabelShape >> angleInDegree: anAngle [
	angle := anAngle
]

{ #category : #'as yet unclassified' }
TRRotatedLabelShape >> drawOn: athensCanvas [
 	| t tpath b |
	
	tpath := athensCanvas
		createPath: [ :builder | 
			builder
				absolute;
				moveTo: -1 @ -1;
				lineTo: 1 @ -1;
				lineTo: 1 @ 1;
				lineTo: -1 @ 1;
				lineTo: -1 @ -1 ].
	b := self encompassingRectangle.
	athensCanvas pathTransform
		restoreAfter: [ 
			athensCanvas pathTransform
				translateBy: (b center  ) asIntegerPoint;
				scaleBy: (b extent / 2) abs asIntegerPoint.
			athensCanvas
				setPaint: (Color blue alpha: 0.1);
				drawShape: tpath ].


	
	
	
	t := position asIntegerPoint + ((self width / -2) @ (self height / 2)) asIntegerPoint.
	athensCanvas pathTransform restoreAfter: [
		"Draw the label centered on the position"
		athensCanvas pathTransform 
			translateBy: position asIntegerPoint;
					rotateByDegrees: angle;
			translateBy: ((self width / -2) @ (self height / 2)) asIntegerPoint.

			
			"scaleBy: (fontSize / 10)."
		athensCanvas setFont: font.
		athensCanvas setPaint: color.
		athensCanvas drawString: text
		].



]

{ #category : #'as yet unclassified' }
TRRotatedLabelShape >> encompassingRectangle [

	| transformation notRotatedRectangle topLeft bottomRight |
	transformation := AthensAffineTransform new
								
								translateBy: ((self width / -2) @ (self height / 2)) asIntegerPoint;
								rotateByDegrees: angle negated; 
								
								translateBy: position asIntegerPoint
								
								.

	notRotatedRectangle  := super encompassingRectangle.
	topLeft := transformation transform: notRotatedRectangle topLeft.
	bottomRight := transformation transform: notRotatedRectangle bottomRight.
	^ topLeft extent: bottomRight

	
]

{ #category : #'as yet unclassified' }
TRRotatedLabelShape >> initialize [
	super initialize.
	angle := 0.
]
