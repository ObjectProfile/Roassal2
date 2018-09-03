Class {
	#name : #RTVisualizeCPPApplicationScript,
	#superclass : #RTUsefulScript,
	#category : #'Roassal2-Plugins-CProjectVisualizer-Scripts'
}

{ #category : #accessing }
RTVisualizeCPPApplicationScript >> description [
	^ 
'Let you select a directory containing a C or C++ application and visualize it.
'
]

{ #category : #hooks }
RTVisualizeCPPApplicationScript >> execute [
	| s source |
	s := (self class >> #sourceCodeScript) sourceCode.
	source := String cr join: s lines allButFirst.
	GTPlayground openContents: source
]

{ #category : #hooks }
RTVisualizeCPPApplicationScript >> label [
	^ 'Visualize C/C++ application [ modules ]'
]

{ #category : #script }
RTVisualizeCPPApplicationScript >> sourceCodeScript [
	"The following code shows dependencies between "
	| root p b |
	root := '/Users/alexandrebergel/Desktop/SUCHAI'.
	p := CPPProcessor new.
	p processRootFolder: root asFileReference.
	p resolveDependencies.
	
	b := RTMondrian new.
	b shape circle 
		color: Color gray;
		if: [ :f | '*RTOS*' match: f filename ] color: Color red.
	b interaction highlightNeighbour:  #dependentModules color: Color orange .
"	b shape box size: #loc."
	b nodes: p modules.
	
	
	b shape line 
		color: (Color blue alpha: 0.2);
		width: 2.
	b edges 
		moveBehind;
		connectToAll: #dependentModules.
	b layout grid.
	"b layout forceWithCharge: -300."
	
	b normalizer normalizeSize: #loc.
	b
]
