"
I am a simple script of the Python code analyzer
"
Class {
	#name : #RTVisualizePyApplicationScript,
	#superclass : #RTUsefulScript,
	#category : #'Roassal2-Plugins-PythonAnalyzer-Core'
}

{ #category : #accessing }
RTVisualizePyApplicationScript >> description [
	^ 'Let you select a directory containing a Python application and visualize it'
]

{ #category : #accessing }
RTVisualizePyApplicationScript >> execute [
	| s source |
	s := (self class >> #sourceCodeScript ) sourceCode.
	source := String cr join: s lines allButFirst.
	GTPlayground openContents: source.
]

{ #category : #accessing }
RTVisualizePyApplicationScript >> label [
	^ 'Visualize Python application'
]

{ #category : #accessing }
RTVisualizePyApplicationScript >> sourceCodeScript [
"The following code shows dependencies between modules in python"
| root p b |
root := UIManager default chooseDirectory: 'Open your Python directory'.
root ifNil: [ ^ self ].
p := PyProcessor new.
p processRootFolder: root.
p resolveDependencies.

b := RTMondrian new.
b shape circle
	color: Color gray.
	
b interaction highlightNeighbors: #dependentModules color: Color purple.
b nodes: p modules.

b shape line
	color: (Color blue alpha: 0.2);
	width: 2.
b edges
	moveBehind;
	connectToAll: #dependentModules.
b layout grid.
b normalizer normalizeSize: #loc.
^ b
]
