"
A DCTRCanvasExporter is exporter of canvas into image
	
	supported formats: png, jpg, jpeg, bmp, gif	
	usage example:

	(DCTRCanvasExporter canvas: roassalView canvas)
		withoutFixedShapes;
		whole;
		defaultScale;
		oversizedBy: 20 @ 20;
		format: #png;
		fileName: ((UIManager default request: 'Please enter file name' initialAnswer: 'export.png') ifNil: [ ^ nil ]);
		export
"
Class {
	#name : #DCTRCanvasExporter,
	#superclass : #RTObject,
	#instVars : [
		'canvas',
		'fileName',
		'imageExporter',
		'format',
		'bounds',
		'oversize'
	],
	#category : #'Roassal2-Exporter-PNG'
}

{ #category : #initialization }
DCTRCanvasExporter class >> canvas: aCanvas [
	^ self new
		canvas: aCanvas;
		yourself
]

{ #category : #private }
DCTRCanvasExporter >> cameraScale [
	^ canvas camera scale
]

{ #category : #private }
DCTRCanvasExporter >> cameraScale: aScale [
	canvas camera doWithoutCallbacks: [ canvas camera scale: aScale ]
]

{ #category : #settings }
DCTRCanvasExporter >> canvas: aCanvas [
	"sets canvas for export, resets all settings"

	canvas := aCanvas veryDeepCopy.
	canvas morph
		ifNil: [ 
			canvas buildMorph.
			self whole ]
]

{ #category : #settings }
DCTRCanvasExporter >> centered [
	canvas camera doWithoutCallbacks: [ canvas camera focusOnCenter ]
]

{ #category : #settings }
DCTRCanvasExporter >> defaultScale [
	self scale: 1.0001
]

{ #category : #example }
DCTRCanvasExporter >> example01 [
	| b view |
	b := RTMondrian new.
	b nodes: RTShape withAllSubclasses.
	b edges connectFrom: #superclass.
	b layout tree.
	b build.
	
	view := b view.
	(DCTRCanvasExporter canvas: view canvas)
		withoutFixedShapes;
		whole;
		defaultScale;
		oversizedBy: 20 @ 20;
		format: #png;
		fileName: ((TRPlatform current dialogRequest: 'Please enter file name' initialAnswer: 'export.png') ifNil: [ ^ nil ]);
		export
]

{ #category : #export }
DCTRCanvasExporter >> export [
	canvas ifNil: [ self error: 'No canvas selected' ].
	fileName ifNil: [ self error: 'File name not set' ].
	self extent: self extent + (self cameraScale * oversize).
	self scaleToMorphLimits.
	imageExporter putForm: canvas morph imageForm onFileNamed: fileName
]

{ #category : #private }
DCTRCanvasExporter >> extent [
	^ canvas morph extent
]

{ #category : #private }
DCTRCanvasExporter >> extent: anExtent [
	canvas morph extent: anExtent
]

{ #category : #settings }
DCTRCanvasExporter >> fileName: aFileName [
	fileName := aFileName
]

{ #category : #settings }
DCTRCanvasExporter >> format: imageFormat [
	"supported formats: png, jpg, jpeg, bmp, gif	
	usage examples:
		format: 'png'
 		format: #png"

	| imageFormatUC |
	format := imageFormat.
	imageFormatUC := imageFormat asUppercase.
	imageExporter := (imageFormatUC = #JPEG or: imageFormatUC = #JPG)
		ifTrue: [ PluginBasedJPEGReadWriter ]
		ifFalse: [ Smalltalk at: (imageFormatUC , 'ReadWriter') asSymbol ]
]

{ #category : #initialization }
DCTRCanvasExporter >> initialize [
	self
		format: #png;
		fileName: [ ('export.' , format) asSymbol ];
		oversizedBy: 0 @ 0
]

{ #category : #settings }
DCTRCanvasExporter >> oversizedBy: anExtent [
	oversize := anExtent
]

{ #category : #settings }
DCTRCanvasExporter >> scale: aScale [
	"1 = defaultScale"

	self
		extent: self extent * aScale / self cameraScale;
		cameraScale: aScale
]

{ #category : #private }
DCTRCanvasExporter >> scaleToMorphLimits [
	"scale down to estimated morph (maxWidthAndHeight) and exporter (maxArea) size limits"

	| maxArea maxWidthAndHeight |
	maxArea := 32000000.
	maxWidthAndHeight := 10000.
	self extent x * self extent y > maxArea
		ifTrue: [ self scale: (maxArea / (self extent x * self extent y)) sqrt * self cameraScale ].
	self extent x > maxWidthAndHeight
		ifTrue: [ self scale: maxWidthAndHeight / self extent x * self cameraScale ].
	self extent y > maxWidthAndHeight
		ifTrue: [ self scale: maxWidthAndHeight / self extent y * self cameraScale ]
]

{ #category : #settings }
DCTRCanvasExporter >> whole [
	"image includes whole canvas, otherwise it is cropped to original camera"

	self
		centered;
		extent: self cameraScale * canvas encompassingRectangle extent
]

{ #category : #settings }
DCTRCanvasExporter >> withoutFixedShapes [
	canvas camera doWithoutCallbacks: [ canvas fixedShapes do: [ :shape | shape doWithoutCallbacks: [ shape remove ] ] ]
]
