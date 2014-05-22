Class {
	#name : #RTSmartBrowser,
	#superclass : #RTAbstractSmartBrowser,
	#category : #'Roassal2-DataStudio'
}

{ #category : #menu }
RTSmartBrowser class >> menuCommandOn: aBuilder [
	<worldMenu>

	(aBuilder item: #'Pharo Small Browser')
		order: 0.1; 
		parent: #Tools;
		label: 'Pharo Smart Browser';
		icon: self roassalWithTransparentIcon;
		action:[ self new open ]
]

{ #category : #logo }
RTSmartBrowser class >> roassalWithTransparentIcon [
	"Private - Generated method"
	^ icon ifNil: [ icon := Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self roassalWithTransparentIconContents readStream) ].
]

{ #category : #logo }
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

{ #category : #hooks }
RTSmartBrowser >> clickOnMethod: event [
	^ self makeNautilusPointTo: event element model
]

{ #category : #'UI effects' }
RTSmartBrowser >> makeNautilusPointTo: aCompiledMethod [
	| instance |
	instance := PackageTreeNautilus allInstances first.
	instance showMethod: aCompiledMethod.
	^ instance ui window activate
]
