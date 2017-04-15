Class {
	#name : #CPPProcessor,
	#superclass : #RTObject,
	#instVars : [
		'headers',
		'modules',
		'directories'
	],
	#category : #'Roassal2-Plugins-CProjectVisualizer-Core'
}

{ #category : #visualizations }
CPPProcessor >> gtViewArtworkOn: composite [
	<gtInspectorPresentationOrder: -10>
	(Smalltalk hasClassNamed: #CAArtwork) ifTrue: [
		composite roassal2
			title: 'Artwork@Headers';
			initializeView: [
				| a action |
				a := (Smalltalk at: #CAArtwork) new.
				action := (Smalltalk at: #CAAddElementAction) new.
				action objects: self headers.
				a doAction: action.
				a view
				] 
		]
]

{ #category : #processing }
CPPProcessor >> headerNamed: afileName [
	| entry |
	entry := (afileName includes: $/)
		ifTrue: [ afileName copyFrom: (afileName lastIndexOf: $/) + 1 to: afileName size ]
		ifFalse: [ afileName ].
	^ headers at: entry ifAbsent: [ nil ]
	"^ headers detect: [ :h | h baseFilename = afileName ] ifNone: [ nil ]"
]

{ #category : #accessing }
CPPProcessor >> headers [
	^ headers values
]

{ #category : #initialization }
CPPProcessor >> initialize [
	super initialize.
	headers := Dictionary new.
	modules := Dictionary new.
	directories := OrderedCollection new
]

{ #category : #processing }
CPPProcessor >> moduleNamed: afileName [
	^ modules at: afileName ifAbsent: [ nil ]
	"^ modules detect: [ :m | m baseFilename = afileName ] ifNone: [ nil ]"
]

{ #category : #accessing }
CPPProcessor >> modules [
	^ modules values
]

{ #category : #metrics }
CPPProcessor >> numberOfDirectories [
	^ directories size
]

{ #category : #metrics }
CPPProcessor >> numberOfHeaders [
	^ headers size
]

{ #category : #metrics }
CPPProcessor >> numberOfModules [
	^ modules size
]

{ #category : #'resolving dependencies' }
CPPProcessor >> processDirectories: listOfDirectories [

	"TODO"
	"Hum... Not sure whether we will keep the folders..."
]

{ #category : #processing }
CPPProcessor >> processFileAsString: fileContentAsString named: filename [
	(((filename endsWith: '.c') or: [ filename endsWith: '.cpp' ]) or: [ filename endsWith: '.cc' ])
		ifTrue: [ ^ self processModuleAsString: fileContentAsString named: filename ].

	((filename endsWith: '.h') or: [ filename endsWith: '.hpp' ])
		ifTrue: [ ^ self processHeaderAsString: fileContentAsString named: filename ].
		
]

{ #category : #processing }
CPPProcessor >> processHeaderAsString: fileContentAsString named: filename [ 
	| h |
	h := CPPHeader new.
	h filename: filename.
	h initializeFromContentAsString: fileContentAsString.
	headers at: h baseFilename put: h
	"headers add: h"
]

{ #category : #processing }
CPPProcessor >> processModuleAsString: fileContentAsString named: filename [
	| m |
	m := CPPModule new.
	m filename: filename.
	m initializeFromContentAsString: fileContentAsString.
	modules at: m baseFilename put: m

]

{ #category : #processing }
CPPProcessor >> processRootFolder: aFileReference [

	| relevantFiles allFiles allDirectories |
	allFiles := aFileReference allChildren.
	allDirectories := allFiles select: #isDirectory.
	self processDirectories: allDirectories.
	relevantFiles := allFiles select: [ :f | #('c' 'h' 'cpp' 'hpp' 'C' 'H' 'CPP' 'HPP' 'cc') includes: f extension ].
	relevantFiles do: [ :f | 
			| r |
			r := f readStream.
			r ascii.
			r converter: Latin1TextConverter new.
			self processFileAsString: r contents named: f pathString ].
]

{ #category : #'resolving dependencies' }
CPPProcessor >> resolveDependencies [

	self resolveDependenciesBetweenHeaderAndModule.
	self resolveDependenciesBetweenHeaders.
	self resolveDependenciesBetweenModulesAndHeaders.
	self resolveDependenciesBetweenModules
]

{ #category : #'resolving dependencies' }
CPPProcessor >> resolveDependenciesBetweenHeaderAndModule [
	| m |
	"We link header to modules, and modules to header"
	self headers do: [ :h |
		"We first look for a module whose name ends with .c"
		m := self moduleNamed: h baseFilenameWithoutExtension, '.c'.
		"If not found, we look for a module ending with .cpp"
		m ifNil: [ m := self moduleNamed: h baseFilenameWithoutExtension, '.cpp' ].
		"Else, ending with .cc"
		m ifNil: [ m := self moduleNamed: h baseFilenameWithoutExtension, '.cc' ].
		
		m ifNotNil: [ 
			m header: h. 
			h module: m ]
	].
]

{ #category : #'resolving dependencies' }
CPPProcessor >> resolveDependenciesBetweenHeaders [
	self headers copy do: [ :h |
		h includedNames do: [ :name |
			| hh |
			hh := self headerNamed: name.
			hh ifNotNil: [ 
				hh addIncomingHeader: h. 
				h addOutgoingHeader: hh ] ]
	]
]

{ #category : #'resolving dependencies' }
CPPProcessor >> resolveDependenciesBetweenModules [
	self modules copy do: [ :m |
		"We first use the header to extract the dependencies between the modules"
		m hasHeader ifTrue: [ 
			| oh |
			oh := m header outgoingHeaders, m outgoingHeaders. 
			oh := oh select: #hasModule thenCollect: #module.
			m addDependentModules: oh. ].
	].

]

{ #category : #'resolving dependencies' }
CPPProcessor >> resolveDependenciesBetweenModulesAndHeaders [
	self modules copy do: [ :m |
		m includedNames do: [ :name | 
			| hh |
			hh := self headerNamed: name.
			hh ifNotNil: [ 
				m addOutgoingHeader: hh ] ]
	].

]

{ #category : #visualizations }
CPPProcessor >> viewHeaders [
	| b p |
	b := RTMondrian new.
	b shape circle 
		color: Color gray;
		if: [ :f | '*RTOS*' match: f filename ] color: Color red.
	b interaction highlightNeighbors: #outgoingHeaders color: Color orange .
"	b shape box size: #loc."
	b nodes: self headers.
	
	b shape line 
		color: (Color blue alpha: 0.2);
		width: 2.
	b edges 
		moveBehind;
		connectToAll: #outgoingHeaders.
	b layout grid.
	
	b normalizer normalizeSize: #loc.
	^ b
]
