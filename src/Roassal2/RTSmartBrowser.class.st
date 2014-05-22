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

{ #category : #adding }
RTSmartBrowser >> addClasses: classes [
	"Add a list of Pharo classes"
	
	| es shape |
	shape := RTBox new
		height: [ :c | c numberOfMethods max: 5 ];
		width: [ :c | c numberOfVariables * 4 max: 5 ];
		color: (Color gray alpha: 0.4).
	es := shape elementsOn: classes.
	es @ RTPopup @ RTDraggable.
	view addAll: es.
	RTEdge
		buildEdgesFromObjects: classes
		from: #superclass
		to: #yourself
		using: (RTLine new attachPoint: RTVerticalAttachPoint instance)
		inView: view.
		
"We look for the hierarchy root"	"	es do: [ :el | 
		(classes includes: el model superclass)
			ifFalse: [ el @ RTLabelled ] ].
"
	es
		when: TRMouseClick
		do: [ :e | 
			self expandClassElement: e element.
			self applyLayout: RTTreeLayout new ].
	self setStatusBar: classes size printString , ' added classes'.
	currentSelection := view elementsFromModels: classes.
	self applyLayout: RTTreeLayout new
]

{ #category : #adding }
RTSmartBrowser >> addClassesFromRegExp: regExp [
	| classes |
	classes := self getClassesMatching: regExp.
	self addClasses: classes
]

{ #category : #adding }
RTSmartBrowser >> addPackagesFromRegExp: regExp [
	| paks |
	paks := RPackageOrganizer default packages select: [ :p | regExp match: p name ].
	self addClasses: (paks flatCollect: #definedClasses)
]

{ #category : #'UI effects' }
RTSmartBrowser >> applyLayout: layout [
	layout
		translator: self translator;
		on: self currentSelection
]

{ #category : #accessing }
RTSmartBrowser >> currentSelection [
	"Return a list of elements that is currently selected"
	^ RTGroup withAll: currentSelection 
]

{ #category : #'UI effects' }
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

{ #category : #accessing }
RTSmartBrowser >> getClassesMatching: regExp [
	^ self getClassesMatching: regExp from: Smalltalk allClasses
]

{ #category : #accessing }
RTSmartBrowser >> getClassesMatching: regExp from: setOfClasses [
	^ setOfClasses select: [ :c | regExp match: c name ]
]

{ #category : #initialization }
RTSmartBrowser >> initialize [
	super initialize.
	view := RTView new. 
	view @ RTDraggableView.

	self setMenu.
	self setStatusBar.
	currentSelection := #()
]

{ #category : #accessing }
RTSmartBrowser >> notSelectedElements [
	"Return a list of elements that are __not__ currently selected"
	^ RTGroup withAll: (view elements copyWithoutAll: self currentSelection)
]

{ #category : #opening }
RTSmartBrowser >> open [
	view open
]

{ #category : #callbacks }
RTSmartBrowser >> pressAddClasses [
	| regExp |
	regExp := UIManager default request: 'Enter a regexp for classes (e.g., Layout)'.
	regExp ifNil: [ ^ self ].
	self addClassesFromRegExp: regExp
]

{ #category : #callbacks }
RTSmartBrowser >> pressAddPackages [
	| regExp |
	regExp := UIManager default request: 'Enter a regexp for packages (e.g., *Roassal*)'.
	regExp ifNil: [ ^ self ].
	self addPackagesFromRegExp: regExp
]

{ #category : #callbacks }
RTSmartBrowser >> pressCleanInterCategoriesEdges [
	view edges copy do: [ :edge | (edge from model category ~= edge to model category) ifTrue: [ edge remove ] ].
	view signalUpdate
]

{ #category : #callbacks }
RTSmartBrowser >> pressCleanInterPackagesEdges [
	view edges copy do: [ :edge | (edge from model package ~~ edge to model package) ifTrue: [ edge remove ] ].
	view signalUpdate
]

{ #category : #callbacks }
RTSmartBrowser >> pressColorPerCategory [
	| categories n |
	categories := self shownCategories.
	n := RTMultiLinearColor new.
	n colors: (ColorPalette qualitative colors: 8 scheme:'Set2').
	view elements do: [ :e | e trachelShape color: (n level: ((categories indexOf: e model category) / categories size)) ].
	
	view signalUpdate
]

{ #category : #callbacks }
RTSmartBrowser >> pressFindClass [
	| regExp clss cls clsElement index |
	regExp := UIManager default request: 'Enter a class name (e.g., a fraction of a classname, a reg exp)'.
	regExp ifNil: [ ^ self ].
	
	clss := self getClassesMatching: '*', regExp, '*' from: self shownClasses.
	clss size = 0 ifTrue: [ ^ self ].
	clss size = 1 ifTrue: [ cls := clss first ].
	clss size > 1 ifTrue: [ 
		index := UIManager default chooseFrom: clss. 
		index = 0 ifTrue: [ ^ self ].
		cls := clss at: index ].

	clsElement := view elementFromModel: cls.
	clsElement ifNil: [ ^ self ].
	view canvas camera translateTo: clsElement position.
	RTBlink on: clsElement
]

{ #category : #callbacks }
RTSmartBrowser >> pressLayoutPerCategory [
	| categories groups clss currentGroup |
	clss := view elements collect: #model.
	categories := (clss collect: #category) asSet asSortedCollection.
	groups := OrderedCollection new.
	
	categories do: [ :p |
		currentGroup := RTGroup new.
		clss do: [ :cls | (cls category = p) ifTrue: [ currentGroup add: (view elementFromModel: cls) ] ].
		groups add: currentGroup
		 ].
	
	groups do: [ :g |
		RTTreeLayout new
			on: g
	].
	RTFlowLayout new
		translator: self translator;
		on: groups
		

]

{ #category : #callbacks }
RTSmartBrowser >> pressLayoutPerPackage [
	| packages groups clss currentGroup |
	clss := view elements collect: #model.
	packages := (clss collect: #package) asSet asSortedCollection: [ :p1 :p2 | p1 name < p2 name ].
	groups := OrderedCollection new.
	
	packages do: [ :p |
		currentGroup := RTGroup new.
		clss do: [ :cls | (cls package == p) ifTrue: [ currentGroup add: (view elementFromModel: cls) ] ].
		groups add: currentGroup
		 ].
	
	groups do: [ :g |
		RTTreeLayout new
			translator: self translator;
			on: g
	].
	RTFlowLayout new
		translator: self translator;
		on: groups
		


"	RTFlowLayout on
		translator: self translator;
		on: self currentSelection"
]

{ #category : #callbacks }
RTSmartBrowser >> pressMoveRight [
	^ TRConstraint move: self currentSelection onTheRightOf: self notSelectedElements using: self translator
]

{ #category : #callbacks }
RTSmartBrowser >> pressSelect [
	| regExp  str |
	regExp := UIManager default request: 'Enter a regexp for elements (e.g., RTShape)'.
	regExp ifNil: [ ^ self ].
	
	self selectFromRegExp: regExp
]

{ #category : #selection }
RTSmartBrowser >> selectFromRegExp: regExp [
	| str |	
	currentSelection := view elements select: [ :el | '*', regExp, '*' match: el model asString ].

	str := (currentSelection collect: #model) asString.
	self setStatusBar: '#', currentSelection size printString, ':', (str copyFrom: 1 to: (str size min: 70)), ' ...'
]

{ #category : #'UI initialization' }
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
		submenu: 'per package'
		background: Color red
		callback: [ self pressLayoutPerPackage ].
	b
		menu: 'layout'
		submenu: 'per category'
		background: Color red
		callback: [ self pressLayoutPerCategory ].

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
		submenu: 'per category'
		background: Color green
		callback: [ self pressColorPerCategory ].
	
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
		menu: 'Clean'
		submenu: 'All'
		background: Color blue
		callback: [ view clean ].
	b
		menu: 'Clean'
		submenu: 'Inter packages edges'
		background: Color blue
		callback: [ self pressCleanInterPackagesEdges ].
	b
		menu: 'Clean'
		submenu: 'Inter categories edges'
		background: Color blue
		callback: [ self pressCleanInterCategoriesEdges ].
	
		
		
		
	b
		menu: 'Find'
		submenu: 'class'
		background: Color blue
		callback: [ self pressFindClass ].



"	b
		menu: '+partition'
		background: Color blue
		callback: [ self pressAddPartition ]" 
]

{ #category : #selection }
RTSmartBrowser >> setSelectionToColor: aColor [
	self currentSelection do: [ :e | e trachelShape color: aColor ].
	view signalUpdate
]

{ #category : #'UI initialization' }
RTSmartBrowser >> setStatusBar [

	statusBar := TRLabelShape new.
	view canvas addFixedShape: statusBar.
	TRConstraint stickAtTheBottomOfTheWindow: statusBar
]

{ #category : #'UI initialization' }
RTSmartBrowser >> setStatusBar: string [

	statusBar text: string.
	statusBar canvas announce: TRResizeCanvasEvent new.
	view signalUpdate.
	
]

{ #category : #accessing }
RTSmartBrowser >> shownCategories [

	| clss categories |
	clss := view elements collect: #model.
	categories := (clss collect: #category) asSet asSortedCollection.
	^ categories
]

{ #category : #accessing }
RTSmartBrowser >> shownClasses [
	"Return the list of methods currently displayed"
	^ view elements collect: #model
]

{ #category : #utility }
RTSmartBrowser >> translator [
	^ RTSmoothLayoutTranslator new 
			nbCycles: 0.5;
			view: view;
			yourself
]
