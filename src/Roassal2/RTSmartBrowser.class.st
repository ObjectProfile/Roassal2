Class {
	#name : #RTSmartBrowser,
	#superclass : #RTAbstractSmartBrowser,
	#instVars : [
		'visitedMethods',
		'visitedClasses'
	],
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

{ #category : #'as yet unclassified' }
RTSmartBrowser >> addVisitedClass: aClass [
	| el |
	visitedClasses addFirst: aClass.
	visitedClasses size > 10 ifTrue: [ visitedClasses := visitedClasses copyFrom: 1 to: 10 ].
	
	visitedClasses do: [ :c | 
		el := (view elementFromModel: c).
		el trachelShape color: (el shape colorFor: el) ].
	view signalUpdate.

]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> addVisitedMethod: aCompiledMethod [
	visitedMethods addFirst: aCompiledMethod.
	visitedMethods size > 10 ifTrue: [ visitedMethods := visitedMethods copyFrom: 1 to: 10 ].
	
	visitedMethods do: [ :m | (view elementFromModel: m) update ].
	view signalUpdate.

]

{ #category : #hooks }
RTSmartBrowser >> clickOnClass: aClass [
	self addVisitedClass: aClass.
]

{ #category : #hooks }
RTSmartBrowser >> clickOnMethod: compiledMethod [
	self addVisitedMethod: compiledMethod.
	^ self makeNautilusPointTo: compiledMethod
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> initialize [
	super initialize.
	visitedMethods := OrderedCollection new.
	visitedClasses := OrderedCollection new
]

{ #category : #'UI effects' }
RTSmartBrowser >> makeNautilusPointTo: aCompiledMethod [
	| instance |
	instance := PackageTreeNautilus allInstances first.
	instance showMethod: aCompiledMethod.
	^ instance ui window activate
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> relevanceOfClass: aClass [
	"Return a value between 0.0 (not relevant) and 1.0 (highly relevant)"
	(visitedClasses includes: aClass) ifFalse: [ ^ 0.0 ].
	^ (visitedClasses size - (visitedClasses indexOf: visitedClasses) / visitedClasses size) asFloat
]

{ #category : #'as yet unclassified' }
RTSmartBrowser >> relevanceOfMethod: aCompiledMethod [
	"Return a value between 0.0 (not relevant) and 1.0 (highly relevant)"
	(visitedMethods includes: aCompiledMethod) ifFalse: [ ^ 0.0 ].
	^ (visitedMethods size  - (visitedMethods indexOf: aCompiledMethod) / visitedMethods size) asFloat
]

{ #category : #hooks }
RTSmartBrowser >> shapeForClass [

	| n |
	n := RTMultiLinearColor new colors: {Color lightGray . Color pink }.
				
	^ RTBox new
		height: [ :c | c numberOfMethods max: 5 ];
		width: [ :c | c numberOfVariables * 4 max: 5 ];
		color: [ :c | n level: (self relevanceOfClass: c) ]
]

{ #category : #hooks }
RTSmartBrowser >> shapeForMethod [
	| n |
	n := RTMultiLinearColor new colors: {Color gray . Color red }.
	^ RTBox new 
		size: [ :m | m numberOfLinesOfCode max: 5 ];
		color: [ :m | n level: (self relevanceOfMethod: m) ]
]
