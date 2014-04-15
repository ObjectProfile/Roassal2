"
A RTHTMLExporter is an exporter that exports RTBuilders or RTViews into SVG files.

For exporting from a RTView, use the ""exportViewAsSVG:"" method.

For exporting a RTBuilder (or any subclasses) use the ""exportBuilderAsSVG:"" method.
"
Class {
	#name : #RTHTMLExporter,
	#superclass : #RTObject,
	#instVars : [
		'view',
		'stream',
		'fileName',
		'title',
		'interactions',
		'backgroundColor',
		'withCode',
		'code'
	],
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #'as yet unclassified' }
RTHTMLExporter class >> exportBuilderAsHTML: aRTBuilder [

	^self exportViewAsHTML: (aRTBuilder view)
]

{ #category : #'as yet unclassified' }
RTHTMLExporter class >> exportBuilderAsHTML: aRTBuilder filename: aString [

	^self exportViewAsHTML: (aRTBuilder view) filename: aString 
]

{ #category : #'as yet unclassified' }
RTHTMLExporter class >> exportBuilderAsHTML: aRTBuilder filename: aString title: anotherString [

	^self exportViewAsHTML: (aRTBuilder view) filename: aString title: anotherString
]

{ #category : #'as yet unclassified' }
RTHTMLExporter class >> exportBuilderAsHTML: aRTBuilder title: aString [

	^self exportViewAsHTML: (aRTBuilder view) title: aString
]

{ #category : #'as yet unclassified' }
RTHTMLExporter class >> exportViewAsHTML: aRTView [ 

	^ self new view: aRTView; exportToFile
]

{ #category : #'as yet unclassified' }
RTHTMLExporter class >> exportViewAsHTML: aRTView filename: aString [

	^ self new view: aRTView filename: aString; exportToFile
]

{ #category : #'as yet unclassified' }
RTHTMLExporter class >> exportViewAsHTML: aRTView filename: aString title: anotherString [

	^ self new view: aRTView filename: aString title: anotherString; exportToFile
]

{ #category : #'as yet unclassified' }
RTHTMLExporter class >> exportViewAsHTML: aRTView title: aString [

	^ self new view: aRTView title: aString; exportToFile
]

{ #category : #'as yet unclassified' }
RTHTMLExporter class >> interactiveExportBuilderAsHTML: aRTBuilder [

	^self exportViewAsHTML: (aRTBuilder view)
]

{ #category : #'as yet unclassified' }
RTHTMLExporter class >> interactiveExportBuilderAsHTML: aRTBuilder title: aString [

	^self exportViewAsHTML: (aRTBuilder view) title: aString
]

{ #category : #'as yet unclassified' }
RTHTMLExporter class >> interactiveExportViewAsHTML: aRTView [ 

	^ self new view: aRTView; interactiveExportToFile
]

{ #category : #'as yet unclassified' }
RTHTMLExporter class >> interactiveExportViewAsHTML: aRTView title: aString [

	^ self new view: aRTView title: aString; interactiveExportToFile
]

{ #category : #html }
RTHTMLExporter >> addEnd [
		withCode 
			ifTrue: [ stream nextPutAll: '<pre><code style="background-color:rgb(192,192,192); float: left; overflow:scroll;max-width:50%;">', self code,'</code></pre></div>',String cr].
		stream
			nextPutAll: ('</body>', String cr);
			nextPutAll: ('</html>').
]

{ #category : #html }
RTHTMLExporter >> addStart [
		stream
			nextPutAll: ('<!DOCTYPE html>', String cr);
			nextPutAll: ('<html>', String cr);
			nextPut: Character tab;
			nextPutAll: ('<body>', String cr);
			nextPut: Character tab;
			nextPutAll: ('<h1>', self title,'</h1>', String cr,'<div>').
]

{ #category : #accessing }
RTHTMLExporter >> backgroundColor [
	^ backgroundColor
]

{ #category : #accessing }
RTHTMLExporter >> backgroundColor: anObject [
	backgroundColor := anObject
]

{ #category : #accessing }
RTHTMLExporter >> builder: aBuilder filename: aString [
	self view: aBuilder view; fileName: aString.
]

{ #category : #accessing }
RTHTMLExporter >> builder: aBuilder filename: aString title: anotherString [
	self builder: aBuilder filename: aString; title: anotherString.
]

{ #category : #accessing }
RTHTMLExporter >> builder: aBuilder title: aString [
	self view: aBuilder view; title: aString.
]

{ #category : #accessing }
RTHTMLExporter >> code [
	^code
]

{ #category : #accessing }
RTHTMLExporter >> code: aString [
	code := aString.
	withCode := true.
]

{ #category : #configuration }
RTHTMLExporter >> defaultBackgroundColor [
	^ Color white
]

{ #category : #exporting }
RTHTMLExporter >> exportOnStream: fileStream [
	self stream: fileStream.
	self addStart.
	RTInteractiveSVGExporter new view: self view; interactions: self interactions; backgroundColor: self backgroundColor;  exportOnStream: self stream.
	self addEnd.
]

{ #category : #exporting }
RTHTMLExporter >> exportToFile [

	| file  |
	file := (FileSystem disk workingDirectory / (self fileName,'.html')).
	file exists ifTrue: [file delete].
	file := (FileSystem disk workingDirectory / (self fileName,'.html')) writeStream.
	[ self exportOnStream: file ] 
		ensure: [ file notNil ifTrue: [ file close ] ]
]

{ #category : #accessing }
RTHTMLExporter >> fileName [
	fileName = nil
		ifTrue: [ fileName := (Time current asString  copyReplaceAll: ':' with: '') squeezeOutNumber asString.
			 fileName := 'output',fileName.].
	^ fileName
]

{ #category : #accessing }
RTHTMLExporter >> fileName: anObject [
	fileName := anObject
]

{ #category : #initialization }
RTHTMLExporter >> initialize [
	title := 'HTML Export'.
	interactions := Dictionary new.
	backgroundColor := self defaultBackgroundColor.
	withCode := false.
]

{ #category : #accessing }
RTHTMLExporter >> interactions [
	^ interactions
]

{ #category : #accessing }
RTHTMLExporter >> interactions: anObject [
	interactions := anObject
]

{ #category : #exporting }
RTHTMLExporter >> interactiveExportToFile [

	| fileStream fileRef |
	
	fileRef := UITheme builder 
		fileSave: 'Export as html'
		extensions: #('html')
		path: nil.
		
	fileRef ifNil: [ self inform: 'Saving cancelled'. ^ self ].
	
	fileStream := fileRef writeStream.
	[ self exportOnStream: fileStream ] 
		ensure: [ fileStream notNil ifTrue: [ fileStream close ] ]
]

{ #category : #accessing }
RTHTMLExporter >> stream [
	^ stream
]

{ #category : #accessing }
RTHTMLExporter >> stream: anObject [
	stream := anObject
]

{ #category : #accessing }
RTHTMLExporter >> title [
	^ title
]

{ #category : #accessing }
RTHTMLExporter >> title: anObject [
	title := anObject
]

{ #category : #accessing }
RTHTMLExporter >> view [
	^ view
]

{ #category : #accessing }
RTHTMLExporter >> view: anObject [
	view := anObject
]

{ #category : #accessing }
RTHTMLExporter >> view: aView filename: aString [
	self view: aView; fileName: aString.
]

{ #category : #accessing }
RTHTMLExporter >> view: aView filename: aString title: anotherString [
	self view: aView filename: aString; title: anotherString.
]

{ #category : #accessing }
RTHTMLExporter >> view: aView title: aString [
	self view: aView; title: aString.
]
