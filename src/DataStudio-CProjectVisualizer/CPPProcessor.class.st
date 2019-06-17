"
I process a root directory and build CPPModules, CPPHeaders and directories to visualize them

Here is an example:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    root := '/Users/alexandrebergel/Desktop/SUCHAI-Flight-Software'.
    p := CPPProcessor new.
    p processRootFolder: root asFileReference.
    p resolveDependencies.
    
    b := RTMondrian new.
    b shape circle 
        color: Color gray;
        if: [ :f | '*RTOS*' match: f filename ] color: Color red.
    b interaction highlightNeighbors:  #dependentModules color: Color orange .
    b nodes: p modules.
    
    b shape line 
        color: (Color blue alpha: 0.2);
        width: 2.
    b edges 
        moveBehind;
        connectToAll: #dependentModules.
    b layout grid.
    b layout forceWithCharge: -300.
    
    b normalizer normalizeSize: #loc.
    b
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
"
Class {
	#name : #CPPProcessor,
	#superclass : #RTObject,
	#instVars : [
		'headers',
		'modules',
		'directories'
	],
	#category : #'DataStudio-CProjectVisualizer-Core'
}

{ #category : #testing }
CPPProcessor >> containsModulesHavingSameName [
	"Return true or false on whether the processor contains more than one module having the same name"
	^ modules values anySatisfy: [ :coll | coll size > 1 ]
]

{ #category : #visualizations }
CPPProcessor >> gtViewArtworkOnHMOn: composite [
	<gtInspectorPresentationOrder: -15>
	composite roassal2
		title: 'Headers & Modules';
		initializeView: [ | a action |
			a := CAArtwork new.
			action := CAAddElementAction new.
			action argument: self headers, self modules.
			a doAction: action.
			a view ]
]

{ #category : #visualizations }
CPPProcessor >> gtViewArtworkOnHeadersOn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'Headers';
		initializeView: [ | a action |
			a := CAArtwork new.
			action := CAAddElementAction new.
			action argument: self headers.
			a doAction: action.
			a view ]
]

{ #category : #visualizations }
CPPProcessor >> gtViewArtworkOnModulesOn: composite [
	<gtInspectorPresentationOrder: -7>
	composite roassal2
		title: 'Modules';
		initializeView: [ | a action |
			a := CAArtwork new.
			action := CAAddElementAction new.
			action argument: self modules.
			a doAction: action.
			a view ]
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
CPPProcessor >> moduleNamed: aFilename [
	"If the model contains at least one module named afileName, then it returns it. 
	If the model contains more than one modules, then it returns the collection of modules.
	If the model does not contains any module named afileName, then it returns nil"
	| result |
	result := modules at: aFilename ifAbsent: [ ^ nil ].
	result size = 1 ifTrue: [ ^ result first ].
	^ result
]

{ #category : #accessing }
CPPProcessor >> modules [
	"Return the collections contained in the model"
	^ modules values flatCollect: #yourself
]

{ #category : #processing }
CPPProcessor >> modulesNamed: aFilename [
	"Return the modules having a particular names. 
	If none, return an empty collection"
	| result |
	result := modules at: aFilename ifAbsent: [ ^ #() ].
	^ result
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
	^ (modules flatCollect: #value) size
]

{ #category : #metrics }
CPPProcessor >> numberOfModulesNamed: aModulenameBasename [
	"Return the number of modules named aModulenameBasename"
	^ (modules at: aModulenameBasename) size
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
]

{ #category : #processing }
CPPProcessor >> processModuleAsString: fileContentAsString named: filename [
	| m |
	m := CPPModule new.
	m filename: filename.
	m initializeFromContentAsString: fileContentAsString.
	
	(modules includesKey: m baseFilename) 
		ifFalse: [ modules at: m baseFilename put: OrderedCollection new ].
	(modules at: m baseFilename) add: m

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
"			r ascii.
			r converter: Latin1TextConverter new."
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
	| someModules |
	"We link header to modules, and modules to header"
	self headers
		do: [ :h | 
			"We first look for a module whose name ends with .c"
			someModules := self modulesNamed: h baseFilenameWithoutExtension , '.c'.
			"If not found, we look for a module ending with .cpp"
			someModules ifEmpty: [ someModules := self modulesNamed: h baseFilenameWithoutExtension , '.cpp' ].
			"Else, ending with .cc"
			someModules ifEmpty: [ someModules := self modulesNamed: h baseFilenameWithoutExtension , '.cc' ].
			someModules
				ifNotEmpty: [ someModules
						do: [ :aModule | 
							aModule header: h.
							h module: aModule ] ] ]
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
		"We first use the module header to extract the dependencies between the modules"
		m hasHeader ifTrue: [ 
			| oh |
			oh := m header outgoingHeaders, m outgoingHeaders. 
			oh := oh select: #hasModule thenCollect: #module.
			m addDependentModules: oh ].
		
		"We then use any imported header"
		"This happens if main.c includes foo.h, and foo.c includes foo.h"
		m outgoingHeaders do: [ :oh |
			m addDependentModules: oh modules
		]
	].

]

{ #category : #'resolving dependencies' }
CPPProcessor >> resolveDependenciesBetweenModulesAndHeaders [
	self modules do: [ :m |
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
