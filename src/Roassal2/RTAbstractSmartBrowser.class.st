Class {
	#name : #RTAbstractSmartBrowser,
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

{ #category : #adding }
RTAbstractSmartBrowser >> addClasses: classes [
	"Add a list of Pharo classes"

	| es |
	es := self shapeForClass elementsOn: classes.
	es @ RTPopup @ RTDraggable.
	view addAll: es.
	RTEdge
		buildEdgesFromObjects: classes
		from: #superclass
		to: #yourself
		using: (RTLine new attachPoint: RTVerticalAttachPoint instance)
		inView: view.	"We look for the hierarchy root"	"	es do: [ :el | 
		(classes includes: el model superclass)
			ifFalse: [ el @ RTLabelled ] ].
"
	es
		when: TRMouseClick
		do: [ :e | 
			(self isElementExpanded: e element)
				ifTrue: [ self shrinkClassElement: e element ]
				ifFalse: [ self expandClassElement: e element ].
			self applyLayout: RTTreeLayout new ].
	self setStatusBar: classes size printString , ' added classes'.
	currentSelection := view elementsFromModels: classes.
	self applyLayout: RTTreeLayout new
]

{ #category : #adding }
RTAbstractSmartBrowser >> addClassesMatching: matchingPattern [
	| classes |
	classes := self getClassesMatching: matchingPattern.
	self addClasses: classes
]

{ #category : #'UI effects' }
RTAbstractSmartBrowser >> addInteractionToMethods: methodElements [
	methodElements @ (RTPopup new text: [ :cm | cm getSource asString ]).
	methodElements
		when: TRMouseClick
		do: [ :event | 
			self clickOnMethod: event element model ]
]

{ #category : #adding }
RTAbstractSmartBrowser >> addPackagesMatching: matchingPattern [
	| paks |
	paks := RPackageOrganizer default packages select: [ :p | matchingPattern match: p name ].
	self addClasses: ((paks flatCollect: #definedClasses) reject: #isTrait )
]

{ #category : #'UI effects' }
RTAbstractSmartBrowser >> applyLayout: layout [
	layout
		translator: self translator;
		on: self currentSelection
]

{ #category : #hooks }
RTAbstractSmartBrowser >> clickOnClass: event [
	"To be overridden"


]

{ #category : #hooks }
RTAbstractSmartBrowser >> clickOnMethod: event [
	"To be overridden"

		"model := Pitekun new view: view; addCompiledMethod: event element model.
			element := view elementFromModel: model. "
]

{ #category : #accessing }
RTAbstractSmartBrowser >> currentSelection [
	"Return a list of elements that is currently selected"
	^ RTGroup withAll: currentSelection 
]

{ #category : #'UI effects' }
RTAbstractSmartBrowser >> expandClassElement: classElement [
	"Method called when one press on a class to expand it"
	| class methods methodElements edges |
	class := classElement model.
	self clickOnClass: class.
	methods := class methods.
	classElement attributes at: #oldExtent put: classElement extent.
	classElement attributes at: #oldColor put: classElement trachelShape color.
	classElement trachelShape color: (Color blue alpha: 0.3).
	methodElements := self shapeForMethod elementsOn: methods.
	view addAll: methodElements.
	edges := RTEdge
		buildEdgesFromObjects: methods
		from: #yourself
		toAll: #dependentMethods
		using: self shapeForDependentMethods
		inView: view.
	RTTreeLayout on: methodElements.
	self addInteractionToMethods: methodElements.
	RTNest new on: classElement nest: methodElements.
	classElement attributes at: #methods put: methodElements.
	classElement attributes at: #edges put: edges.
	self markElementAsExpanded: classElement
]

{ #category : #accessing }
RTAbstractSmartBrowser >> getClassesMatching: regExp [
	^ self getClassesMatching: regExp from: Smalltalk allClasses
]

{ #category : #accessing }
RTAbstractSmartBrowser >> getClassesMatching: regExp from: setOfClasses [
	^ setOfClasses select: [ :c | regExp match: c name ]
]

{ #category : #initialization }
RTAbstractSmartBrowser >> initialize [
	super initialize.
	self initializeView: RTView new. 
	view @ RTDraggableView.
	currentSelection := #()
]

{ #category : #initialization }
RTAbstractSmartBrowser >> initializeView: aView [
	view := aView.
	self setMenu.
	self setStatusBar.
]

{ #category : #testing }
RTAbstractSmartBrowser >> isElementExpanded: anElement [
	^ anElement hasAttribute: #isExpanded
]

{ #category : #utility }
RTAbstractSmartBrowser >> markElementAsExpanded: classElement [
	classElement attributes at: #isExpanded put: true
]

{ #category : #'UI effects' }
RTAbstractSmartBrowser >> markElementAsShrinked: classElement [
	classElement attributes removeKey: #isExpanded
]

{ #category : #accessing }
RTAbstractSmartBrowser >> notSelectedElements [
	"Return a list of elements that are __not__ currently selected"
	^ RTGroup withAll: (view elements copyWithoutAll: self currentSelection)
]

{ #category : #opening }
RTAbstractSmartBrowser >> open [
	view open
]

{ #category : #callbacks }
RTAbstractSmartBrowser >> pressAddClasses [
	| matchingPattern |
	matchingPattern := UIManager default request: 'Enter a matching pattern for classes (e.g., Layout)'.
	matchingPattern ifNil: [ ^ self ].
	self addClassesMatching: matchingPattern
]

{ #category : #callbacks }
RTAbstractSmartBrowser >> pressAddPackages [
	| matchingPattern |
	matchingPattern := UIManager default request: 'Enter a matching pattern for packages (e.g., *Roassal*)'.
	matchingPattern ifNil: [ ^ self ].
	self addPackagesMatching: matchingPattern
]

{ #category : #callbacks }
RTAbstractSmartBrowser >> pressCleanInterCategoriesEdges [
	view edges copy do: [ :edge | (edge from model category ~= edge to model category) ifTrue: [ edge remove ] ].
	view signalUpdate
]

{ #category : #callbacks }
RTAbstractSmartBrowser >> pressCleanInterPackagesEdges [
	view edges copy do: [ :edge | (edge from model package ~~ edge to model package) ifTrue: [ edge remove ] ].
	view signalUpdate
]

{ #category : #callbacks }
RTAbstractSmartBrowser >> pressColorPerCategory [
	| categories n |
	categories := self shownCategories.
	n := RTMultiLinearColor new.
	n colors: (ColorPalette qualitative colors: 8 scheme:'Set2').
	view elements do: [ :e | e trachelShape color: (n level: ((categories indexOf: e model category) / categories size)) ].
	
	view signalUpdate
]

{ #category : #callbacks }
RTAbstractSmartBrowser >> pressFindClass [
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
RTAbstractSmartBrowser >> pressLayoutPerCategory [
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
RTAbstractSmartBrowser >> pressLayoutPerPackage [
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
RTAbstractSmartBrowser >> pressMoveRight [
	^ TRConstraint move: self currentSelection onTheRightOf: self notSelectedElements using: self translator
]

{ #category : #callbacks }
RTAbstractSmartBrowser >> pressSelect [
	| regExp  str |
	regExp := UIManager default request: 'Enter a regexp for elements (e.g., RTShape)'.
	regExp ifNil: [ ^ self ].
	
	self selectFromRegExp: regExp
]

{ #category : #selection }
RTAbstractSmartBrowser >> selectFromRegExp: regExp [
	| str |	
	currentSelection := view elements select: [ :el | '*', regExp, '*' match: el model asString ].

	str := (currentSelection collect: #model) asString.
	self setStatusBar: '#', currentSelection size printString, ':', (str copyFrom: 1 to: (str size min: 70)), ' ...'
]

{ #category : #'UI initialization' }
RTAbstractSmartBrowser >> setMenu [
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
RTAbstractSmartBrowser >> setSelectionToColor: aColor [
	self currentSelection do: [ :e | e trachelShape color: aColor ].
	view signalUpdate
]

{ #category : #'UI initialization' }
RTAbstractSmartBrowser >> setStatusBar [

	statusBar := TRLabelShape new.
	view canvas addFixedShape: statusBar.
	TRConstraint stickAtTheBottomOfTheWindow: statusBar
]

{ #category : #'UI initialization' }
RTAbstractSmartBrowser >> setStatusBar: string [

	statusBar text: string.
	statusBar canvas announce: TRResizeCanvasEvent new.
	view signalUpdate.
	
]

{ #category : #hooks }
RTAbstractSmartBrowser >> shapeForClass [
	^ RTBox new
		height: [ :c | c numberOfMethods max: 5 ];
		width: [ :c | c numberOfVariables * 4 max: 5 ];
		color: (Color gray alpha: 0.4)
]

{ #category : #'UI effects' }
RTAbstractSmartBrowser >> shapeForDependentMethods [
	^ RTLine new
		color: (Color blue alpha: 0.3);
		attachPoint: RTVerticalAttachPoint instance
]

{ #category : #hooks }
RTAbstractSmartBrowser >> shapeForMethod [
	^ RTBox new size: [ :c | c numberOfLinesOfCode max: 5 ]
]

{ #category : #accessing }
RTAbstractSmartBrowser >> shownCategories [

	| clss categories |
	clss := view elements collect: #model.
	categories := (clss collect: #category) asSet asSortedCollection.
	^ categories
]

{ #category : #accessing }
RTAbstractSmartBrowser >> shownClasses [
	"Return the list of methods currently displayed"
	^ view elements collect: #model
]

{ #category : #'UI effects' }
RTAbstractSmartBrowser >> shrinkClassElement: classElement [
	"We removed the inner methods"
	| methods |
	methods := classElement attributes at: #methods.
	methods do: [ :m | m connectedEdges do: #remove. m remove ].
	classElement trachelShape color: (classElement attributes at: #oldColor).
	(classElement attributes at: #edges) do: #remove.

	classElement attributes removeKey: #methods.
	classElement attributes removeKey: #oldColor.
	classElement attributes removeKey: #edges.
	
	RTResizeMove new
		toExtent: (classElement attributes at: #oldExtent) during: 0.2 on: classElement;
		after: [ self applyLayout: RTTreeLayout new ];
		inView: view.
	
	self markElementAsShrinked: classElement.
	self clickOnClass: classElement model.
]

{ #category : #utility }
RTAbstractSmartBrowser >> translator [
	^ RTSmoothLayoutTranslator new 
			nbCycles: 0.5;
			view: view;
			yourself
]

{ #category : #accessing }
RTAbstractSmartBrowser >> view [
	^ view
]
