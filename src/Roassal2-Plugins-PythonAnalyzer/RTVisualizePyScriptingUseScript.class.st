Class {
	#name : #RTVisualizePyScriptingUseScript,
	#superclass : #RTUsefulScript,
	#category : #'Roassal2-Plugins-PythonAnalyzer-Scripts'
}

{ #category : #accessing }
RTVisualizePyScriptingUseScript >> description [
	^ 'Let you visualize portion of code that is not within a function or a method'
]

{ #category : #accessing }
RTVisualizePyScriptingUseScript >> execute [
	| s source |
	s := (self class >> #sourceCodeScript ) sourceCode.
	source := String cr join: s lines allButFirst.
	GTPlayground openContents: source.
]

{ #category : #accessing }
RTVisualizePyScriptingUseScript >> label [
	^ 'Visualize Python application (LOC x NOM)'
]

{ #category : #accessing }
RTVisualizePyScriptingUseScript >> sourceCodeScript [
"The following code shows dependencies between modules in python"
| root p b g d |
root := UIManager default chooseDirectory: 'Open your Python directory'.
"
root := '/Users/alexandrebergel/Desktop/afw' asFileReference.
"
root ifNil: [ ^ self ].
p := PyProcessor new.
p processRootFolder: root.
p resolveDependencies.

g := RTGrapher new.
d := RTData new.
d dotShape color: Color blue trans.
d points: p modules.
d y: #loc.
d x: #numberOfFunctionsAndMethods.
d xLog; yLog.
g add: d.
g axisX title: 'number of functions and methods'.
g axisY title: 'number of lines of code'.
g
]
