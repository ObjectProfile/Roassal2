Class {
	#name : #ColorPaletteTest,
	#superclass : #TestCase,
	#category : #'Roassal2-ColorNormalizer'
}

{ #category : #tests }
ColorPaletteTest >> testDiverging [
	| palette c c2 |
	palette := ColorPalette diverging.

	self assert: (palette colors: 11 scheme: 'RdGy') size equals: 11.
	c := (palette colors: 11 scheme: 'RdGy') first.
	c2 := Color colorFrom: '#67001F'.
	self assert: (c closeTo: c2).
	
	self assert: (palette colors: 6 scheme: 'RdGy') size equals: 6.
	c := (palette colors: 6 scheme: 'RdGy') second.
	c2 := Color colorFrom: '#EF8A62'.
	c assert: (c closeTo: c2)
	
]

{ #category : #tests }
ColorPaletteTest >> testQualitative [
	|palette |
	palette := ColorPalette qualitative.
	
	
	self assert: (palette colors: 9 scheme: 'Set1') size equals: 9.
	self assert: (palette colors: 3 scheme: 'Set1') size equals: 3.
]

{ #category : #tests }
ColorPaletteTest >> testQualitativeError [
	|palette |
	palette := ColorPalette qualitative.
	
	
	self should: [palette colors: 1 scheme: 'Set1'] raise: Error.
	self should: [palette colors: 80 scheme: 'Set1'] raise: Error.
	self should: [palette colors: 9 scheme: 'Pastel2'] raise: Error.
]

{ #category : #tests }
ColorPaletteTest >> testSequential [
	| palette c1 c2 |
	palette := ColorPalette sequential.

	self assert: (palette colors: 3 scheme: 'Purples') size equals: 3.
	c1 := (palette colors: 3 scheme: 'Purples') first.
	c2 := Color colorFrom: '#EFEDF5'.
	self assert: (c1 closeTo: c2).
	
	c1 := (palette colors: 3 scheme: 'Purples') second.
	c2 := Color colorFrom: '#BCBDDC'.
	self assert: (c1 closeTo: c2).
	
	c1 := (palette colors: 3 scheme: 'Purples') third.
	c2 := Color colorFrom: '#756BB1'.
	self assert: (c1 closeTo: c2).

]
