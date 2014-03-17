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
		'title'
	],
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #'as yet unclassified' }
RTHTMLExporter class >> exportBuilderAsSVG: aRTBuilder [

	^self exportViewAsSVG: (aRTBuilder view)
]

{ #category : #'as yet unclassified' }
RTHTMLExporter class >> exportBuilderAsSVG: aRTBuilder title: aString [

	^self exportViewAsSVG: (aRTBuilder view) title: aString
]

{ #category : #'as yet unclassified' }
RTHTMLExporter class >> exportViewAsSVG: aRTView [ 

	^ self new view: aRTView; interactiveExportWithExtension: '.html'
]

{ #category : #'as yet unclassified' }
RTHTMLExporter class >> exportViewAsSVG: aRTView title: aString [

	^ self new view: aRTView; title: aString; interactiveExportWithExtension: '.html'
]

{ #category : #html }
RTHTMLExporter >> addEnd [
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
			nextPutAll: ('<h1>', self title,'</h1>', String cr).
]

{ #category : #exporting }
RTHTMLExporter >> exportOnStream: fileStream [
	self stream: fileStream.
	self addStart.
	RTSVGExporter new view: self view; exportOnStream: self stream.
	self addEnd.
]

{ #category : #initialization }
RTHTMLExporter >> initialize [
	title := 'HTML Export'
]

{ #category : #exporting }
RTHTMLExporter >> interactiveExportWithExtension: fileExtension [

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
