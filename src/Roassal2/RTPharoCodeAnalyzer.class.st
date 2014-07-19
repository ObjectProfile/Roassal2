Class {
	#name : #RTPharoCodeAnalyzer,
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
RTPharoCodeAnalyzer class >> menuCommandOn: aBuilder [
	<worldMenu>

	(aBuilder item: #'Pharo Code Analyzer')
		order: 0.1; 
		parent: #Tools;
		label: 'Pharo Code Analyzer';
		icon: self roassalWithTransparentIcon;
		action:[ self new open ]
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer class >> roassalWithTransparentIcon [
	"Private - Generated method"
	^ icon ifNil: [ icon := Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self roassalWithTransparentIconContents readStream) ].
]

{ #category : #logo }
RTPharoCodeAnalyzer class >> roassalWithTransparentIconContents [
	"Private - Method generated with the content of the file C:\Users\azazael\Documents\smalltalk\inti\moose\roassalWithTransparent.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAAAoAAAASCAYAAABit09LAAABLElEQVR4XmP4//8/w38iMFGK
aK1wWo/Z/8Tgiv86UhP+a0vX/9eRbvuvLbnyv57U1P8zek2givoFgArmAvFSoKKS/1N7pf5P
6xX7P7XHCaj4zv/EiEKIQh2pLqCgNxCHACX+/58xkQtuk7bkGaB4JYQztVfh//nzjECBnP/a
Umf+z+oTAooZ/teTbgA6J+//qaPSCDeePsYJFGwFmj7jv4F0E1DDrP9W8oX/Tx0TRfeMzn8d
yTVAT3j/15WqBiq8+j80lBnT11N7goHuOf1/2kTu//Nni/031egCalz1//Rx9v9XTjEiKwS6
T/ICmH3lCsP/7CQHoKlf/ieGRP/PCndCKNSRnAzE+1ACWk/GAyh28r+udAFC0EwvDBheYYRj
ZsEC5v+nTjENwtQDAHm03ZBoT2X8AAAAAElFTkSuQmCC'
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> addClassesMatching: matchingPattern [
	| classes |
	classes := Smalltalk allClasses select: [ :c | matchingPattern match: c name ].
	view addAll: ((RTEllipse new size: 10; color: (Color gray alpha: 0.4)) elementsOn: classes) @ RTPopup @ RTDraggable.
	self setStatusBar: classes size printString, ' added nodes'.
	currentSelection := view elementsFromModels: classes
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> addPackagesMatching: matchingPattern [
	| paks |
	paks := RPackageOrganizer default packages select: [ :p | matchingPattern match: p name ].
	view addAll: ((RTEllipse new size: 10; color: (Color gray alpha: 0.4)) elementsOn: paks) @ RTPopup @ RTDraggable.
	self setStatusBar: paks size printString, ' added nodes'.
	currentSelection := view elementsFromModels: paks
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> applyLayout: layout [
	layout
		translator: self translator;
		on: self currentSelection
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> currentSelection [
	"Return a list of elements that is currently selected"
	^ RTGroup withAll: currentSelection 
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> graph [
	^ view
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> initialize [
	super initialize.
	view := RTView new. 
	view @ RTDraggableView.

	self setMenu.
	self setStatusBar.
	currentSelection := #()
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> notSelectedElements [
	"Return a list of elements that are __not__ currently selected"
	^ RTGroup withAll: (view elements copyWithoutAll: self currentSelection)
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> open [
	view open
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> pressAddClasses [
	| matchingPattern |
	matchingPattern := UIManager default request: 'Enter a matching pattern for classes (e.g., RT*)'.
	matchingPattern ifNil: [ ^ self ].
	self addClassesMatching: matchingPattern
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> pressAddPackages [
	| matchingPattern |
	matchingPattern := UIManager default request: 'Enter a matching pattern for packages (e.g., *Roassal*)'.
	matchingPattern ifNil: [ ^ self ].
	self addPackagesMatching: matchingPattern
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> pressMoveRight [
	^ TRConstraint move: self currentSelection onTheRightOf: self notSelectedElements using: self translator
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> pressSelect [
	| regExp  str |
	regExp := UIManager default request: 'Enter a regexp for elements (e.g., RTShape)'.
	regExp ifNil: [ ^ self ].
	
	self selectFromRegExp: regExp
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> pressSetX: symbolOrBlock [
	^ self pressSetX: symbolOrBlock using: #yourself
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> pressSetX: symbolOrBlock using: aTransformation [
	| ext |
	self currentSelection do: [ :e | 
		ext := e extent.
		RTResizeMove new 
			toExtent: (aTransformation rtValue: (symbolOrBlock rtValue: e model)) @ ext y 
				during: 0.4 on: e;
			inView: view  ]
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> pressSetXLog: symbolOrBlock [
	^ self pressSetX: symbolOrBlock using: [ :v | (v + 1) log * 10 ]
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> pressSetY: symbolOrBlock [
	^ self pressSetY: symbolOrBlock using: #yourself

]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> pressSetY: symbolOrBlock using: aTransformation [
	| ext |
	self currentSelection do: [ :e | 
		ext := e extent.
		RTResizeMove new 
			toExtent: ext x @ (aTransformation rtValue: (symbolOrBlock rtValue: e model)) 
				during: 0.4 on: e;
			inView: view  ]
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> pressSetYLog: symbolOrBlock [
	^ self pressSetY: symbolOrBlock using: [ :v | (v + 1) log * 10 ]
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> selectFromRegExp: regExp [
	| str |	
	currentSelection := view elements select: [ :el | '*', regExp, '*' match: el model asString ].

	str := (currentSelection collect: #model) asString.
	self setStatusBar: '#', currentSelection size printString, ':', (str copyFrom: 1 to: (str size min: 70)), ' ...'
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> setMenu [
	| b |
	b := RTMenuBuilder new view: view.	"adding"
	b
		menu: 'add nodes'
		submenu: 'packages'
		background: Color red
		callback: [ self pressAddPackages ].
	b
		menu: 'add nodes'
		submenu: 'classes'
		background: Color red
		callback: [ self pressAddClasses ].
	b
		menu: 'layout'
		submenu: 'grid'
		background: Color red
		callback: [ self applyLayout: RTGridLayout new ].
	b
		menu: 'layout'
		submenu: 'flow'
		background: Color red
		callback: [ self applyLayout: RTFlowLayout new ].
	b
		menu: 'layout'
		submenu: 'tree'
		background: Color red
		callback: [ self applyLayout: RTTreeLayout new ].
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
		callback: [ self setSelectionToColor: Color red ].
	b
		menu: 'color'
		submenu: 'blue'
		background: Color green
		callback: [ self setSelectionToColor: Color blue ].
	b
		menu: 'color'
		submenu: 'green'
		background: Color green
		callback: [ self setSelectionToColor: Color green ].


	b
		menu: 'set x'
		submenu: 'NOA'
		background: Color blue
		callback: [ self pressSetX: #numberOfVariables ].	
	b
		menu: 'set x'
		submenu: 'NOM'
		background: Color blue
		callback: [ self pressSetX: #numberOfMethods ].
	b
		menu: 'set x'
		submenu: 'LOC'
		background: Color blue
		callback: [ self pressSetX: #numberOfLinesOfCode ].


	b
		menu: 'set x'
		submenu: 'NOAlog'
		background: Color blue
		callback: [ self pressSetXLog: #numberOfVariables ].	
	b
		menu: 'set x'
		submenu: 'NOMlog'
		background: Color blue
		callback: [ self pressSetXLog: #numberOfMethods ].
	b
		menu: 'set x'
		submenu: 'LOClog'
		background: Color blue
		callback: [ self pressSetXLog: #numberOfLinesOfCode ].

	b
		menu: 'set y'
		submenu: 'NOA'
		background: Color blue
		callback: [ self pressSetY: #numberOfVariables ].	
	b
		menu: 'set y'
		submenu: 'NOM'
		background: Color blue
		callback: [ self pressSetY: #numberOfMethods ].
	b
		menu: 'set y'
		submenu: 'LOC'
		background: Color blue
		callback: [ self pressSetY: #numberOfLinesOfCode ].


	b
		menu: 'set y'
		submenu: 'NOAlog'
		background: Color blue
		callback: [ self pressSetYLog: #numberOfVariables ].	
	b
		menu: 'set y'
		submenu: 'NOMlog'
		background: Color blue
		callback: [ self pressSetYLog: #numberOfMethods ].
	b
		menu: 'set y'
		submenu: 'LOClog'
		background: Color blue
		callback: [ self pressSetYLog: #numberOfLinesOfCode ].
		
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
RTPharoCodeAnalyzer >> setSelectionToColor: aColor [
	self currentSelection do: [ :e | e trachelShape color: aColor ].
	view signalUpdate
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> setStatusBar [

	statusBar := TRLabelShape new.
	view canvas addFixedShape: statusBar.
	TRConstraint stickAtTheBottomOfTheWindow: statusBar
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> setStatusBar: string [

	statusBar text: string.
	statusBar canvas announce: TRResizeCanvasEvent new.
	view signalUpdate.
	
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> translator [
	^ RTSmoothLayoutTranslator new 
			nbCycles: 0.5;
			view: view;
			yourself
]
