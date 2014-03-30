Class {
	#name : #RTReadEvalLoop,
	#superclass : #Object,
	#instVars : [
		'view',
		'currentText',
		'currentElement'
	],
	#classInstVars : [
		'icon'
	],
	#category : #'Roassal2-ReadEvalLoop'
}

{ #category : #'as yet unclassified' }
RTReadEvalLoop class >> menuCommandOn: aBuilder [
	<worldMenu>

	(aBuilder item: #'Roassal evaluator')
		order: 0.1; 
		parent: #Tools;
		label: 'Roassal evaluator';
		icon: self roassalWithTransparentIcon;
		action:[ self new open ]
]

{ #category : #'as yet unclassified' }
RTReadEvalLoop class >> readme [

"
Doit to import a new icon in .png

 ThemeIcons createIconMethodsFromFile: 'RoassalWithTransparent' directory: '/Users/alexandrebergel/Documents/ObjectProfile/Logos'
"
]

{ #category : #'as yet unclassified' }
RTReadEvalLoop class >> roassalWithTransparentIcon [
	"Private - Generated method"
	^ icon ifNil: [ icon := Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self roassalWithTransparentIconContents readStream) ].
]

{ #category : #'as yet unclassified' }
RTReadEvalLoop class >> roassalWithTransparentIconContents [
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
RTReadEvalLoop >> displayLine: aString [
]

{ #category : #'as yet unclassified' }
RTReadEvalLoop >> enterCharacter: c [
	currentText := currentText , c asString.
	currentElement trachelShape text: currentText
]

{ #category : #'as yet unclassified' }
RTReadEvalLoop >> enterLine: aText [
	currentText := aText.
	currentElement trachelShape text: currentText
]

{ #category : #'as yet unclassified' }
RTReadEvalLoop >> enterLine: aText color: aColor [
	currentText := aText.
	currentElement trachelShape 
							color: aColor;
							text: currentText
]

{ #category : #'as yet unclassified' }
RTReadEvalLoop >> initialize [
	super initialize.
	view := RTView new.
	view when: TRKeyDown do: [ :evt | self keyStroke: evt ].
	self newLine
]

{ #category : #'as yet unclassified' }
RTReadEvalLoop >> keyStroke: evt [
	| c |
	evt keyValue = 13
		ifTrue: [ ^ self pressEnter ].
	c := evt keyValue asCharacter.
	self enterCharacter: c.
	self refresh
]

{ #category : #'as yet unclassified' }
RTReadEvalLoop >> newLine [
	currentElement := RTLabel new elementOn: '?'.
	currentText := ''.
	view add: currentElement
]

{ #category : #'as yet unclassified' }
RTReadEvalLoop >> open [
	view open
]

{ #category : #'as yet unclassified' }
RTReadEvalLoop >> pressEnter [
	self scrollDown.
	self newLine.

	self scrollDown.
	self enterLine: 'Hello World!' color: Color blue.
	self newLine.
	self scrollDown.
	self refresh
]

{ #category : #'as yet unclassified' }
RTReadEvalLoop >> refresh [
	view canvas signalUpdate
]

{ #category : #'as yet unclassified' }
RTReadEvalLoop >> scrollDown [
	view elements do: [ :e | e translateBy: 0 @ -20 ]
]
