"
A GLMRoassalPresentation is xxxxxxxxx.

Instance Variables
	newViewBlock:		<Object>
	painting:		<Object>
	paintingBlock:		<Object>
	shouldPopulateSelection:		<Object>
	view:		<Object>

newViewBlock
	- xxxxx

painting
	- xxxxx

paintingBlock
	- xxxxx

shouldPopulateSelection
	- xxxxx

view
	- xxxxx

"
Class {
	#name : #GLMRoassal2Presentation,
	#superclass : #GLMPresentation,
	#instVars : [
		'painting',
		'paintingBlock',
		'view',
		'shouldPopulateSelection',
		'newViewBlock'
	],
	#category : #'Glamour-Roassal2-Presentations'
}

{ #category : #'initialize-release' }
GLMRoassal2Presentation >> defaultActions [
	self 
		act: [ :roassal |  RTZoomInMove on: roassal view view ]
		icon: GLMUIThemeExtraIcons glamorousZoomIn
		entitled: 'Zoom in'.
	self 
		act: [ :roassal |  RTZoomOutMove on: roassal view view ]
		icon: GLMUIThemeExtraIcons glamorousZoomOut
		entitled: 'Zoom out'.
	self
		act: [ :roassal | roassal view view canvas focusOnCenterScaled. roassal view view signalUpdate ]
		icon: GLMUIThemeExtraIcons glamorousZoomToFit
		entitled: 'Camera center'.
																
	self 
		act: [ :roassal | 
				| fileName |
				fileName := UITheme builder 
									fileSave: 'Enter the PNG file name'
									extensions: #('png')
									path: nil.
				fileName notNil ifTrue: [ 
					RTPNGExporter new 
								builder: roassal view view;
								fileName: fileName fullName;
								exportToFile. ]  ]
			entitled: 'Export to PNG'.
	self 
		act: [ :roassal | 
				| fileName |
				fileName := UITheme builder 
									fileSave: 'Enter the SVG file name'
									extensions: #('SVG')
									path: nil.
				fileName notNil ifTrue: [ 
					RTSVGExporter 
								exportBuilderAsSVG: roassal view view 
								filename: fileName fullName ]  ]
			entitled: 'Export to SVG'.
	self act: [ :roassal |
		| fileName |
		fileName := (RTHTML5Exporter new export: roassal view view) asUrl.
		self openIfPossible: fileName.
		 ] entitled: 'Export to HTML'.
	self
		act: [ :roassal |
				| fileName |
				fileName := UITheme builder 
									fileSave: 'Enter the HTML file name'
									extensions: #('html')
									path: nil.
				fileName notNil ifTrue: [ 
					RTHTML5Exporter new 
						directory: fileName parent;
						fileName: fileName basename; 
						export: roassal view view.
					self openIfPossible: fileName ] ]
			entitled: 'Export to HTML...'.
			
	(Smalltalk includesKey:#RTPDFExporter) ifTrue: [ 
			self
				act: [ :roassal| (Smalltalk at: #RTPDFExporter) exportView: roassal view view ]
				entitled: 'Export to PDF...'
			 ].
		
	self 
		act: [ :roassal | roassal view view inspect ]
			entitled: 'Inspect View'.
	
]

{ #category : #'initialize-release' }
GLMRoassal2Presentation >> initialize [ 
	super initialize.
	newViewBlock := [ RTView new ].
	shouldPopulateSelection := true.
	self defaultActions
]

{ #category : #accessing }
GLMRoassal2Presentation >> initializeView: aZeroArgBlock [
	^ newViewBlock := aZeroArgBlock 
]

{ #category : #accessing }
GLMRoassal2Presentation >> newView [
	view := nil.
	^ self view
]

{ #category : #accessing }
GLMRoassal2Presentation >> newViewBlock [
	^ newViewBlock
]

{ #category : #'initialize-release' }
GLMRoassal2Presentation >> openIfPossible: fileName [
	"
	By Sean
	
	Gofer it
	smalltalkhubUser: 'SeanDeNigris' project: 'SeansPlayground';
	package: 'NewExternalWebBrowser';
	load.

	'http://google.com' asUrl open.
	"
	
	#NewExternalWebBrowser asClassIfPresent: [ :cls | fileName asUrl open ].
	#NewExternalWebBrowser asClassIfAbsent: [ 
		self inform: 'Try to load NewExternalWebBrowser to fast open of this file' ].
]

{ #category : #scripting }
GLMRoassal2Presentation >> painting: anObject [
	paintingBlock := anObject
]

{ #category : #accessing }
GLMRoassal2Presentation >> paintingBlock [
	^ paintingBlock
]

{ #category : #rendering }
GLMRoassal2Presentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	^ aRenderer renderRoassal2Presentation: self
]

{ #category : #accessing }
GLMRoassal2Presentation >> renderOn: aView [
	self paintingBlock glamourValue: (
								aView asGlamorousMultiValue, 
								self entity asGlamorousMultiValue,
								self asGlamorousMultiValue ).
	aView build.
	self shouldPopulateSelection ifTrue: [
		aView view elements do: [:each |  
			each when: TRMouseLeftClick do: [:event | self selection: each model ]] ].
	self view: aView
]

{ #category : #accessing }
GLMRoassal2Presentation >> shouldPopulateSelection [
	^ shouldPopulateSelection
]

{ #category : #accessing }
GLMRoassal2Presentation >> shouldPopulateSelection: anObject [
	shouldPopulateSelection := anObject
]

{ #category : #accessing }
GLMRoassal2Presentation >> view [
	^ view ifNil: [ view := self newViewBlock value ]
]

{ #category : #accessing }
GLMRoassal2Presentation >> view: anObject [
	view := anObject
]
