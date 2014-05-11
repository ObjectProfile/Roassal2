"
A RTExampleBrowser is the main class to browse examples of Roassal
"
Class {
	#name : #RTExampleBrowser,
	#superclass : #RTObject,
	#classInstVars : [
		'icon'
	],
	#category : #'Roassal2-ExampleBrowser'
}

{ #category : #menu }
RTExampleBrowser class >> menuCommandOn: aBuilder [
	<worldMenu>

	(aBuilder item: #'Roassal Examples')
		order: 0.1; 
		parent: #Tools;
		label: 'Roassal examples';
		icon: self roassalWithTransparentIcon;
		action:[ self new open ]
]

{ #category : #logo }
RTExampleBrowser class >> roassalWithTransparentIcon [
	"Private - Generated method"
	^ icon ifNil: [ icon := Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self roassalWithTransparentIconContents readStream) ].
]

{ #category : #logo }
RTExampleBrowser class >> roassalWithTransparentIconContents [
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

{ #category : #'instance creation' }
RTExampleBrowser >> open [

	| v p |
	v := RTView new.
	v @ RTDraggableView.
	RTAbstractExample subclasses do: [ :c |
		c new installOn: v ].
	
	self structure: v.
	
	v openInWindowSized: 300 @ 400 titled: 'Roassal'.
	
	"We set the camera position where it fits to. We need to do this since there is an animation"
	p := v canvas camera position.
	v canvas camera translateTo: 50 @ p y 
]

{ #category : #utility }
RTExampleBrowser >> structure: aView [
	"Structure a view with a proper layout and animation"
	RTVerticalLineLayout on: aView elements.
	aView elements doWithIndex: [ :each :index | 
		| p |
		p := each position.
		each translateBy: (index * 50) @ 0.
		aView addAnimation: (RTLinearMove to: p during: 0.4 on: each).
		  ]
]
