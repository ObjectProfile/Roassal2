Class {
	#name : #TRMorph,
	#superclass : #Morph,
	#instVars : [
		'trachelCanvas',
		'surface'
	],
	#category : #Trachel
}

{ #category : #'as yet unclassified' }
TRMorph >> canvas: aTrachelCanvas [
	trachelCanvas := aTrachelCanvas.
	surface := AthensCairoSurface extent: aTrachelCanvas extent
]

{ #category : #'as yet unclassified' }
TRMorph >> drawOn: aCanvas [
	"aCanvas is a form canvas"
	
	surface drawDuring: [:cs |
		surface clear.
		
		"cs pathTransform 
			scaleBy: 1.0."
		trachelCanvas shapes do: [ :trachelShape |
			trachelShape drawOn: cs.
		]
	].
	"aCanvas fillRectangle: self bounds color: Color blue."
	
	aCanvas translucentImage: surface asForm at: self bounds origin.
]

{ #category : #'as yet unclassified' }
TRMorph >> initialize [
	super initialize.
	
	surface := AthensCairoSurface extent: 500 @ 500.
	"session := Smalltalk session."
	
	
]
