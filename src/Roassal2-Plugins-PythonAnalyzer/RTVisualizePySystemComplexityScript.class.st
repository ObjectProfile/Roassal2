Class {
	#name : #RTVisualizePySystemComplexityScript,
	#superclass : #RTUsefulScript,
	#category : #'Roassal2-Plugins-PythonAnalyzer-Scripts'
}

{ #category : #accessing }
RTVisualizePySystemComplexityScript >> description [
	^ 'Let you select a directory containing a Python application and visualize class hierarchies'
]

{ #category : #accessing }
RTVisualizePySystemComplexityScript >> execute [
	| s source |
	s := (self class >> #sourceCodeScript ) sourceCode.
	source := String cr join: s lines allButFirst.
	GTPlayground openContents: source.
]

{ #category : #accessing }
RTVisualizePySystemComplexityScript >> label [
	^ 'Visualize Python System Complexity'
]

{ #category : #accessing }
RTVisualizePySystemComplexityScript >> sourceCodeScript [
| root p b |
root := UIManager default chooseDirectory: 'Open your Python directory'.
root ifNil: [ ^ self ].
"
root := '/Users/alexandrebergel/Desktop/astropy' asFileReference.
"
p := PyProcessor new.
p processRootFolder: root.
p resolveDependencies.

b := RTMondrian new.
b shape circle.
b shape box 
	height: #numberOfLinesOfCode;
	width: [ :c | c numberOfMethods * 10 ].
b nodes: p classes.
b edges connectFrom: #superclass.
b layout tree;
	ifNotConnectedThen: RTFlowLayout new.
b normalizer
	distinctColorUsing: #file.
^ b
]
