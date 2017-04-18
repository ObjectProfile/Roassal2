"
I am a simple python processor code, to analyze code and resolve dependecies
"
Class {
	#name : #PyProcessor,
	#superclass : #PyObject,
	#instVars : [
		'filesAsDictionary',
		'directories'
	],
	#category : #'Roassal2-Plugins-PythonAnalyzer-Core'
}

{ #category : #accessing }
PyProcessor >> classes [
	"Return all the classes defined in the processor"
	^ self files values flatCollect: #classes
]

{ #category : #accessing }
PyProcessor >> directories [
	^ directories
]

{ #category : #visualizations }
PyProcessor >> fileHierarchy [
	| b directoriesElements |
	b := RTMondrian new.
	directoriesElements := b nodes: self directories forEach: [ :aFolder |
		b shape box size: [ :f | f loc sqrt ].
		b interaction highlightNeighbors: #importedFiles color: Color purple.
		b nodes: aFolder files.
		
		b shape line
			color: (Color blue trans);
			width: 2.
		b edges
			objects: aFolder files;
			connectToAll: #importedFiles.
		b layout flow.
	].
	b edges connectFrom: #parentFolder.
	b layout tree.
	b build.
	
	directoriesElements @ (RTLabeled new setAsHighlightable).
 	b view @ RTHighlightElementsInView new transparent.
	^ b view
]

{ #category : #accessing }
PyProcessor >> files [
	^ filesAsDictionary
]

{ #category : #accessing }
PyProcessor >> functions [
	^ self files values flatCollect: #functions
]

{ #category : #visualizations }
PyProcessor >> gtViewArtworkOn: composite [
	<gtInspectorPresentationOrder: -10>
	(Smalltalk hasClassNamed: #CAArtwork) ifTrue: [
		composite roassal2
			title: 'Artwork@Files';
			initializeView: [
				| a action |
				a := (Smalltalk at: #CAArtwork) new.
				action := (Smalltalk at: #CAAddElementAction) new.
				action objects: self files values.
				a doAction: action.
				a view
				] 
		]
]

{ #category : #visualizations }
PyProcessor >> gtViewFileHierarchyOn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'Hierarchy';
		initializeView: [
			self fileHierarchy ]
]

{ #category : #visualizations }
PyProcessor >> gtViewSystemComplexityOn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'SystemComplexity';
		initializeView: [
			self systemComplexity ]
]

{ #category : #initialization }
PyProcessor >> initialize [
	super initialize.
	filesAsDictionary := Dictionary new.
	directories := OrderedCollection new.
]

{ #category : #accessing }
PyProcessor >> methods [
	^ self files values flatCollect: #methods
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
	| t |
	"Create a PyFolder for each FileReference"
	directories := listOfDirectories collect: [ :fileReference | PyFolder new filename: fileReference fullName ].

	"We link the parent"	
	t := directories groupedBy: #filename.
	directories do: [ :f | (t includesKey: f parent) ifTrue: [ f parentFolder: (t at: f parent) anyOne ] ].

	"We link the folder to its contained PyFile"
	filesAsDictionary values do: [ :aPyFile | 
		| pf |
		(t includesKey: aPyFile parent) ifTrue: [ 
			pf := (t at: aPyFile parent) anyOne.
			aPyFile parentFolder: pf.
			pf addFile: aPyFile ] ].
	
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
	"This is the main public method"
	
	| relevantFiles allFiles allDirectories |
	self assert: [ aFileReference class == FileReference ] description: 'Please provide a file reference instead'.

	allFiles := aFileReference allChildren.
	relevantFiles := allFiles select: [ :f | #('py') includes: f extension ].
	relevantFiles do: [ :f |
		| r | 
		r := f readStream.
		r ascii.
		r converter: Latin1TextConverter new.
		self processFileAsString: r contents named: f pathString ].
	
	allDirectories := allFiles select: #isDirectory.
	self processDirectories: allDirectories.

]

{ #category : #'resolving dependencies' }
PyProcessor >> resolveDependencies [
	"Public method"
	self resolveDependenciesBetweenModules.
	self resolveDependenciesForClassInheritance.
	self resolveDependenciesBetweenMethodsAndFunctions
]

{ #category : #'resolving dependencies' }
PyProcessor >> resolveDependenciesBetweenMethodsAndFunctions [
	| allRelevantFunctions g |
	allRelevantFunctions := self functions, self methods.
	g := allRelevantFunctions groupedBy: #name.
	allRelevantFunctions do: [ :f |
		f callNames do: [ :name |
			g at: name ifPresent: [ :ll | 
				f addOutgoingMethods: ll. 
				ll do: [ :ff | ff addIncomingMethod: f ] ]
		]
	]
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

{ #category : #visualizations }
PyProcessor >> systemComplexity [
	| b |
	b := RTMondrian new.
	b shape circle.
	b shape box 
		height: #numberOfLinesOfCode;
		width: [ :c | c numberOfMethods * 10 ].
	b nodes: self classes.
	b edges connectFrom: #superclass.
	b layout tree;
		ifNotConnectedThen: RTFlowLayout new.
	b normalizer
		distinctColorUsing: #file.
	b view @ RTHighlightElementsInView new transparent.
	^ b
]
