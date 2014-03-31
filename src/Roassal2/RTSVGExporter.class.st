"
A RTSVGExporter is an exporter to get SVG files from RTBuilders or RTViews.

For exporting from a RTView, use the ""exportViewAsSVG:"" method.

For exporting a RTBuilder (or any subclasses) use the ""exportBuilderAsSVG:"" method.
"
Class {
	#name : #RTSVGExporter,
	#superclass : #RTObject,
	#instVars : [
		'view',
		'stream',
		'fileName',
		'backgroundColor'
	],
	#category : #'Roassal2-Exporter-SVG'
}

{ #category : #'as yet unclassified' }
RTSVGExporter class >> exportBuilderAsSVG: aRTBuilder [

	^self exportViewAsSVG: (aRTBuilder view)
]

{ #category : #'as yet unclassified' }
RTSVGExporter class >> exportBuilderAsSVG: aRTBuilder filename: aString [

	^self exportViewAsSVG: (aRTBuilder view) filename: aString
]

{ #category : #'as yet unclassified' }
RTSVGExporter class >> exportViewAsSVG: aRTView [ 

	^ self new view: aRTView; exportToFile
]

{ #category : #'as yet unclassified' }
RTSVGExporter class >> exportViewAsSVG: aRTView filename: aString [

	^ self new view: aRTView; fileName: aString; exportToFile
]

{ #category : #'as yet unclassified' }
RTSVGExporter class >> interactiveExportBuilderAsSVG: aRTBuilder [

	^self exportViewAsSVG: (aRTBuilder view)
]

{ #category : #'as yet unclassified' }
RTSVGExporter class >> interactiveExportViewAsSVG: aRTView [ 

	^ self new view: aRTView; interactiveExportToFile
]

{ #category : #svg }
RTSVGExporter >> addEnd [
	
	stream
		nextPutAll: '</svg>'.
]

{ #category : #svg }
RTSVGExporter >> addStart: bounds [
	stream
		nextPutAll: '<svg  xmlns="http://www.w3.org/2000/svg" ';
		nextPutAll:  ('width="<1p>px" height="<2p>px" ' expandMacrosWith: ((bounds width + 2) rounded) with: ((bounds height + 2) rounded));
		nextPutAll: ('style="background-color: rgb(<1p>,<2p>,<3p>);" ' expandMacrosWith: (backgroundColor red * 256) rounded with: (backgroundColor green * 256) rounded with: (backgroundColor blue * 256) rounded );
		nextPutAll: String cr;
		nextPut: Character tab;
		nextPutAll: 'xmlns:xlink="http://www.w3.org/1999/xlink">';
		nextPutAll: String cr
]

{ #category : #accessing }
RTSVGExporter >> backgroundColor [
	^ backgroundColor
]

{ #category : #accessing }
RTSVGExporter >> backgroundColor: aColor [
	backgroundColor := aColor
]

{ #category : #configuration }
RTSVGExporter >> defaultBackgroundColor [
	^ Color veryLightGray
]

{ #category : #svg }
RTSVGExporter >> endGroup [

	stream 
		nextPutAll: '</g>';
		nextPutAll: String cr.
]

{ #category : #exporting }
RTSVGExporter >> exportOnStream: fileStream [
	|bounds|
	bounds := self fixedEncompassingRectangle.
	self stream: fileStream.
	self addStart: bounds.
	RTSVGVisitor visit: view on: stream canvas: bounds.
	self addEnd.
]

{ #category : #exporting }
RTSVGExporter >> exportToFile [

	| fileStream |
	(FileSystem disk workingDirectory / (self fileName,'.html')) delete.
	fileStream := (FileSystem disk workingDirectory / (self fileName,'.svg')) writeStream.
	[ self exportOnStream: fileStream ] 
		ensure: [ fileStream notNil ifTrue: [ fileStream close ] ]
]

{ #category : #accessing }
RTSVGExporter >> fileName [
	fileName = nil
		ifTrue: [ fileName := (Time current asString  copyReplaceAll: ':' with: '') squeezeOutNumber asString.
			 fileName := 'output',fileName.].
	^ fileName
]

{ #category : #accessing }
RTSVGExporter >> fileName: anObject [
	fileName := anObject
]

{ #category : #util }
RTSVGExporter >> fixedEncompassingRectangle [
 	| shapes canvas |
	shapes := self view canvas shapes.
	canvas := shapes first encompassingRectangle.
	shapes do: [ :s| |rect|
				rect := s encompassingRectangle.
				rect height < 0 
					ifTrue: [ rect := Rectangle origin: rect bottomLeft corner: rect topRight].
				canvas := canvas merge: rect.
				 ].
	^canvas 
]

{ #category : #initialization }
RTSVGExporter >> initialize [
	super initialize.
	backgroundColor := self defaultBackgroundColor
]

{ #category : #exporting }
RTSVGExporter >> interactiveExportToFile [

	| fileStream fileRef |
	
	fileRef := UITheme builder 
		fileSave: 'Export as SVG'
		extensions: #('svg')
		path: nil.
		
	fileRef ifNil: [ self inform: 'Saving cancelled'. ^ self ].
	
	fileStream := fileRef writeStream.
	[ self exportOnStream: fileStream ] 
		ensure: [ fileStream notNil ifTrue: [ fileStream close ] ]
]

{ #category : #svg }
RTSVGExporter >> startGroup [

	stream 
		nextPutAll: '<g>';
		nextPutAll: String cr.
]

{ #category : #accessing }
RTSVGExporter >> stream [
	
	^stream
]

{ #category : #accessing }
RTSVGExporter >> stream: aStream [
	
	stream := aStream
]

{ #category : #accessing }
RTSVGExporter >> view [
	
	^view
]

{ #category : #accessing }
RTSVGExporter >> view: aView [
	
	view := aView.
]
