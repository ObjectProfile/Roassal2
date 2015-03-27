Class {
	#name : #PCPPFunctionGroup,
	#superclass : #MooseGroup,
	#category : #ProfilerCPP
}

{ #category : #finder }
PCPPFunctionGroup >> mooseCallGraphIn: composite [
	<moosePresentationOrder: 20>
	composite roassal2
			title: 'Callgraph';
			titleIcon: MooseIcons mooseSystemComplexity;
			initializeView: [ RTMondrian new ];
			painting: [ :view :each | 
				each mooseInterestingEntity viewCallgraphOn: view ]

]

{ #category : #metrics }
PCPPFunctionGroup >> numberOfExecutedFunctions [
	<MSEProperty: #numberOfExecutedFunctions type: #Number>
	<derived>
	<MSEComment: 'The number of functions'>
	
	^ (self select: #hasBeenExecuted) size
]

{ #category : #metrics }
PCPPFunctionGroup >> numberOfFunctions [
	<MSEProperty: #numberOfFunctions type: #Number>
	<derived>
	<MSEComment: 'The number of functions'>
	
	^ self size
]

{ #category : #visualizations }
PCPPFunctionGroup >> viewCallgraph [
	<menuItem: 'View callgraph' category: 'Visualize'> 
	
	| b |
	b := RTMondrian new.
	self viewCallgraphOn: b.
	b view inspect


]

{ #category : #visualizations }
PCPPFunctionGroup >> viewCallgraphOn: b [
	"b is an instance of RTMondrian"

	| lb |
	b shape rectangle withBorder.
	b nodes: (self).

	b normalizer 
		normalizeWidth: #numberOfOutgoingCalls;
		normalizeHeight: #numberOfIncomingCalls;
		normalizeColor: #totalExecutionTime using: { Color lightGreen . Color green . Color r: 0.0 g: 0.5 b: 0.0 }.

	b edges connectToAll: #outgoingOtherFunctions.
	b layout tree.
	b build.	

	lb := RTLegendBuilder new.
	lb view: b view.
	lb addText: 'Call graph'.
	lb addText: 'box = function, edge = call'.
	lb addText: 'width = number of outgoing calls'.
	lb addText: 'height = number of incoming calls'.
	lb addColor: Color lightGreen text: 'little time share'.
	lb addColor: Color lightGreen text: 'significant time share'.
	lb build.
]
