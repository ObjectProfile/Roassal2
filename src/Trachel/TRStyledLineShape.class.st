"
A DCTRStyledLineShape is line with possibility of being dashed, dotted, etc.

solid - dashes: nil
dotted - dashes: #(""fill"" 1 ""gap"" 2)
dashed - dashes: #(""fill"" 6 ""gap"" 4)
dashdot - dashes: #(""fill"" 6 ""gap"" 3 ""fill"" 1 ""gap"" 3)
"
Class {
	#name : #TRStyledLineShape,
	#superclass : #TRLineShape,
	#instVars : [
		'dashes'
	],
	#category : #'Trachel-Shapes'
}

{ #category : #drawing }
TRStyledLineShape >> dashes: anArrayOfNumeric [
	dashes := anArrayOfNumeric
]

{ #category : #drawing }
TRStyledLineShape >> drawOn: athensCanvas [
	athensCanvas pathTransform
		restoreAfter: [ 
			athensCanvas setShape: self path.
			(athensCanvas setStrokePaint: color)
				width: width;
				dashes: dashes offset: 0.
			athensCanvas draw ]
]
