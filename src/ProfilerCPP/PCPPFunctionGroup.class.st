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
	|anim elements listeners  elementsToNormalize callNodes min max |

	anim := RTNopAnimation new
				waitFor: 0.01 after: [  
	
	elements := (aBuilder nodes collect: [ :n | n element ]) asGroup.
	callNodes := (aBuilder nodes select: [:n | n element model isKindOf: PCPPCall ]).
	elementsToNormalize := (callNodes collect: [ :n | n element ]) asGroup.
	listeners := (aBuilder lastAddedNodes flatCollect: [ :n | {n iconOpen. n iconClose} ]) asGroup.
	
	min := (callNodes collect: [:n | n element model totalExecutionTime ]) min.
	max := (callNodes collect: [:n | n element model totalExecutionTime ]) max.
	
	callNodes do: [:nod | 
		| totalExecTime |
		totalExecTime := (nod expandedNodes select: [:n | n element model isKindOf: PCPPCall ]) isEmpty ifTrue: [ 0 ] ifFalse: [ ((nod expandedNodes select: [:n | n element model isKindOf: PCPPCall ]) collect: [:n | n element model totalExecutionTime ]) sum ] . 
		totalExecTime := totalExecTime + (nod element model calledFunction totalExecutionTime).
		nod element model totalExecutionTime: totalExecTime.
		 ].
	
	
	aBuilder normalizer 
		elements: elementsToNormalize;
		normalizeColor: [:e | 
			(e totalExecutionTime = 0) ifTrue: [0] ifFalse: [e totalExecutionTime ln].	
			] using: { Color lightGreen. Color green. Color orange. Color red }.	
		
	aBuilder view canvas signalUpdate.
	listeners when: TRMouseClick do: [ :evt | self updateAndNormalize: aBuilder ].
	"temporary inspector because the gtInspector does not handle new elements in view"
	(aBuilder lastAddedNodes collect: [ :n | n element]) asGroup do: [:l | l when: TRMouseClick do: [ :evt | l model inspect ]].
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
	
	| lb lineShape|
	lineShape := RTArrowedLine new color: (Color r: 0.498 g: 0.737 b: 0.255 alpha: 1.0). 
	lineShape withShorterDistanceAttachPoint. 

	b shape shape: ((RTBox new size:40; color: Color yellow )+ (RTLabel new text: [:cls | (cls isKindOf: PCPPCall) ifTrue: [ cls calledFunction signature] ifFalse: [ cls name ]])).
	b layout: (RTHorizontalTreeLayout new horizontalGap: 80; verticalGap: 8).	
	b lineShape: (lineShape).  
	b onLeftClickExplore: [ :cls |
	|c| 
		(cls isKindOf: PCPPCall) ifTrue: [  
			c := cls otherFunctionCalls. 
			cls referenceAccesses do: [ :r | c add: r ].
			c asArray] ifFalse: [ 
			#()
			 ]
		];
		withPopup: [:cls | (cls isKindOf: PCPPCall) ifTrue: [ cls calledFunction] ifFalse: [ cls name ]];
		dragChildren;
		withIconsColor: (Color r: 0.498 g: 0.737 b: 0.255 alpha: 1.0);
		node: self last incomingCalls first.

	lb := RTLegendBuilder new.
	lb view: b view.
	lb addText: 'Call graph'.
	lb addText: 'box and edge = call'.
	lb addColor: Color lightGreen text: 'little time share'.
	lb addColor: Color red text: 'significant time share'.
	lb build.

	"TRConstraint move: (lb legendElement asGroup) onTheLeftOf: ((b nodes collect: [ :n | n element ]) asGroup)."
	
	self updateAndNormalize: b.
]
