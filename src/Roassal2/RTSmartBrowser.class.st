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
		parent: #Roassal;
		label: 'Pharo Smart Browser';
		icon: RTIcon smallRoassal;
		action:[ self new open ]
]

{ #category : #logo }
RTSmartBrowser class >> roassalWithTransparentIcon [
	"Private - Generated method"
	^ icon ifNil: [ icon := Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self roassalWithTransparentIconContents readStream) ].
]

{ #category : #logo }
RTSmartBrowser class >> roassalWithTransparentIconContents [
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
	| el |
	visitedMethods addFirst: aCompiledMethod.
	visitedMethods size > 10 ifTrue: [ visitedMethods := visitedMethods copyFrom: 1 to: 10 ].
	
	visitedMethods do: [ :m | 
		el := view elementFromModel: m.
		el ifNotNil: [ el update ] ].
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
