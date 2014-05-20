Class {
	#name : #RTPharoCodeAnalyzer,
	#superclass : #RTObject,
	#instVars : [
		'graph',
		'statusBar'
	],
	#classInstVars : [
		'icon'
	],
	#category : #'Roassal2-Builder-Graph'
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

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer class >> roassalWithTransparentIconContents [
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
RTPharoCodeAnalyzer >> graph [
	^ graph
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> initialize [
	super initialize.
	graph := RTGraphBuilder new. 
	graph nodes color: Color gray.

	self setMenu.
	self setStatusBar.

]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> open [
	graph open.
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> pressAddClasses [
	| regExp |
	regExp := UIManager default request: 'Enter a regexp for classes (e.g., RT*)'.
	regExp ifNil: [ ^ self ].
	self pressAddClasses: regExp
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> pressAddClasses: regExp [
	| classes |
	classes := Smalltalk allClasses select: [ :c | regExp match: c name ].
	graph addAll: classes.
	self setStatusBar: classes size printString, ' added nodes'
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> pressAddPackages [
	| regExp |
	regExp := UIManager default request: 'Enter a regexp for packages (e.g., *Roassal*)'.
	regExp ifNil: [ ^ self ].
	self pressAddPackages: regExp
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> pressAddPackages: regExp [
	| paks |
	paks := RPackageOrganizer default packages select: [ :p | regExp match: p name ].
	graph addAll: paks.
	self setStatusBar: paks size printString, ' added nodes'
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> pressLayout: layout [

	layout on: self currentSelection
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> pressSelect [
	| regExp elements str |
	regExp := UIManager default request: 'Enter a regexp for elements (e.g., RTShape)'.
	regExp ifNil: [ ^ self ].
	
	elements := graph view elements select: [ :el | '*', regExp, '*' match: el model asString ].
	str := (elements collect: #model) asString.
	self setStatusBar: (str copyFrom: 1 to: (str size min: 70)), ' ...'
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> setMenu [
	| b |

	b := RTMenuBuilder new view: graph view.

	"adding"
	b menu: 'add nodes' submenu: 'packages' background: Color red callback: [
		self pressAddPackages
	].

	b menu: 'add nodes' submenu: 'classes' background: Color red callback: [ 
		self pressAddClasses
	].

	b menu: 'layout' submenu: 'grid' background: Color red callback: [ 
		self pressLayout: RTGridLayout new
	].

	b menu: 'select' background: Color blue callback: [ 
		self pressSelect
	].
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> setStatusBar [

	statusBar := TRLabelShape new.
	graph view canvas addFixedShape: statusBar.
	TRConstraint stickAtTheBottomOfTheWindow: statusBar
]

{ #category : #'as yet unclassified' }
RTPharoCodeAnalyzer >> setStatusBar: string [

	statusBar text: string.
	statusBar canvas announce: TRResizeCanvasEvent new.
	graph view signalUpdate.
	
]
