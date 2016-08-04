"
I am a simple label shape to draw text with the command textPath:
"
Class {
	#name : #TRTextPath,
	#superclass : #TRLabelShape,
	#instVars : [
		'outlineColor',
		'outlineWidth'
	],
	#category : #'Roassal2-Experimental'
}

{ #category : #drawing }
TRTextPath >> drawOn: athensCanvas [
	| f |
	athensCanvas pathTransform restoreAfter: [ 
		athensCanvas pathTransform
			multiplyBy: matrix asFloatTransform;
			translateBy: ((self textWidth / -2) @ (self textHeight/2)) asFloatPoint;
			translateBy: (0 @ self descent negated) asFloatPoint.
		athensCanvas setFont: font.
		f := CairoScaledFont fromFreetypeFont: font realFont.
		f lock.
		color loadOnCairoCanvas: athensCanvas.
		athensCanvas setPathMatrix;
			setScaledFont: f.
		athensCanvas textPath: text.
		athensCanvas fillPreserve.
		outlineColor loadOnCairoCanvas: athensCanvas.
		athensCanvas primSetLineWidth: outlineWidth asFloat.
		athensCanvas stroke.
		f unlock ]
]

{ #category : #accessing }
TRTextPath >> outlineColor [
	^ outlineColor
]

{ #category : #accessing }
TRTextPath >> outlineColor: aColor [
	outlineColor:= aColor
]

{ #category : #accessing }
TRTextPath >> outlineWidth [
	^ outlineWidth
]

{ #category : #accessing }
TRTextPath >> outlineWidth: aNumber [
	outlineWidth := aNumber
]
