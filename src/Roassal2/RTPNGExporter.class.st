Class {
	#name : #RTPNGExporter,
	#superclass : #RTObject,
	#instVars : [
		'view',
		'fileName'
	],
	#category : #'Roassal2-Exporter-PNG'
}

{ #category : #accessing }
RTPNGExporter >> builder [
	^ view
]

{ #category : #accessing }
RTPNGExporter >> builder: anObject [
	view := anObject
]

{ #category : #public }
RTPNGExporter >> exportToFile [
	| trachelCanvas form session surface |
	trachelCanvas := self builder view canvas.
	form := FormCanvas extent: (trachelCanvas encompassingRectangle) extent.
	session := Smalltalk session.
	surface := AthensCairoSurface extent: (trachelCanvas encompassingRectangle extent) asIntegerPoint.
	form fillRectangle: trachelCanvas encompassingRectangle color: trachelCanvas color.
	"The drawing has to be done when a change in the shapes occured or when there is an animation."
	surface drawDuring: [:cs |
		surface clear.
		"We display the elements that are subject to the camera"
		trachelCanvas shapes do: [ :trachelShape |
			trachelShape drawOn: cs.
		].
		"We display the elements that are _NOT_ subject to the camera"
		trachelCanvas fixedShapes do: [ :trachelShape |
			trachelShape drawOn: cs.
		].
	].
	"aCanvas translucentImage: surface asForm at: self bounds origin."
	"asForm creates a new Form, which is likely to be expensive. This can be cached"
	form image: surface asForm at: trachelCanvas encompassingRectangle origin sourceRect: (0 @ 0 extent: surface extent) rule: 34.
	surface writeToPng: self fileName
]

{ #category : #accessing }
RTPNGExporter >> fileName [
	^ fileName
]

{ #category : #accessing }
RTPNGExporter >> fileName: anObject [
	fileName := anObject
]
