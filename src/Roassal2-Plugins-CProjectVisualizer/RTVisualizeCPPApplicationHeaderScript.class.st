Class {
	#name : #RTVisualizeCPPApplicationHeaderScript,
	#superclass : #RTUsefulScript,
	#category : #'Roassal2-Plugins-CProjectVisualizer-Scripts'
}

{ #category : #accessing }
RTVisualizeCPPApplicationHeaderScript >> description [
	^ 
'Let you select a directory containing a C or C++ application and visualize it.
'
]

{ #category : #hooks }
RTVisualizeCPPApplicationHeaderScript >> execute [
	| s source |
	s := (self class >> #sourceCodeScript) sourceCode.
	source := String cr join: s lines allButFirst.
	GTPlayground openContents: source
]

{ #category : #hooks }
RTVisualizeCPPApplicationHeaderScript >> label [
	^ 'Visualize C/C++ application [ headers ]'
]

{ #category : #script }
RTVisualizeCPPApplicationHeaderScript >> sourceCodeScript [
	"The following code shows dependencies between "
	| root p b |
	root := '/Users/alexandrebergel/Desktop/SUCHAI'.
	"root := '/Users/alexandrebergel/Desktop/NUbots'."
	p := CPPProcessor new.
	p processRootFolder: root asFileReference.
	p resolveDependencies.
	
	b := RTMondrian new.
	b shape circle 
		color: Color gray;
		if: [ :f | '*RTOS*' match: f filename ] color: Color red.
	b interaction highlightNeighbour: #outgoingHeaders color: Color orange .
"	b shape box size: #loc."
	b nodes: p headers.
	
	b shape line 
		color: (Color blue alpha: 0.2);
		width: 2.
	b edges 
		moveBehind;
		connectToAll: #outgoingHeaders.
	b layout grid.
	
	b normalizer normalizeSize: #loc.
	b
]
