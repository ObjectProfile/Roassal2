Class {
	#name : #RTGraphBuilderTest,
	#superclass : #RTTest,
	#instVars : [
		'b'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #edges }
RTGraphBuilderTest >> expectedFailures [
	^ #(#testIfColor)
]

{ #category : #running }
RTGraphBuilderTest >> setUp [
	super setUp.
	b := RTGraphBuilder new
]

{ #category : #edges }
RTGraphBuilderTest >> testBundleConnect [

	| firstEdge |
	b nodes color: Color blue.
	b edges 
		if: [ :f :t | f = 1 ];
		bundleConnectTo: [ :v | Array with: 2 with: 3 ].
		
	b layout grid.
	b addAll: #(1 2 3).
	
	firstEdge := b view edges first .
	self assert: firstEdge from == b view elements first.
	self assert: firstEdge to == b view elements second.
]

{ #category : #'edges recur' }
RTGraphBuilderTest >> testChainedConnectTo [

	b nodes color: Color gray.
	b edges 
		connectTo: [ :v | v + 1]; 
		color: Color gray;
		useInLayout.	
	b edges 
		if: [ :f :t | f = 2 ];
		chainedConnectTo: [ :v | v + 1 ]; 
		follow: [ :v | v + 1 ];
		color: Color red;
		useInLayout.	
	b layout force.
	b addAll: (2 to: 20).

]

{ #category : #edges }
RTGraphBuilderTest >> testChainedConnection [
	b nodes color: Color gray.
	b edges chainedConnectTo: [ :v | v + 1 ].
	b addAll: #(1 2 3).
	self assert: b view numberOfEdges = 3.

]

{ #category : #edges }
RTGraphBuilderTest >> testConnectFrom [

	b nodes color: Color gray.
	b edges 
		connectFrom: [ :v | v - 1 ];
		connectTo: [ :v | v + 1].
	b addAll: #(1 2 3).
	
	self assert: b view numberOfEdges = 1.
	self assert: b view edges first from model = 1.
	self assert: b view edges first to model = 3.
]

{ #category : #tests }
RTGraphBuilderTest >> testDefaultNodeShape [

	b add: 10
]

{ #category : #tests }
RTGraphBuilderTest >> testEdge [

	b nodes color: Color blue.

	b edges
		if: [ :f :t | f = 1 ];
		connectTo: [ :o | o + 1 ];
		shape: (RTLine new color: Color blue).
	b addAll: (1 to: 2).
	
	self assert: b view numberOfElements = 2.
	self assert: b view numberOfEdges = 1.

]

{ #category : #tests }
RTGraphBuilderTest >> testGlobalNormalization [

	b := RTGraphBuilder new.
	b nodes shape: (RTEllipse new size: 30).

	b global
		normalizeColor: #yourself using: (Array with: Color green with: Color red).

	b addAll: (1 to: 20).
	b render.
	
	self assert: b view elements first trachelShape color = Color green.
	self assert: b view elements last trachelShape color red > 0.95.
]

{ #category : #edges }
RTGraphBuilderTest >> testIfAndEdges [

	b nodes color: Color blue.
	b edges 
		connectTo: [ :v | v + 1 ];
		if: [ :f :t | f = 1 ];
		color: Color black.
	b layout grid.
	b addAll: (1 to: 5).

	self assert: b view numberOfEdges = 1	
]

{ #category : #edges }
RTGraphBuilderTest >> testIfColor [

	b edge 
		connectTo: [ :v | v + 1 ];
		if: [:f :t | t = 2 ] color: Color red.
	b layout grid.
	b addAll: #(1 2 3).
	
	self assert: (b view elementFromModel: 2) incomingEdges first trachelShape color = Color red
]

{ #category : #labels }
RTGraphBuilderTest >> testLabellednode [
	b nodes 
		color: Color gray;
		if: [ :v | v odd ];
		labelled.

	b addAll: #(1 2).
	self assert: b view numberOfElements = 1.
	self assert: b view canvas numberOfShapes = 2.
	self assert: (b view canvas shapes collect: #class) = (Array with: TRLabelShape with: TREllipseShape)
]

{ #category : #tests }
RTGraphBuilderTest >> testMinSize [

	b nodes shape: (RTEllipse new size: 3).
	b global
		if: [ :v | v = 'world' ]; minSize: 15.
	b add: 'hello'.
	b add: 'world'.
	
	self assert: b view elements first trachelShape extent = (3 @ 3).
	self assert: b view elements second trachelShape extent = (15 @ 15).
]

{ #category : #nodes }
RTGraphBuilderTest >> testNode [

	| e4 e6 |
	b nodes
		if: [ :obj | obj < 5 ];
		shape: (RTBox new size: 10; color: Color blue).
	b nodes
		if: [ :obj | obj >= 5 ];
		shape: (RTEllipse new size: 10; color: Color red).
	b addAll: (1 to: 10).
	
	self assert: b view numberOfElements = 10.

	e4 := b view elementFromModel: 4.
	self assert: e4 shape class == RTBox.
	self assert: e4 trachelShape color = Color blue.
	
	e6 := b view elementFromModel: 6.
	self assert: e6 shape class == RTEllipse.
	self assert: e6 trachelShape color = Color red.
]

{ #category : #nodes }
RTGraphBuilderTest >> testNode2 [
	b nodes
		if: [ :obj | obj < 5 ];
		shape: (RTBox new size: 10; color: Color blue).
	b nodes
		if: [ :obj | obj >= 5 ];
		shape: (RTEllipse new size: 10; color: Color red).

	
	self assert: ((b getNodeFor: 4) shape color rtValue: RTElement new) = Color blue.
	self assert: ((b getNodeFor: 5) shape color rtValue: RTElement new) = Color red.
]

{ #category : #'edges recur' }
RTGraphBuilderTest >> testRecurFromUsing [

	| edge path result allObjects |
	edge := RTGDEdgeB new.
	path := OrderedCollection new.
	result := OrderedCollection new.
	allObjects := #(1 2 3).

	edge 
		recurFrom: 1
		using: [ :v | v + 1 ] 
		path: path 
		result: result 
		allObjects: allObjects.
	
	self assert: result asArray = #(3).
	self assert: path asArray = #(1 2 3).
]

{ #category : #'edges recur' }
RTGraphBuilderTest >> testRecurFromUsing2 [

	| edge path result allObjects |
	edge := RTGDEdgeB new.
	path := OrderedCollection new.
	result := OrderedCollection new.
	allObjects := #(1 2 3).

	edge 
		recurFrom: 1
		using: [ :v | { v + 1 . v + 2 } ] 
		path: path 
		result: result 
		allObjects: allObjects.
	
	self assert: result asArray = #(3).
	self assert: path asArray = #(1 2 3).
]

{ #category : #'edges recur' }
RTGraphBuilderTest >> testRecurFromUsing3 [

	| edge path result allObjects |
	edge := RTGDEdgeB new.
	path := OrderedCollection new.
	result := OrderedCollection new.
	allObjects := #(1 2 3).

	edge 
		recurFrom: 1
		using: [ :v | v = 3 ifTrue: [ 1 ] ifFalse: [ v + 1 ] ] 
		path: path 
		result: result 
		allObjects: allObjects.
	
	self assert: result asArray = #().
	self assert: path asArray = #(1 2 3).
]

{ #category : #'edges recur' }
RTGraphBuilderTest >> testRecurFromUsing4 [

	| edge path result allObjects |
	edge := RTGDEdgeB new.
	path := OrderedCollection new.
	result := OrderedCollection new.
	allObjects := (1 to: 20).

	edge 
		recurFrom: 2
		using: [ :v | v * v ] 
		path: path 
		result: result 
		allObjects: allObjects.
	
	self assert: result asArray = #(16).
	self assert: path asArray =  #(2 4 16).
]

{ #category : #'edges recur' }
RTGraphBuilderTest >> testRecurFromUsing5 [

	| edge |
	b nodes color: Color gray.
	edge := b edges.
	b addAll: (2 to: 20).

	self assert: (edge 
						recurFrom: 2
						using: [ :v | v * v ]) asArray = #(16).

]

{ #category : #nodes }
RTGraphBuilderTest >> testSimpleNodes [

	b nodes shape: RTEllipse new.
	b addAll: #(1 2 3).
	
	self assert: b view numberOfElements equals: 3.
]

{ #category : #nodes }
RTGraphBuilderTest >> testSimpleNodes02 [

	b nodes shape: RTEllipse new.
	b add: 5.
	
	self assert: b view numberOfElements equals: 1.
]

{ #category : #nodes }
RTGraphBuilderTest >> testSimpleNodes03 [

	b nodes shape: RTEllipse.
	b add: 5.
	
	self assert: b view numberOfElements equals: 1.
	self assert: b view elements first shape class equals: RTEllipse.
]

{ #category : #nodes }
RTGraphBuilderTest >> testSimpleNodes04If [

	b nodes 
		shape: RTEllipse;
		if: [ :v | v < 5 ].
	b nodes 
		shape: RTBox;
		if: [ :v | v > 5 ].
	b addAll: #(4 6).
	
	self assert: b view numberOfElements equals: 2.
	self assert: b view elements first shape class equals: RTEllipse.
	self assert: b view elements second shape class equals: RTBox.
]

{ #category : #tests }
RTGraphBuilderTest >> testSmallExample [

	| positions |
	b nodes shape: RTEllipse.
	b layout use: RTGridLayout new.
	b addAll: (1 to: 20).
	b applyLayout.
	
	positions  := ((Array new: 20) at: 1 put: ((2.5@2.5)); at: 2 put: ((12.5@2.5)); at: 3 put: ((22.5@2.5)); at: 4 put: ((32.5@2.5)); at: 5 put: ((42.5@2.5)); at: 6 put: ((2.5@12.5)); at: 7 put: ((12.5@12.5)); at: 8 put: ((22.5@12.5)); at: 9 put: ((32.5@12.5)); at: 10 put: ((42.5@12.5)); at: 11 put: ((2.5@22.5)); at: 12 put: ((12.5@22.5)); at: 13 put: ((22.5@22.5)); at: 14 put: ((32.5@22.5)); at: 15 put: ((42.5@22.5)); at: 16 put: ((2.5@32.5)); at: 17 put: ((12.5@32.5)); at: 18 put: ((22.5@32.5)); at: 19 put: ((32.5@32.5)); at: 20 put: ((42.5@32.5)); yourself).
	
	self assert: ((b view elements collect: #position) asArray = positions)
]

{ #category : #tests }
RTGraphBuilderTest >> testSmallExampleWithEdges [

	| positions |
	b nodes shape: RTEllipse new.
	b edges connectTo: [ :v | v + 1 ].
	b layout use: RTGridLayout new.
	b addAll: (1 to: 20).
	b applyLayout.
	
	positions := ((Array new: 19) at: 1 put: ((Array new: 2) at: 1 put: ((2.5@2.5)); at: 2 put: ((12.5@2.5)); yourself); at: 2 put: ((Array new: 2) at: 1 put: ((12.5@2.5)); at: 2 put: ((22.5@2.5)); yourself); at: 3 put: ((Array new: 2) at: 1 put: ((22.5@2.5)); at: 2 put: ((32.5@2.5)); yourself); at: 4 put: ((Array new: 2) at: 1 put: ((32.5@2.5)); at: 2 put: ((42.5@2.5)); yourself); at: 5 put: ((Array new: 2) at: 1 put: ((42.5@2.5)); at: 2 put: ((2.5@12.5)); yourself); at: 6 put: ((Array new: 2) at: 1 put: ((2.5@12.5)); at: 2 put: ((12.5@12.5)); yourself); at: 7 put: ((Array new: 2) at: 1 put: ((12.5@12.5)); at: 2 put: ((22.5@12.5)); yourself); at: 8 put: ((Array new: 2) at: 1 put: ((22.5@12.5)); at: 2 put: ((32.5@12.5)); yourself); at: 9 put: ((Array new: 2) at: 1 put: ((32.5@12.5)); at: 2 put: ((42.5@12.5)); yourself); at: 10 put: ((Array new: 2) at: 1 put: ((42.5@12.5)); at: 2 put: ((2.5@22.5)); yourself); at: 11 put: ((Array new: 2) at: 1 put: ((2.5@22.5)); at: 2 put: ((12.5@22.5)); yourself); at: 12 put: ((Array new: 2) at: 1 put: ((12.5@22.5)); at: 2 put: ((22.5@22.5)); yourself); at: 13 put: ((Array new: 2) at: 1 put: ((22.5@22.5)); at: 2 put: ((32.5@22.5)); yourself); at: 14 put: ((Array new: 2) at: 1 put: ((32.5@22.5)); at: 2 put: ((42.5@22.5)); yourself); at: 15 put: ((Array new: 2) at: 1 put: ((42.5@22.5)); at: 2 put: ((2.5@32.5)); yourself); at: 16 put: ((Array new: 2) at: 1 put: ((2.5@32.5)); at: 2 put: ((12.5@32.5)); yourself); at: 17 put: ((Array new: 2) at: 1 put: ((12.5@32.5)); at: 2 put: ((22.5@32.5)); yourself); at: 18 put: ((Array new: 2) at: 1 put: ((22.5@32.5)); at: 2 put: ((32.5@32.5)); yourself); at: 19 put: ((Array new: 2) at: 1 put: ((32.5@32.5)); at: 2 put: ((42.5@32.5)); yourself); yourself).
	 
	self assert: (b view edges collect: [ :e | Array with: e from position with: e to position ]) asArray = positions
]

{ #category : #tests }
RTGraphBuilderTest >> testSmallExampleWithEdgesAndLayout [

	| positions |
	b nodes shape: RTEllipse new.
	b edges 
		connectTo: [ :v | v + 1 ].
	b layout use: RTTreeLayout new.
	b addAll: (1 to: 20).
	b applyLayout.
	
	positions := ((Array new: 19) at: 1 put: ((Array new: 2) at: 1 put: ((7.5@7.5)); at: 2 put: ((15.5@7.5)); yourself); at: 2 put: ((Array new: 2) at: 1 put: ((15.5@7.5)); at: 2 put: ((23.5@7.5)); yourself); at: 3 put: ((Array new: 2) at: 1 put: ((23.5@7.5)); at: 2 put: ((31.5@7.5)); yourself); at: 4 put: ((Array new: 2) at: 1 put: ((31.5@7.5)); at: 2 put: ((39.5@7.5)); yourself); at: 5 put: ((Array new: 2) at: 1 put: ((39.5@7.5)); at: 2 put: ((47.5@7.5)); yourself); at: 6 put: ((Array new: 2) at: 1 put: ((47.5@7.5)); at: 2 put: ((55.5@7.5)); yourself); at: 7 put: ((Array new: 2) at: 1 put: ((55.5@7.5)); at: 2 put: ((63.5@7.5)); yourself); at: 8 put: ((Array new: 2) at: 1 put: ((63.5@7.5)); at: 2 put: ((71.5@7.5)); yourself); at: 9 put: ((Array new: 2) at: 1 put: ((71.5@7.5)); at: 2 put: ((79.5@7.5)); yourself); at: 10 put: ((Array new: 2) at: 1 put: ((79.5@7.5)); at: 2 put: ((87.5@7.5)); yourself); at: 11 put: ((Array new: 2) at: 1 put: ((87.5@7.5)); at: 2 put: ((95.5@7.5)); yourself); at: 12 put: ((Array new: 2) at: 1 put: ((95.5@7.5)); at: 2 put: ((103.5@7.5)); yourself); at: 13 put: ((Array new: 2) at: 1 put: ((103.5@7.5)); at: 2 put: ((111.5@7.5)); yourself); at: 14 put: ((Array new: 2) at: 1 put: ((111.5@7.5)); at: 2 put: ((119.5@7.5)); yourself); at: 15 put: ((Array new: 2) at: 1 put: ((119.5@7.5)); at: 2 put: ((127.5@7.5)); yourself); at: 16 put: ((Array new: 2) at: 1 put: ((127.5@7.5)); at: 2 put: ((135.5@7.5)); yourself); at: 17 put: ((Array new: 2) at: 1 put: ((135.5@7.5)); at: 2 put: ((143.5@7.5)); yourself); at: 18 put: ((Array new: 2) at: 1 put: ((143.5@7.5)); at: 2 put: ((151.5@7.5)); yourself); at: 19 put: ((Array new: 2) at: 1 put: ((151.5@7.5)); at: 2 put: ((159.5@7.5)); yourself); yourself).
	 
	self assert: (b view edges collect: [ :e | Array with: e from position with: e to position ]) asArray = positions
]

{ #category : #tests }
RTGraphBuilderTest >> testSmallExampleWithEdgesAndLayout2 [

	| positions |
	b nodes shape: RTEllipse new.
	b edges connectTo: [ :v | v + 1 ]; useInLayout.
	b layout use: RTTreeLayout new.
	b addAll: (1 to: 20).
	b applyLayout.
	
	positions := ((Array new: 19) at: 1 put: ((Array new: 2) at: 1 put: ((7.5@7.5)); at: 2 put: ((7.5@32.5)); yourself); at: 2 put: ((Array new: 2) at: 1 put: ((7.5@32.5)); at: 2 put: ((7.5@57.5)); yourself); at: 3 put: ((Array new: 2) at: 1 put: ((7.5@57.5)); at: 2 put: ((7.5@82.5)); yourself); at: 4 put: ((Array new: 2) at: 1 put: ((7.5@82.5)); at: 2 put: ((7.5@107.5)); yourself); at: 5 put: ((Array new: 2) at: 1 put: ((7.5@107.5)); at: 2 put: ((7.5@132.5)); yourself); at: 6 put: ((Array new: 2) at: 1 put: ((7.5@132.5)); at: 2 put: ((7.5@157.5)); yourself); at: 7 put: ((Array new: 2) at: 1 put: ((7.5@157.5)); at: 2 put: ((7.5@182.5)); yourself); at: 8 put: ((Array new: 2) at: 1 put: ((7.5@182.5)); at: 2 put: ((7.5@207.5)); yourself); at: 9 put: ((Array new: 2) at: 1 put: ((7.5@207.5)); at: 2 put: ((7.5@232.5)); yourself); at: 10 put: ((Array new: 2) at: 1 put: ((7.5@232.5)); at: 2 put: ((7.5@257.5)); yourself); at: 11 put: ((Array new: 2) at: 1 put: ((7.5@257.5)); at: 2 put: ((7.5@282.5)); yourself); at: 12 put: ((Array new: 2) at: 1 put: ((7.5@282.5)); at: 2 put: ((7.5@307.5)); yourself); at: 13 put: ((Array new: 2) at: 1 put: ((7.5@307.5)); at: 2 put: ((7.5@332.5)); yourself); at: 14 put: ((Array new: 2) at: 1 put: ((7.5@332.5)); at: 2 put: ((7.5@357.5)); yourself); at: 15 put: ((Array new: 2) at: 1 put: ((7.5@357.5)); at: 2 put: ((7.5@382.5)); yourself); at: 16 put: ((Array new: 2) at: 1 put: ((7.5@382.5)); at: 2 put: ((7.5@407.5)); yourself); at: 17 put: ((Array new: 2) at: 1 put: ((7.5@407.5)); at: 2 put: ((7.5@432.5)); yourself); at: 18 put: ((Array new: 2) at: 1 put: ((7.5@432.5)); at: 2 put: ((7.5@457.5)); yourself); at: 19 put: ((Array new: 2) at: 1 put: ((7.5@457.5)); at: 2 put: ((7.5@482.5)); yourself); yourself).
	 
	self assert: (b view edges collect: [ :e | Array with: e from position with: e to position ]) asArray = positions
]
