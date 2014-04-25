Class {
	#name : #ColorPaletteTest,
	#superclass : #TestCase,
	#category : #'Roassal2-ColorNormalizer'
}

{ #category : #'as yet unclassified' }
ColorPaletteTest >> testDiverging [
	|palette |
	palette := ColorPalette diverging.
	
	
	self assert: (palette colors: 11 scheme: 'RdGy') size equals: 11.
	self assert: (palette colors: 11 scheme: 'RdGy') first asHTMLColor equals: '#67001F'.
	
	self assert: (palette colors: 6 scheme: 'RdGy') size equals: 6.
	self assert: (palette colors: 6 scheme: 'RdGy') second asHTMLColor equals: '#EF8A62'.
]

{ #category : #'as yet unclassified' }
ColorPaletteTest >> testDivergingError [
	|palette |
	palette := ColorPalette diverging.
	
	
	self assert: (palette colors: 11 scheme: 'RdGy') size equals: 11.
	self assert: (palette colors: 11 scheme: 'RdGy') first asHTMLColor equals: '#67001F'.
	
	self assert: (palette colors: 6 scheme: 'RdGy') size equals: 6.
	self assert: (palette colors: 6 scheme: 'RdGy') second asHTMLColor equals: '#EF8A62'.
]

{ #category : #'as yet unclassified' }
ColorPaletteTest >> testQualitative [
	|palette |
	palette := ColorPalette qualitative.
	
	
	self assert: (palette colors: 9 scheme: 'Set1') size equals: 9.
	self assert: (palette colors: 3 scheme: 'Set1') size equals: 3.
]

{ #category : #'as yet unclassified' }
ColorPaletteTest >> testQualitativeError [
	|palette |
	palette := ColorPalette qualitative.
	
	
	self should: [palette colors: 1 scheme: 'Set1'] raise: Error.
	self should: [palette colors: 80 scheme: 'Set1'] raise: Error.
	self should: [palette colors: 9 scheme: 'Pastel2'] raise: Error.
]

{ #category : #'as yet unclassified' }
ColorPaletteTest >> testSequential [
	|palette |
	palette := ColorPalette sequential.

	self assert: (palette colors: 3 scheme: 'Purples') size equals: 3.
	self assert: (palette colors: 3 scheme: 'Purples') first asHTMLColor equals: '#efedf5' asUppercase.
	self assert: (palette colors: 3 scheme: 'Purples') second asHTMLColor equals: '#bcbddc' asUppercase.
	self assert: (palette colors: 3 scheme: 'Purples') third asHTMLColor equals: '#756bb1' asUppercase.
			
"	self assert: (palette colors: 6 scheme: 'RdGy') size equals: 6.
	self assert: (palette colors: 6 scheme: 'RdGy') second asHTMLColor equals: '#EF8A62'."
]
