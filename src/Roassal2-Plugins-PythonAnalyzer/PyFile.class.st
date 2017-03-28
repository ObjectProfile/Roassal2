"
I am a simple representation of a python file
"
Class {
	#name : #PyFile,
	#superclass : #PyAbstractFile,
	#instVars : [
		'importedFilenames',
		'loc',
		'importedFiles',
		'dependentModules',
		'importedInFiles',
		'functions'
	],
	#category : #'Roassal2-Plugins-PythonAnalyzer-Core'
}

{ #category : #accessing }
PyFile >> addDependentModules: someModules [
	self assert: [ someModules allSatisfy: [ :m | m class == self class ] ].
	dependentModules addAll: (someModules copyWithout: self).
	dependentModules removeDuplicates.
]

{ #category : #accessing }
PyFile >> addImportedFile: afile [
	self assert: [ afile class == self class ].
	importedFiles add: afile.
	importedFiles removeDuplicates.
]

{ #category : #accessing }
PyFile >> addImportedInFile: afile [
	self assert: [ afile class == self class ].
	importedInFiles add: afile.
	importedInFiles removeDuplicates.
]

{ #category : #accessing }
PyFile >> dependentModules [
	^ dependentModules
]

{ #category : #accessing }
PyFile >> functions [
	^ functions
]

{ #category : #initialization }
PyFile >> getRelevantLinesOf: rawLines [
	"return the lines that are not within a multi-line comments"
	| amIInAMultiLineComment lines |
	amIInAMultiLineComment := false.
	lines := OrderedCollection new.
	rawLines do: [ :l |
		| trimmed |
		trimmed := l trimBoth.
		"Check if the line begins with a comment"
		((trimmed beginsWith: '"""') or: [ (trimmed beginsWith: 'r"""') ])
			ifTrue: [ 
				"If this is the case, we need to check if there is a comment terminator in the _same_ line"
				((trimmed copyFrom: 4 to: trimmed size) endsWith: '"""') not 
					ifTrue: [ amIInAMultiLineComment := amIInAMultiLineComment not ] ].
		amIInAMultiLineComment 
			ifFalse: [ lines add: l ]
	].
	^ lines
]

{ #category : #accessing }
PyFile >> importedFilenames [
	^ importedFilenames asArray
]

{ #category : #accessing }
PyFile >> importedFiles [
	^ importedFiles asArray
]

{ #category : #accessing }
PyFile >> importedInFiles [
	^ importedInFiles asArray
]

{ #category : #initialization }
PyFile >> initialize [
	super initialize.
	importedFilenames := OrderedCollection new.
	importedFiles := OrderedCollection new.
	importedInFiles := OrderedCollection new.
	
	"Should be removed"
	dependentModules := OrderedCollection new.
	self filename: 'UNAMED'.
	self loc: -1.
	
]

{ #category : #initialization }
PyFile >> initializeFromContentAsString: string [
	| lines rawLines |
	"Relevant lines are lines that are not part of a multiline comment"
	"We manage the import"
	rawLines := string lines.
	lines := self getRelevantLinesOf: rawLines.
	loc := rawLines size.
	
	self initializeImportFromLines: lines.
	self initializeFunctionsFromLines: rawLines
]

{ #category : #initialization }
PyFile >> initializeFunctionsFromLines: lines [
	functions := OrderedCollection new.
	lines
		withIndexDo: [ :l :index | 
			"we mark the last line of the function"
			(l size > 0 and: [ l first isLetter ])
				ifTrue: [ functions notEmpty ifTrue: [ functions last endLine: index ] ].
			(l beginsWith: 'def ')
				ifTrue: [ | f |
					f := PyFunction new
						name: (l substrings: ' (') second;
						startLine: index;
						file: self.
					functions add: f ].
			
			"We process the lines, to extract the callNames"
			(l size > 0 and: [ l first isLetter not ])
				ifTrue: [ functions notEmpty ifTrue: [ functions last processLine: l ] ].
	 ].

	"In case there is no marker to end the last function of the file"
	functions notEmpty
		ifTrue: [ functions last endLine ifNil: [ functions last endLine: lines size + 1 ] ].

	"We keep everything as array"
	functions := functions asArray
]

{ #category : #initialization }
PyFile >> initializeImportFromLines: lines [
	| importFrom addModule importLines |
	importLines := lines select: [ :l | l beginsWith: 'import ' ].	"We manage the import"
	importFrom := lines select: [ :l | l beginsWith: 'from ' ].
	addModule := [ :st :flag | 
	| s |
	s := st splitOn: ','.
	s
		do: [ :spart | 
			| temp |
			temp := spart substrings first.
			(flag or: [ (importedFilenames includes: temp) not ])
				ifTrue: [ importedFilenames add: temp ] ] ].
	importLines
		do: [ :l | addModule value: (l copyFrom: 8 to: l size) value: true ].
	importFrom
		do: [ :l | 
			| index |
			index := l indexOfSubCollection: 'import' startingAt: 0.
			addModule value: (l copyFrom: 6 to: index) value: false ]
]

{ #category : #testing }
PyFile >> isImported [
	"Return true if I am imported in other file"
	^ self importedInFiles notEmpty
]

{ #category : #testing }
PyFile >> isTest [
	"Return true if I am a test, i.e., import the package unittest"
	^ importedFilenames includes: 'unittest'
]

{ #category : #accessing }
PyFile >> loc [
	"Return the number of lines of code of the file"
	^ loc
]

{ #category : #accessing }
PyFile >> loc: anInteger [
	"Set the number of lines of code of the file"
	loc := anInteger
]

{ #category : #metrics }
PyFile >> numberOfFunctions [
	^ self functions size
]

{ #category : #metrics }
PyFile >> numberOfLinesOfCode [
	^ self loc
]
