Class {
	#name : #RTVisualizeCPPApplicationModuleAndHeaderScript,
	#superclass : #RTUsefulScript,
	#category : #'Roassal2-Plugins-CProjectVisualizer-Scripts'
}

{ #category : #accessing }
RTVisualizeCPPApplicationModuleAndHeaderScript >> description [
	^ 
'Let you select a directory containing a C or C++ application and visualize it.
'
]

{ #category : #hooks }
RTVisualizeCPPApplicationModuleAndHeaderScript >> execute [
	| s source |
	s := (self class >> #sourceCodeScript) sourceCode.
	source := String cr join: s lines allButFirst.
	GTPlayground openContents: source
]

{ #category : #hooks }
RTVisualizeCPPApplicationModuleAndHeaderScript >> label [
	^ 'Visualize C/C++ application [ modules & headers ]'
]

{ #category : #script }
RTVisualizeCPPApplicationModuleAndHeaderScript >> sourceCodeScript [
	"The following code shows dependencies between "
	| root p b |
	root := '/Users/alexandrebergel/Desktop/SUCHAI'.
	"root := '/Users/alexandrebergel/Desktop/NUbots'."
	"root := '/Users/alexandrebergel/Desktop/SUCHAI-Flight-Software'."
	p := CPPProcessor new.
	p processRootFolder: root asFileReference.
	p resolveDependencies.
	
	b := RTMondrian new.
	b shape circle 
		color: Color gray;
		if: [ :f | f class == CPPHeader ] borderColor: Color red;
		if: [ :f | '*/repo*' match: f filename ] color: Color blue;
		if: [ :f | '*/cmd*' match: f filename ] color: Color yellow;
		if: [ :f | '*/task*' match: f filename ] color: Color orange.
	b interaction highlightNeighbour:  #outgoingHeaders color: Color orange .
"	b shape box size: #loc."
	b nodes: p modules, p headers.
	
	
	b shape arrowedLine
		headOffset: 0.3;
		withOffset; 
		color: (Color blue alpha: 0.2);
		width: 2.
	b edges 
		moveBehind;
		connectToAll: #outgoingHeaders.
	b layout grid.
	"b layout forceWithCharge: -300."
	
	b normalizer normalizeSize: #loc using: #sqrt.
	b
]
