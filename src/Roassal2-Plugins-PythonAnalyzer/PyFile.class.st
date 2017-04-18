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
		'functions',
		'containsMain',
		'classes'
	],
	#category : #'Roassal2-Plugins-PythonAnalyzer-Core'
}

{ #category : #accessing }
PyFile >> addClass: aPyClass [
	classes add: aPyClass.
	aPyClass file: self.
]

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
PyFile >> classes [
	^ classes
]

{ #category : #visualizations }
PyFile >> classesAndMethods [
	| b |
	b := RTMondrian new.
	b shape box color: Color blue darker darker darker.
	b nodes: classes forEach: [ :c |
		b shape box size: [ :m | m numberOfLinesOfCode sqrt ].
		b nodes: c methods.
		b layout grid.
	].
	b shape orthoVerticalLine.
	b edges connectFrom: #superclass.
	b layout tree.
	^ b
]

{ #category : #testing }
PyFile >> containsMain [
	"Return true if the file contains a line such as 'if __name__ == '__main__':'"
	^ containsMain
]

{ #category : #accessing }
PyFile >> dependentModules [
	"Should be removed. Too obscure name."
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

{ #category : #visualizations }
PyFile >> gtViewClassesAndMethodskOn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'ClassesAndMethods';
		initializeView: [
			self classesAndMethods ]
]

{ #category : #accessing }
PyFile >> importedFilenames [
	^ importedFilenames asArray
]

{ #category : #accessing }
PyFile >> importedFiles [
	"Return the list of files that I import"
	^ importedFiles asArray
]

{ #category : #accessing }
PyFile >> importedInFiles [
	"Return the list of files that import me"
	^ importedInFiles asArray
]

{ #category : #initialization }
PyFile >> initialize [
	super initialize.
	importedFilenames := OrderedCollection new.
	importedFiles := OrderedCollection new.
	importedInFiles := OrderedCollection new.
	classes := OrderedCollection new.

	"Should be removed"
	dependentModules := OrderedCollection new.
	self filename: 'UNAMED'.
	self loc: -1.
	containsMain := false
	
]

{ #category : #initialization }
PyFile >> initializeCheckIfContainsMain: rawLines [
	"Check for 
	if __name__ == '__main__':
	"
	containsMain := rawLines anySatisfy: [ :l | l endsWith: '''__main__'':' ]
	
]

{ #category : #initialization }
PyFile >> initializeClassesAndMethodsFromLines: lines [
	| insideClassDefinition insideAMultilineComment |
	insideClassDefinition := false.
	insideAMultilineComment := false.
	
	lines withIndexDo: [ :l :index | 
"
self haltIf: [ l = '    def fibonacci(self, n):' ]						.

"		"We found a multiline comment"
		"We check if this multiline is not actually a single line"
		((l trimLeft beginsWith: '"""') and: [ (l select: [ :c | c = $" ]) size < 6 ])
			ifTrue: [  
				insideAMultilineComment := insideAMultilineComment not ].
		
		
		insideAMultilineComment ifFalse: [
			insideClassDefinition ifTrue: [ 
				"we mark the last line of the last class"
				(l size > 0 and: [ l first isLetter ])
						ifTrue: [ classes notEmpty ifTrue: [ classes last endLine: index - 1 ]. 
							self markEndOfMethodAtLine: index. insideClassDefinition := false ] ].

			"We find a class definition"
			(l beginsWith: 'class ') ifTrue: [ 
				| c s |
				self markEndOfMethodAtLine: index.
				s := l substrings: ' ():'.
				c := PyClass new.
				c name: s second.
				s size = 3 
					ifTrue: [ c superclassName: s third ]
					ifFalse: [ c superclassName: 'object' ].
				c startLine: index.
				c file: self.
				self addClass: c.
				insideClassDefinition := true
			].
			
			insideClassDefinition ifTrue: [ 
				"We find a method definition"
				(l beginsWith: '    def ') ifTrue: [ 
					| m |
					self markEndOfMethodAtLine: index.
					m := PyMethod new
								name: (l substrings: ' (') second;
								startLine: index;
								pythonClass: classes last.
					classes last addMethod: m
				].
			
				"We process the lines, to extract the callNames"
				(((l size > 0 and: [ l first isLetter not ]) and: [ classes notEmpty ]) and: [ (l beginsWith: '    def ') not ])
					ifTrue: [ classes last methods notEmpty ifTrue: [ classes last methods last processLine: l ] ].
			]
		] "Inside a comment"
	].

	"In case there is no marker to end the last function of the file"
	classes notEmpty
		ifTrue: [ classes last endLine ifNil: [ classes last endLine: lines size + 1 ] ].

	"We keep everything as array"
	classes := classes asArray

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
	self initializeFunctionsFromLines: rawLines.
	self initializeCheckIfContainsMain: rawLines.
	self initializeClassesAndMethodsFromLines: rawLines
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

{ #category : #initialization }
PyFile >> markEndOfClassAtLine: index [
	classes notEmpty
		ifTrue: [ classes last endLine: index - 1.
			self markEndOfMethodAtLine: index ]
]

{ #category : #initialization }
PyFile >> markEndOfMethodAtLine: index [
	"We set the last line of code the of previous method"
	classes ifEmpty: [ ^ self ].
	classes last methods notEmpty
		ifTrue: [ 
			| lastMethod |
			lastMethod := classes last methods last.
			lastMethod endLine isNil ifTrue: [  lastMethod endLine: index - 1 ] ]
]

{ #category : #accessing }
PyFile >> methods [
	^ self classes flatCollect: #methods
]

{ #category : #datastudio }
PyFile >> metrics [
	^ #(#numberOfClasses #numberOfFunctions #numberOfFunctionsAndMethods #numberOfLinesOfCode #numberOfMethods)
]

{ #category : #metrics }
PyFile >> numberOfClasses [
	^ classes size
]

{ #category : #metrics }
PyFile >> numberOfFunctions [
	^ self functions size
]

{ #category : #metrics }
PyFile >> numberOfFunctionsAndMethods [
	^ self numberOfFunctions + self numberOfMethods 
]

{ #category : #metrics }
PyFile >> numberOfLinesOfCode [
	^ self loc
]

{ #category : #metrics }
PyFile >> numberOfMethods [
	^ self methods size
]

{ #category : #datastudio }
PyFile >> structuralConnections [
	^ #(#importedFiles #importedInFiles)
]
