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
		parent: #Roassal;
		label: 'Roassal evaluator';
		icon: RTIcon smallRoassal;
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

{ #category : #logo }
RTReadEvalLoop class >> roassalWithTransparentIconContents [
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
RTReadEvalLoop >> displayLine: aString [
]

{ #category : #'as yet unclassified' }
RTReadEvalLoop >> enterCharacter: c [
	currentText := currentText, c asString.
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
	self enterLine: '-->', currentText size printString color: Color blue.
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
