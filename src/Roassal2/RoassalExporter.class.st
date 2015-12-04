"
This is a custom class in order to export Roassal2 to VisualWorks
"
Class {
	#name : #RoassalExporter,
	#superclass : #Object,
	#instVars : [
		'dirpath',
		'namespace',
		'packages',
		'namespaces',
		'packagesInfo',
		'classes',
		'methods',
		'stream'
	],
	#category : #'Roassal2-ExporterVW'
}

{ #category : #accesing }
RoassalExporter >> categoryForMethod: method [
	^ method category ifNil: [ 'as yet unclassified' ]
]

{ #category : #accesing }
RoassalExporter >> classes [
	
	
	^ classes ifNil: [ classes := OrderedCollection new.
		self packages do: [ :pkg | classes addAll: pkg classes ].
		classes ].
]

{ #category : #accesing }
RoassalExporter >> environment [
	^ namespace
]

{ #category : #export }
RoassalExporter >> exportPackages: pkgs [
	packages := pkgs.
	"self fileOutDefinition."
	"pkgs do: [ :p | self exportPackage: p ]."
	
	[ 
	stream := FileStream forceNewFileNamed: dirpath, self environment, '.st'.
	stream nextPutAll: '<?xml version="1.0"?>';cr;cr.
	self tag: 'st-source' do: [ 
		self fileOutTimeStamp.
		self fileOutNameSpace.
		self fileOutClassDefinitions.
		self fileOutMethods.
		self fileOutInitializers. ].
	stream close.
	 ] ensure: [ stream close ].
]

{ #category : #export }
RoassalExporter >> fileOutClassCommentForClass: aClass [
	
	aClass hasComment ifFalse: [^self].
	stream cr.
	self tag: 'comment' do: [
		self tag: 'class-id' with: (self fullyQualifiedClassNameFor: aClass).
		self tag: 'body' with:  (((aClass comment asString copyReplaceAll: '&' with: '&amp;') copyReplaceAll: '<' with:  '&lt;' ) copyReplaceAll:  '>' with:  '&gt;').
	]
]

{ #category : #export }
RoassalExporter >> fileOutClassDefinition: aClass [
	stream cr.
	
	self tag: 'class' do: [
		self tag: 'name' with: aClass name.
		self tag: 'environment' with: self environment.
		self tag: 'super' with: (self fullyQualifiedClassNameFor: aClass superclass).
		self tag: 'private' with: 'false'.
		self tag: 'indexed-type' with: (self mapType: aClass typeOfClass).
		self tag: 'inst-vars' with: aClass instanceVariablesString.
		self tag: 'class-inst-vars' with: aClass class instanceVariablesString.
		self tag: 'imports' with: ''.
		self tag: 'category' with: aClass category.
		self tag: 'attributes' do: [
			self tag: 'package' with: (self packageNameForClass: aClass).
		]
	].

	aClass classPool keys do: [:ea | self fileOutClassVariable: ea class: aClass].
	
	self fileOutClassCommentForClass: aClass
]

{ #category : #export }
RoassalExporter >> fileOutClassDefinitions [
	(Class superclassOrder: self classes)
		do: [:ea | self fileOutClassDefinition: ea]
		displayingProgress: 'Filing out classes...'
]

{ #category : #export }
RoassalExporter >> fileOutClassVariable: aSymbol class: aClass [
	stream cr; cr.
	
	self tag: 'shared-variable' do: [
		self tag: 'name' with: aSymbol.
		self tag: 'environment' with: (self fullyQualifiedClassNameFor: aClass).
		self tag: 'private' with: 'false'.
		self tag: 'constant' with: 'false'.
		self tag: 'category' with: 'class variables'.
		self tag: 'initializer' with: 'nil'.
		self tag: 'attributes' do: [
			self tag: 'package' with: (self packageNameForClass: aClass).
		]
	]
]

{ #category : #export }
RoassalExporter >> fileOutDefinition [
	
	[
	stream := FileStream forceNewFileNamed: dirpath, namespace, '.st'.
	stream nextPutAll: '<?xml version="1.0"?>';cr;cr.
	self tag:'st-source' do: [ 
		self fileOutTimeStamp.
		self fileOutNameSpace.
		 ].
	] 
	ensure: [ stream close ]
]

{ #category : #export }
RoassalExporter >> fileOutInitializerForClass: aClass [
	"self tag: 'initialize' do: [
		self tag: 'class-id' with: (self fullyQualifiedClassNameFor: aClass)
	]"
]

{ #category : #export }
RoassalExporter >> fileOutInitializers [		
	(self classes select: [:c | c class includesSelector: #initialize])
		do: [:class | self fileOutInitializerForClass: class].
]

{ #category : #export }
RoassalExporter >> fileOutMethod: aMethodReference [
	self tag: 'methods' do: [
		aMethodReference realClass == Color 
			ifTrue: [ self tag: 'class-id' with: 'ColorValue' ]
			ifFalse: [ self tag: 'class-id' 
				with: (self fullyQualifiedClassNameFor: aMethodReference realClass)].
		self tag: 'category' with: (self categoryForMethod: aMethodReference).
		self fileOutMethodBody: aMethodReference.
	]
]

{ #category : #export }
RoassalExporter >> fileOutMethodBody: aMethodReference [
	| ref methodString |
	methodString := self prettyPrint: aMethodReference sourceCode asString.

	"See if an extension method includes a reference to some of our classes"
	ref := self getClassNamesUsedIn: aMethodReference.
	"Prefix the class names with the target namespace"
	ref do: 
		[:className |
		methodString := methodString
				copyReplaceTokens: className 
				with: self environment , '.' , className].
	stream
		nextPutAll: '<body package="';
		nextPutAll: (self packageNameForMethod: aMethodReference);
		nextPutAll: '">';
		nextPutAll: (((methodString copyReplaceAll: '&' with: '&amp;') copyReplaceAll: '<' with:  '&lt;' ) copyReplaceAll:  '>' with:  '&gt;');
		nextPutAll: '</body>';
		cr
]

{ #category : #export }
RoassalExporter >> fileOutMethods [
	self methods
		do: [:ea | self fileOutMethod: ea]
		displayingProgress: 'Filing out methods...'
]

{ #category : #export }
RoassalExporter >> fileOutNameSpace [

	self tag: 'name-space' do: [
		self tag: 'name' with: self environment.
		self tag: 'environment' with: 'Smalltalk'.
		self tag: 'private' with: 'false'.
		self tag: 'imports' do: [
			stream nextPutAll: self nameSpaceImports; cr.
		].
		self tag: 'category' with: self environment.
		self tag: 'attributes' do: [
			self tag: 'package' with: self environment.
		].
	]
]

{ #category : #export }
RoassalExporter >> fileOutTimeStamp [
	self tag: 'time-stamp'
		with: 'From ', Smalltalk version, ' on ', Date today printString, ' at ', Time now printString.
]

{ #category : #export }
RoassalExporter >> fullyQualifiedClassNameFor: aClass [

	^ (self includesClass: aClass)
		ifTrue: [self environment, '.', aClass name]
		ifFalse: [ | pkg |
			pkg := self packageFor: aClass.
			pkg ifNil: [ aClass visualworksName]
			ifNotNil: [ pkg namespace, '.', aClass name ]
			].
]

{ #category : #export }
RoassalExporter >> getClassNamesUsedIn: aMethodReference [ 
	"Answers the names of those of our classes that are referenced
	an extension method"
	(self classes includes: aMethodReference realClass theNonMetaClass)
		ifTrue: ["Not an extension method"
			^ #()].
	^ (aMethodReference literals
		select: [:lit | lit class == GlobalVariable
				and: [lit value isBehavior
						and: [lit key == lit value name
								and: [self mustBeQualified: lit value]]]])
		collect: [:lit | lit key]
]

{ #category : #testing }
RoassalExporter >> includesClass: class [
	| c |
	c := class isMeta ifTrue: [ class soleInstance ] ifFalse: [ class ].
	packagesInfo do: [ :pkg | (pkg includesClass: c) ifTrue: [ ^ true. ] ].
	^ false.
]

{ #category : #export }
RoassalExporter >> mapType: aSymbol [
	aSymbol == #normal ifTrue: [^ #none].
	aSymbol == #variable ifTrue: [^ #objects].
	^ aSymbol

]

{ #category : #accesing }
RoassalExporter >> methods [

	^ methods ifNil: [ 
		methods := OrderedCollection new.
		self packages do: [ :pkg | methods addAll: pkg asRPackage methods ].
		methods ].
]

{ #category : #export }
RoassalExporter >> mustBeQualified: aClass [
	"Answer true if namespace must be qualified with namespace"
	aClass = Color ifTrue: [ ^ true ].
	^(self classes includes: aClass)
		or: [aClass name beginsWith: 'WA']
]

{ #category : #accesing }
RoassalExporter >> nameSpaceImports [
	| imports result |
	imports := Set with: #Smalltalk with: #Squeak.
	imports addAll: self namespaces.
	self classes do: 
		[ :ea | 
		(ea name copyFrom: 1 to: 2) = 'WA' ifTrue: [ imports add: #Seaside ].
		(ea superclass name copyFrom: 1 to: 2) = 'WA' ifTrue: [ imports add: #Seaside ] ].
	imports remove: self environment asSymbol ifAbsent:["it was not there"].
	result := String new writeStream.
	imports do: 
		[ :ea | 
		result
			nextPutAll: 'private ';
			nextPutAll: ea;
			nextPutAll: '.*' ]
		separatedBy: [ result space ].
	^ result contents
]

{ #category : #accesing }
RoassalExporter >> namespaces [
	^ namespaces ifNil: [ namespaces := {  } ].
]

{ #category : #accesing }
RoassalExporter >> namespaces: array [
	namespaces := array.
]

{ #category : #accesing }
RoassalExporter >> packageFor: aClass [
	self namespaces do: [ :name | | pkg |
		pkg := RPackageOrganizer default packageNamed: name.
		(pkg includesClass: aClass) ifTrue: [ ^ pkg ] ].
	^ nil.
]

{ #category : #export }
RoassalExporter >> packageNameForClass: aClass [
	^ aClass theNonMetaClass category
]

{ #category : #export }
RoassalExporter >> packageNameForMethod: aMethodReference [
	^ (self includesClass: aMethodReference realClass)
		ifTrue: [self packageNameForClass: aMethodReference realClass]
		ifFalse: [package externalName, '-Extensions']
]

{ #category : #accesing }
RoassalExporter >> packages [
	^ packagesInfo ifNil: [ packagesInfo := OrderedCollection new.
		
		packages do: [ :asso | | pkg |
			pkg := RPackageOrganizer default packageNamed: asso key.
			asso value do: [ :tag | 
				packagesInfo add: (pkg classTagNamed: tag) ]
			 ].
		packagesInfo ].
]

{ #category : #export }
RoassalExporter >> prettyPrint: aString [ 
	"Replace _ with := unless it is preceded with $ or a single quote"
	| previousChar withinQuotes withinComments |
	previousChar := nil.
	withinQuotes := false.
	withinComments := false.
	^String
				streamContents: [:s | aString
						do: [:c | c = $" & withinQuotes not
								ifTrue: [withinComments := withinComments not.
									s nextPut: c.
									previousChar := nil]
								ifFalse: [c = $' & withinComments not
										ifTrue: [withinQuotes := withinQuotes not.
											s nextPut: c.
											previousChar := nil]
										ifFalse: [(c = $_
													and: [withinQuotes not
															and: [withinComments not
																	and: [(#($$ $' ) includes: previousChar) not]]])
												ifTrue: [s nextPutAll: ':=']
												ifFalse: [s nextPut: c].
											previousChar := c]]]].
		

]

{ #category : #tags }
RoassalExporter >> tag: aString do: aBlock [
	stream
		nextPutAll: '<';
		nextPutAll: aString;
		nextPutAll: '>';
		cr.
		
	aBlock value.
	stream
		nextPutAll: '</';
		nextPutAll: aString;
		nextPutAll: '>';
		cr.
		
]

{ #category : #tags }
RoassalExporter >> tag: aString with: contentString [
	stream nextPutAll: '<';
		nextPutAll: aString;
		nextPutAll: '>';
		nextPutAll: contentString;
		nextPutAll: '</';
		nextPutAll: aString;
		nextPutAll: '>';
		cr.
]

{ #category : #export }
RoassalExporter >> to: path namespace: name [
	dirpath := path.
	namespace := name.
]
