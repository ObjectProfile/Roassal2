"
I am a class to export squeak files(Roassal) to Bee(a smalltalk system like pharo)

In first class order then methods, etc.
"
Class {
	#name : #Roassal2Bee,
	#superclass : #Object,
	#instVars : [
		'packages',
		'stream',
		'classes'
	],
	#category : #'Roassal2-ExporterVW'
}

{ #category : #accessing }
Roassal2Bee >> classes [
	
	^ classes ifNil: [ classes := OrderedCollection new.
		self packages do: [ :pkg | classes addAll: pkg classes ].
		classes ].
]

{ #category : #exporting }
Roassal2Bee >> defaultPackages [
	| tags nopkgs |
	nopkgs := {
		'Trachel-MorphSpecific'.
		 'Roassal2-OpenStreetMap'. 'Roassal2-MorphSpecific'. 'Roassal2-Plugins'. 'Roassal2-ExporterVW' }.
	
	tags := {'Roassal2'. 'Trachel'} flatCollect: [ :n | | pkg |
		pkg := RPackageOrganizer default packageNamed: n.
		pkg classTags.	 ].
	
	^ tags reject: [ :e | (nopkgs includes: e packageName,'-', e name) ].
]

{ #category : #public }
Roassal2Bee >> exportPackages: dir [
	"
	self new exportPackages: 'Roassal2bee.st'
	"
	
	| exporter |
	exporter := self class new.
	exporter exportPackages: exporter defaultPackages in: dir .

]

{ #category : #exporting }
Roassal2Bee >> exportPackages: pkgs in: path [
	packages := pkgs.
	stream := FileStream forceNewFileNamed: path.
	[ 
		self fileOutPackageDefinitions.
		self fileOutClassDefinitions.
		self fileOutMethods.
		self fileOutInitializers.
		stream close.
	 ] ensure: [ stream close ].
]

{ #category : #exporting }
Roassal2Bee >> fileOutClassDefinition: aClass [
	stream cr.
	stream nextChunkPut: aClass definition.
	aClass organization putCommentOnFile: stream forClass: aClass.
	stream cr; nextPut: Character newPage; cr 
]

{ #category : #exporting }
Roassal2Bee >> fileOutClassDefinitions [
	(Class superclassOrder: self classes)
		do: [:ea | self fileOutClassDefinition: ea]
		displayingProgress: 'Filing out classes...'
]

{ #category : #exporting }
Roassal2Bee >> fileOutPackageDefinitions [
	"TODO"
]

{ #category : #accessing }
Roassal2Bee >> packages [
	^ packages
]
