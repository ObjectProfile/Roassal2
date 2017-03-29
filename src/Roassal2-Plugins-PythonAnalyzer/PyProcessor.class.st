"
I am a simple python processor code, to analyze code and resolve dependecies
"
Class {
	#name : #PyProcessor,
	#superclass : #PyObject,
	#instVars : [
		'directoriesAsDictionary',
		'filesAsDictionary'
	],
	#category : #'Roassal2-Plugins-PythonAnalyzer-Core'
}

{ #category : #accessing }
PyProcessor >> classes [
	^ self files values flatCollect: #classes
]

{ #category : #accessing }
PyProcessor >> directories [
	^ directoriesAsDictionary
]

{ #category : #accessing }
PyProcessor >> files [
	^ filesAsDictionary
]

{ #category : #accessing }
PyProcessor >> functions [
	^ self files values flatCollect: #functions
]

{ #category : #initialization }
PyProcessor >> initialize [
	super initialize.
	filesAsDictionary := Dictionary new.
	directoriesAsDictionary := OrderedCollection new.
]

{ #category : #accessing }
PyProcessor >> moduleNamed: afilename [
	| fn |
	fn := afilename.
	(afilename beginsWith: '.') 
		ifTrue: [ fn := fn copyFrom: 2 to: fn size ].
	
	^ filesAsDictionary at: fn ifAbsent: [ | r |
		r := nil.
		filesAsDictionary keys do: [ :k | (k endsWith: fn) ifTrue: [ r := filesAsDictionary at: k ] ].
		r ].
]

{ #category : #accessing }
PyProcessor >> modules [
	^ filesAsDictionary values
]

{ #category : #metrics }
PyProcessor >> numberOfClasses [
	^ self classes size
]

{ #category : #metrics }
PyProcessor >> numberOfFiles [
	^ filesAsDictionary size
]

{ #category : #metrics }
PyProcessor >> numberOfFunctions [
	^ self functions size
]

{ #category : #metrics }
PyProcessor >> numberOfModules [
	^ filesAsDictionary size
]

{ #category : #processing }
PyProcessor >> processDirectories: listOfDirectories [
	"TODO"
]

{ #category : #processing }
PyProcessor >> processFileAsString: fileContentAsString named: filename [
	| f |
	f := PyFile new.
	f filename: filename.
	f initializeFromContentAsString: fileContentAsString.
	filesAsDictionary at: f baseFilename put: f
]

{ #category : #processing }
PyProcessor >> processRootFolder: aFileReference [
	| relevantFiles allFiles allDirectories |
	allFiles := aFileReference allChildren.
	allDirectories := allFiles select: #isDirectory.
	self processDirectories: allDirectories.
	relevantFiles := allFiles select: [ :f | #('py') includes: f extension ].
	relevantFiles do: [ :f |
		| r | 
		r := f readStream.
		r ascii.
		r converter: Latin1TextConverter new.
		self processFileAsString: r contents named: f pathString ].
]

{ #category : #'resolving dependencies' }
PyProcessor >> resolveDependencies [
	"Public method"
	self resolveDependenciesBetweenModules.
	self resolveDependenciesForClassInheritance.
]

{ #category : #'resolving dependencies' }
PyProcessor >> resolveDependenciesBetweenModules [
	self files copy do: [ :m | | ext |
		"Remove import named '.'"
		(m importedFilenames copyWithout: '.') do: [ :file | 
			| cleanedName substrings|
			"we exclude all the dots from the name"
			substrings := file substrings: '.'.
			"substrings can be empty if file is '..'"
			substrings ifNotEmpty: [ 
				cleanedName := substrings last.
				ext := self moduleNamed: cleanedName,'.py'.
				ext ifNotNil: [ 
					ext addDependentModules: (Array with: m).
					m addImportedFile: ext.
					ext addImportedInFile: m ] ] ]. 
		 ]
]

{ #category : #'resolving dependencies' }
PyProcessor >> resolveDependenciesForClassInheritance [
	| d |
	d := Dictionary new.
	self classes do: [ :c | d at: c name put: c ].
	self classes
		do: [ :c | 
			(d includesKey: c superclassName)
				ifTrue: [ c superclass: (d at: c superclassName) ] ]
]
