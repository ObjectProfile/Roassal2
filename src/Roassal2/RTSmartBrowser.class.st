Class {
	#name : #RTSmartBrowser,
	#superclass : #RTObject,
	#instVars : [
		'statusBar',
		'currentSelection',
		'view'
	],
	#classInstVars : [
		'icon'
	],
	#category : #'Roassal2-DataStudio'
}

{ #category : #'as yet unclassified' }
RTSmartBrowser class >> menuCommandOn: aBuilder [
	<worldMenu>

	(aBuilder item: #'Pharo Small Browser')
		order: 0.1; 
		parent: #Tools;
		label: 'Pharo Smart Browser';
		icon: self roassalWithTransparentIcon;
		action:[ self new open ]
]

{ #category : #'as yet unclassified' }
RTSmartBrowser class >> roassalWithTransparentIcon [
	"Private - Generated method"
	^ icon ifNil: [ icon := Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self roassalWithTransparentIconContents readStream) ].
]

{ #category : #'as yet unclassified' }
RTSmartBrowser class >> roassalWithTransparentIconContents [
	"Private - Method generated with the content of the file /Users/alexandrebergel/Documents/ObjectProfile/Logos/RoassalWithTransparent.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAAA0AAAAYCAYAAAAh8HdUAAAACXBIWXMAAAsTAAALEwEAmpwY
AAABrklEQVQ4jc2TP0+TURSHn99tQwxYXQATmtc/pHXQtthCCImbA4mJRh3o6ICTX8AY/ALK
5OjqwASMEEg0JITAIIJvMMYoW6kaJRLSxKHw3uNQLW2JRpz4JWc4957n3HPPPVdmxlHljkwc
fyh+aCUXZDF/FyMPnAVLgL4A85xy4yyXvh9AV4IkUTQBDICeI8ZRfBNF3Xh/A+MRFT8IXJOZ
Qd/5C/jqCmgV3BhGmrel6aYKsj0zGNeJdSVqd/J790HTbJRvgh+DaIpCuqu5blWACmH441d5
bpbO1BJgYGdAn1n7+K0enw/SGLeRHgCmlokQ2eQOsEhnW5Ht/SGwYbAiTg8Jt6agteX5IIXZ
acQq29UXWLQAPiBov/wbOAx5PwCA6TUxjSKFmIY4md9vDGuGIqtB7sQr3mx9wHgMluL90r0/
Q6IfqUS4+RWAS1cnQeuYnlDoPQdAMdPW2AiR6dlFeslG+U49UV+yQMQK2CfEU0wp17B5EUgg
1ptOD8trxNwthAHDxOPPDsYochnwVaR3tCoszQG9dd/MajYyErNcrqPu/8VaH/efdMx/7n9B
PwE6FbKAkaTh8gAAAABJRU5ErkJggg=='
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> currentSelection [
	"Return a list of elements that is currently selected"
	^ RTGroup withAll: currentSelection 
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> expandClassElement: classElement [
	| class methods methodShape methodElements |
	class := classElement model.
	methods := class methods.

	classElement trachelShape color: (Color blue alpha: 0.3).

	methodShape := RTBox new.
	methodElements := methodShape elementsOn: methods.
	view addAll: methodElements.

	RTEdge 
		buildEdgesFromObjects: methods 
		from: #yourself 
		toAll: #dependentMethods 
		using: (RTLine new color: (Color gray alpha: 0.3))
		inView: view.
	RTTreeLayout on: methodElements.
	
	methodElements @ (RTPopup new text: [ :cm | cm selector asString ]).
	
	RTNest new on: classElement nest: methodElements.
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> graph [
	^ view
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> initialize [
	super initialize.
	view := RTView new. 
	view @ RTDraggableView.

	self setMenu.
	self setStatusBar.
	currentSelection := #()
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> notSelectedElements [
	"Return a list of elements that are __not__ currently selected"
	^ RTGroup withAll: (view elements copyWithoutAll: self currentSelection)
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> open [
	view open
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> pressAddClasses [
	| regExp |
	regExp := UIManager default request: 'Enter a regexp for classes (e.g., RT*)'.
	regExp ifNil: [ ^ self ].
	self pressAddClasses: regExp
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> pressAddClasses: regExp [
	| classes shape es |
	classes := Smalltalk allClasses select: [ :c | regExp match: c name ].
	
	shape := RTBox new 
				height: [ :c | c numberOfMethods max: 5 ]; 
				width: [ :c | c numberOfVariables * 4 max: 5 ]; color: (Color gray alpha: 0.4).
	es := shape elementsOn: classes.
	es @ RTPopup @ RTDraggable.
	view addAll: es.	
	
	RTEdge 
		buildEdgesFromObjects: classes 
		from: #superclass 
		to: #yourself 
		using: (RTLine new attachPoint: RTVerticalAttachPoint instance)
		inView: view.

"We look for the hierarchy root"
"	es do: [ :el | 
		(classes includes: el model superclass)
			ifFalse: [ el @ RTLabelled ] ].
"	
	
	es when: TRMouseClick do: [ :e |
		self expandClassElement: e element.
		self pressLayout: RTTreeLayout new.
	].
	
	self setStatusBar: classes size printString, ' added classes'.
	currentSelection := view elementsFromModels: classes.
	
	self pressLayout: RTTreeLayout new.
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> pressAddPackages [
	| regExp |
	regExp := UIManager default request: 'Enter a regexp for packages (e.g., *Roassal*)'.
	regExp ifNil: [ ^ self ].
	self pressAddPackages: regExp
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> pressAddPackages: regExp [
	| paks |
	paks := RPackageOrganizer default packages select: [ :p | regExp match: p name ].
	view addAll: ((RTEllipse new size: 10; color: (Color gray alpha: 0.4)) elementsOn: paks) @ RTPopup @ RTDraggable.
	self setStatusBar: paks size printString, ' added nodes'.
	currentSelection := view elementsFromModels: paks
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> pressLayout: layout [
	layout
		translator: self translator;
		on: self currentSelection
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> pressMoveRight [
	^ TRConstraint move: self currentSelection onTheRightOf: self notSelectedElements using: self translator
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> pressSelect [
	| regExp  str |
	regExp := UIManager default request: 'Enter a regexp for elements (e.g., RTShape)'.
	regExp ifNil: [ ^ self ].
	
	self pressSelect: regExp
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> pressSelect: regExp [
	| str |	
	currentSelection := view elements select: [ :el | '*', regExp, '*' match: el model asString ].

	str := (currentSelection collect: #model) asString.
	self setStatusBar: '#', currentSelection size printString, ':', (str copyFrom: 1 to: (str size min: 70)), ' ...'
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> pressSetColor: aColor [
	self currentSelection do: [ :e | e trachelShape color: aColor ].
	view signalUpdate
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> setMenu [
	| b |
	b := RTMenuBuilder new view: view.	"adding"
	b
		menu: 'import code'
		submenu: 'packages'
		background: Color red
		callback: [ self pressAddPackages ].
	b
		menu: 'import code'
		submenu: 'classes'
		background: Color red
		callback: [ self pressAddClasses ].
	b
		menu: 'layout'
		submenu: 'grid'
		background: Color red
		callback: [ self pressLayout: RTGridLayout new ].
	b
		menu: 'layout'
		submenu: 'flow'
		background: Color red
		callback: [ self pressLayout: RTFlowLayout new ].
	b
		menu: 'layout'
		submenu: 'tree'
		background: Color red
		callback: [ self pressLayout: RTTreeLayout new ].
	b
		menu: 'layout'
		submenu: 'right'
		background: Color red
		callback: [ self pressMoveRight ].
	b menu: 'select' background: Color blue callback: [ self pressSelect ].
	b
		menu: 'color'
		submenu: 'red'
		background: Color green
		callback: [ self pressSetColor: Color red ].
	b
		menu: 'color'
		submenu: 'blue'
		background: Color green
		callback: [ self pressSetColor: Color blue ].
	b
		menu: 'color'
		submenu: 'green'
		background: Color green
		callback: [ self pressSetColor: Color green ].


	b
		menu: 'Clean'
		submenu: 'All'
		background: Color blue
		callback: [ view clean ].
		
	b
		menu: 'remove'
		background: Color blue
		callback: [ self pressRemove ]		
"	b
		menu: '+partition'
		background: Color blue
		callback: [ self pressAddPartition ]" 
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> setStatusBar [

	statusBar := TRLabelShape new.
	view canvas addFixedShape: statusBar.
	TRConstraint stickAtTheBottomOfTheWindow: statusBar
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> setStatusBar: string [

	statusBar text: string.
	statusBar canvas announce: TRResizeCanvasEvent new.
	view signalUpdate.
	
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> translator [
	^ RTSmoothLayoutTranslator new 
			nbCycles: 0.5;
			view: view;
			yourself
]
