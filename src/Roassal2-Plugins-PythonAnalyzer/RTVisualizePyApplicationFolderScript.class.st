"
I am a simple script of the Python code analyzer
"
Class {
	#name : #RTVisualizePyApplicationFolderScript,
	#superclass : #RTUsefulScript,
	#category : #'Roassal2-Plugins-PythonAnalyzer-Core'
}

{ #category : #accessing }
RTVisualizePyApplicationFolderScript >> description [
	^ 'Let you select a directory containing a Python application and visualize it. Colors indicates modules and circles are files'
]

{ #category : #accessing }
RTVisualizePyApplicationFolderScript >> execute [
	| s source |
	s := (self class >> #sourceCodeScript ) sourceCode.
	source := String cr join: s lines allButFirst.
	GTPlayground openContents: source.
]

{ #category : #accessing }
RTVisualizePyApplicationFolderScript >> label [
	^ 'Visualize Python application'
]

{ #category : #accessing }
RTVisualizePyApplicationFolderScript >> sourceCodeScript [
"The following code shows dependencies between modules in python"
| root p b |
root := UIManager default chooseDirectory: 'Open your Python directory'.
"root := '/Users/alexandrebergel/Desktop/astropy' asFileReference."
root ifNil: [ ^ self ].
p := PyProcessor new.
p processRootFolder: root.
p resolveDependencies.

b := RTMondrian new.
b shape circle.

b interaction highlightNeighbour: #dependentModules color: Color purple.
b nodes: p modules.

b shape line
	color: (Color blue alpha: 0.2);
	width: 2.
b edges
	moveBehind;
	connectToAll: #dependentModules.
b layout force.
b normalizer 
	normalizeSize: #loc;
	distinctColorUsing: #parent;
	alphaColor: 0.9.
^ b
]
