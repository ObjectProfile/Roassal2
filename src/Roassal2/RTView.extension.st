Extension { #name : #RTView }

{ #category : #'*Roassal2' }
RTView >> addFindMenu [
	
	self addMenu: 'Find' callback: [ |element|
		element := TRPlatform current dialogChooseFrom: (self elements collect: #model) values: self elements.
		element notNil
			ifTrue: [ self canvas camera translateTo: element position. RTBlink on: element ] ].
]

{ #category : #'*Roassal2' }
RTView >> addLayoutMenu [
	"Simply add some useful menu
	
	:: Void -> RTView
	var b : RTMenuBuilder
	var translator : RTSmoothLayoutTranslator
	"
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

{ #category : #'*Roassal2' }
RTView >> openWithMenu [
	"
	:: Void -> Object
	"
	self canvas addMenu: 'In' callback: [ RTZoomInMove on: self ].
	self canvas addMenu: 'Out' callback: [ RTZoomOutMove on: self ].

	^ self open
]

{ #category : #'*Roassal2' }
RTView >> setDefaultMenu [
	"
	:: Void -> RTView
	var b : RTMenuBuilder
	"
	"Simply add some useful menu"
	| b |
	b := RTMenuBuilder new view: self.
	b menu: 'In' callback: [ RTZoomInMove on: self ].
	b menu: 'Out' callback: [ RTZoomOutMove on: self ].
	b menu: 'Center' callback: [ self canvas focusOnCenterScaled. self signalUpdate ].
	b menu: 'Export' submenu: 'HTML' background: Color blue trans 
		callback: [ RTHTML5Exporter interactiveExport: self ].
	b menu: 'Export' submenu: 'SVG' 
		callback: [ RTSVGExporter interactiveExportViewAsSVG: self ].
	b menu: 'Export' submenu: 'PNG' 
		callback: [ RTPNGExporter new builder: self; fileName: 'roassal.png'; exportToFile ].
	
	(Smalltalk allClasses anySatisfy: [ :c | c name == #RTPDFExporter ])
		ifTrue: [ b menu: 'Export' submenu: 'PDF' callback: [ (Smalltalk at: #RTPDFExporter) exportView: self ]. ].
	b render
]
