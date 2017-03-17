Class {
	#name : #RTVisualizePyApplicationDependenciesScript,
	#superclass : #RTUsefulScript,
	#category : #'Roassal2-Plugins-PythonAnalyzer-Core'
}

{ #category : #accessing }
RTVisualizePyApplicationDependenciesScript >> description [
	^ 'Let you select a directory containing a Python application and visualize it. Colors indicates modules and circles are files'
]

{ #category : #accessing }
RTVisualizePyApplicationDependenciesScript >> execute [
	| s source |
	s := (self class >> #sourceCodeScript ) sourceCode.
	source := String cr join: s lines allButFirst.
	GTPlayground openContents: source.
]

{ #category : #accessing }
RTVisualizePyApplicationDependenciesScript >> label [
	^ 'Visualize Python application (nested files)'
]

{ #category : #accessing }
RTVisualizePyApplicationDependenciesScript >> sourceCodeScript [
"The following code shows dependencies between modules in python"
"The following code shows dependencies between modules in python"
| root p b allContainingFolders |
root := UIManager default chooseDirectory: 'Open your Python directory'.
"root := '/Users/alexandrebergel/Desktop/astropy' asFileReference."
root ifNil: [ ^ self ].
p := PyProcessor new.
p processRootFolder: root.
p resolveDependencies.

b := RTMondrian new.
b shape box.

allContainingFolders := p modules groupedBy: #parent.

b nodes: allContainingFolders keys forEach: [:k |
	b interaction highlightNeighbors: #dependentModules color: Color purple.
	b shape box 
		size: [ :f | f loc sqrt ].
	b nodes: (allContainingFolders at: k).
	b shape line
		color: (Color blue trans);
		width: 2.
	b edges
		objects: (allContainingFolders at: k);
		connectToAll: #dependentModules.
	b layout grid.
].

b layout flow.
^ b
]
