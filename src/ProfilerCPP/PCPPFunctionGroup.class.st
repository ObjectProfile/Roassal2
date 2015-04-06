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
			initializeView: [ RTExploraBuilder new ];
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
PCPPFunctionGroup >> updateAndNormalize: aBuilder [
"Adding an animation to the view to execute the normalization on the actual elements of the explora builder, after it created the elements"
	|anim elements listeners|
		
	anim := RTNopAnimation new
				waitFor: 0.01 after: [  
	
	elements := (aBuilder nodes collect: [ :n | n element ]) asGroup.
	listeners := (aBuilder nodes flatCollect: [ :n | {n iconOpen. n iconClose} ]) asGroup.
	
	aBuilder normalizer 
		elements: elements;
		normalizeWidth: #numberOfOutgoingCalls min: 20 max: 100;
		normalizeHeight: #numberOfIncomingCalls min: 20 max: 100;
		normalizeColor: #totalExecutionTime using: { Color lightGreen. Color green. Color red }.	
		
	(aBuilder layout rtValue: self)
			on: elements.
		aBuilder view canvas signalUpdate.
		listeners when: TRMouseClick do: [ :evt | self updateAndNormalize: aBuilder ]
	].
	
	aBuilder view addAnimation: anim.
	
	
]

{ #category : #visualizations }
PCPPFunctionGroup >> viewCallgraph [
	<menuItem: 'View callgraph' category: 'Visualize'> 
	
	| b |
	
	"Method DEPRECATED ?"
	self halt.
	
	b := RTMondrian new.
	self viewCallgraphOn: b.
	b view inspect


]

{ #category : #visualizations }
PCPPFunctionGroup >> viewCallgraphOn: b [
	"Building the view with b, an instance of RTExploraBuilder"

	| lb |

	b shape rectangle withBorder.
	b layout: RTHorizontalTreeLayout new.	
	b lineShape: (RTArrowedLine new color: Color green). 
	b onClickExplore: [ :cls | cls outgoingOtherFunctions.];
		withPopup;
		dragChildren;
		withIcons;
		node: self last.
	


	lb := RTLegendBuilder new.
	lb view: b view.
	lb addText: 'Call graph'.
	lb addText: 'box = function, edge = call'.
	lb addText: 'width = number of outgoing calls'.
	lb addText: 'height = number of incoming calls'.
	lb addColor: Color lightGreen text: 'little time share'.
	lb addColor: Color red text: 'significant time share'.
	lb build.

	TRConstraint move: (lb legendElement asGroup) onTheLeftOf: ((b nodes collect: [ :n | n element ]) asGroup).
	
	self updateAndNormalize: b.
]
