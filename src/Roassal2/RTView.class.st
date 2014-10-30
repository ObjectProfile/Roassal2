"
A RTView is xxxxxxxxx.

Roassal structures a visualization in terms of views, elements, shapes, interactions, and animations.
A ''view'' is a container of graphical elements and represents a layer that may be combined with other views. 

Instance Variables
	edges:		<Object>
	elements:		<Object>
	trCanvas:		<Object>

edges
	- xxxxx

elements
	- xxxxx

trCanvas
	- xxxxx

"
Class {
	#name : #RTView,
	#superclass : #RTAnnounceableObject,
	#instVars : [
		'elements',
		'edges',
		'trCanvas'
	],
	#category : #'Roassal2-Core'
}

{ #category : #visitor }
RTView >> accept: aVisitor [
	aVisitor visitView: self
]

{ #category : #adding }
RTView >> add: anElementOrAnEdge [
	anElementOrAnEdge addedIn: self.
	anElementOrAnEdge renderOn: trCanvas 

]

{ #category : #adding }
RTView >> addAll: someElements [
	someElements do: [ :el | self add: el ]
]

{ #category : #adding }
RTView >> addAnimation: animation [
	trCanvas addAnimation: animation
]

{ #category : #adding }
RTView >> addEdge: anEdge [
	edges add: anEdge
]

{ #category : #adding }
RTView >> addElement: anElement [
	elements add: anElement
]

{ #category : #menu }
RTView >> addFindMenu [
	|element|
	self addMenu: 'Find' callback: [  
		element := UIManager default chooseFrom: (self elements collect: #model) values: self elements.
		element notNil
			ifTrue: [ self canvas camera translateTo: element position. RTBlink on: element ] ].
]

{ #category : #menu }
RTView >> addLayoutMenu [
	"Simply add some useful menu"
	| b translator |
	translator := RTSmoothLayoutTranslator new.
	b := RTMenuBuilder new view: self.
	b menu: 'Layout' submenu: 'grid' background: Color yellow callback: [ RTGridLayout new translator: translator; on: self elements. self canvas signalUpdate ].
	b menu: 'Layout' submenu: 'hori' background: Color yellow callback: [ RTHorizontalLineLayout new translator: translator; on: self elements. self canvas signalUpdate ].
	b menu: 'Layout' submenu: 'tree' background: Color yellow callback: [ RTTreeLayout new translator: translator; on: self elements edges: self edges. self canvas signalUpdate ].
	b menu: 'Layout' submenu: 'treeH' background: Color yellow callback: [ RTHorizontalTreeLayout new translator: translator; on: self elements edges: self edges. self canvas signalUpdate ].
	b menu: 'Layout' submenu: 'cluster' background: Color yellow callback: [ RTClusterLayout new translator: translator; on: self elements edges: self edges. self canvas signalUpdate ].
	b menu: 'Layout' submenu: 'circle' background: Color yellow callback: [ RTCircleLayout new translator: translator; on: self elements edges: self edges. self canvas signalUpdate ].
	b menu: 'Layout' submenu: 'radial' background: Color yellow callback: [ RTRadialTreeLayout new translator: translator; on: self elements edges: self edges. self canvas signalUpdate ].
	b menu: 'Layout' submenu: 'sugi' background: Color yellow callback: [ RTSugiyamaLayout new translator: translator; on: self elements edges: self edges. self canvas signalUpdate ].
	b build
]

{ #category : #menu }
RTView >> addMenu: aTitle callback: aBlock [
	self canvas addMenu: aTitle callback: aBlock

]

{ #category : #adding }
RTView >> animations [
	^ trCanvas animations
]

{ #category : #opening }
RTView >> build [
	"do nothing. This method is used polymorphically with builders"
]

{ #category : #accessing }
RTView >> canvas [
	"Return the trachel canvas on which everything is drawn"
	^ trCanvas
]

{ #category : #actions }
RTView >> clean [
	"Remove all the elements of the view. It does not remove elements that are directly added to the canvas however"
	self elements copy do: #remove.
	self edges copy do: #remove.
]

{ #category : #actions }
RTView >> cleanAll [
	"Clean out everything, both the view and the canvas. It means that elements added to the canvas are cleaned out"
	self clean.
	self canvas clean
	
]

{ #category : #'accessing-computed' }
RTView >> edgeFromModel: anObject [
	"Return an edge that corresponds to the object provided as parameter. If none is found, then return nil"
	^ edges detect: [ :edge | edge model = anObject ] ifNone: [ nil ]
]

{ #category : #accessing }
RTView >> edges [
	^ edges copy
]

{ #category : #'accessing-computed' }
RTView >> elementFromModel: anObject [
	"Return an element that corresponds to the object provided as parameter. If none is found, then return nil"
	^ elements detect: [ :el | el model = anObject ] ifNone: [ nil ]
]

{ #category : #accessing }
RTView >> elements [
	^ RTGroup withAll: elements
]

{ #category : #'accessing-computed' }
RTView >> elementsFromModel: anObject [
	"Return an element that corresponds to the object provided as parameter. If none is found, then return nil"
	^ elements select: [ :el | el model = anObject ]
]

{ #category : #'accessing-computed' }
RTView >> elementsFromModels: objects [
	"Return elements that corresponds to the objects provided as parameter. If none is found, then return an empty collection"
	| answer t |
	answer := RTGroup new.
	objects do: [ :o |
		t := self elementFromModel: o.
		t notNil ifTrue: [ answer add: t ] ].
	^ answer
]

{ #category : #initialization }
RTView >> initialize [
	super initialize.
	elements := OrderedCollection new.
	edges := OrderedCollection new.
	self setCanvas: TRCanvas new
]

{ #category : #'accessing-computed' }
RTView >> numberOfEdges [
	^ edges size
]

{ #category : #'accessing-computed' }
RTView >> numberOfElements [
	^ elements size
]

{ #category : #opening }
RTView >> open [
	^ self setUpCanvas open
]

{ #category : #opening }
RTView >> openInWindowSized: anExtentAsPoint [
	^ self setUpCanvas openInWindowSized: anExtentAsPoint
]

{ #category : #opening }
RTView >> openInWindowSized: anExtentAsPoint titled: aTitle [
	^ self setUpCanvas openInWindowSized: anExtentAsPoint titled: aTitle
]

{ #category : #opening }
RTView >> openRaw [
	"Simply open the canvas. No menu is added, no centering of the camera is done"
	^ trCanvas open
]

{ #category : #opening }
RTView >> openWithMenu [
	self canvas addMenu: 'In' callback: [ RTZoomInMove on: self ].
	self canvas addMenu: 'Out' callback: [ RTZoomOutMove on: self ].

	^ self open
]

{ #category : #actions }
RTView >> pushBackEdges [
	"Move all the edges in the background"
	self edges do: [ :e | e trachelShape pushBack ]
]

{ #category : #actions }
RTView >> pushBackFront [
	"Move all the edges in the front"
	self edges do: [ :e | e trachelShape pushFront ]
]

{ #category : #actions }
RTView >> removeEdge: anEdge [
	edges remove: anEdge ifAbsent: [ ].
	anEdge trachelShape remove.
]

{ #category : #adding }
RTView >> removeElement: anElement [
	elements remove: anElement ifAbsent: [ ].
	anElement trachelShape remove.
]

{ #category : #actions }
RTView >> restoreCamera [
	"Reuse a previous camera. This is useful when scripting in a playground"
	self view numberOfElements = 0 ifTrue: [ TRCameraInitializer reset ].
	self view canvas camera toAdjust: TRCameraInitializer restorePrevious
]

{ #category : #accessing }
RTView >> setCanvas: aTrachelCanvas [
	trCanvas := aTrachelCanvas.
	"Share my announcer with the one of the Trachel Canvas"
	announcer := trCanvas announcer.
]

{ #category : #menu }
RTView >> setDefaultMenu [
	"Simply add some useful menu"
	| b |
	b := RTMenuBuilder new view: self.
	b menu: 'Zoom' submenu: '+' background: Color yellow callback: [ RTZoomInMove on: self ].
	b menu: 'Zoom' submenu: '-' background: Color yellow callback: [ RTZoomOutMove on: self ].
	b menu: 'Export' submenu: 'HTML' background: Color blue callback: [ RTHTMLExporter exportViewAsHTML: self ].
	
	(Smalltalk allClasses anySatisfy: [ :c | c name == #RTPDFExporter ])
		ifTrue: [ b menu: 'Export' submenu: 'PDF' background: Color blue callback: [ (Smalltalk at: #RTPDFExporter) exportView: self ]. ].
	b render
]

{ #category : #initialization }
RTView >> setUpCanvas [
	"Make the camera point on the center of the visualization"
	trCanvas camera adjust.
	^ trCanvas
]

{ #category : #convenient }
RTView >> signalUpdate [
	^ self canvas signalUpdate
]

{ #category : #'accessing-computed' }
RTView >> trachelShape [

	^ TRNoShape instance
]

{ #category : #'accessing-computed' }
RTView >> view [
	"This method is meant to be used polymorphically with builders.
	Thus, regardless of whether we get a raw view or a builder, we 
	can uniformly obtain the view"
	^ self
]
