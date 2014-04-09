Class {
	#name : #RTGDEdgeB,
	#superclass : #RTGDElement,
	#instVars : [
		'conditionalShapes',
		'bundleConnectToElements',
		'edgesForLayout',
		'edgesUsedByLayout'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #public }
RTGDEdgeB >> bundleConnectTo: aBlock [
	^ self bundleConnectToElements: [ :anEl | 
		(aBlock rtValue: anEl model) collect: [ :o | graphBuilder view elementFromModel: o ] ]
]

{ #category : #public }
RTGDEdgeB >> bundleConnectToElements: aBlock [
	bundleConnectToElements add: aBlock
]

{ #category : #public }
RTGDEdgeB >> connectTo: toBlock [
	^ self if: true connectTo: toBlock
]

{ #category : #public }
RTGDEdgeB >> connectTo: toBlock color: aColor [
	^ self connectTo: toBlock shape: (RTLine new color: aColor)
	
]

{ #category : #public }
RTGDEdgeB >> connectTo: toBlock color: aColor usedInLayout: flagLayout [
	^ self connectTo: toBlock shape: (RTLine new color: aColor) usedInLayout: flagLayout
	
]

{ #category : #public }
RTGDEdgeB >> connectTo: toBlock shape: aShape [
	^ self if: true connectTo: toBlock shape: aShape
]

{ #category : #public }
RTGDEdgeB >> connectTo: toBlock shape: aShape usedInLayout: flagLayout [
	^ self if: true connectTo: toBlock shape: aShape usedInLayout: flagLayout
]

{ #category : #public }
RTGDEdgeB >> connectTo: toBlock usedInLayout: aFlag [
	^ self if: true connectTo: toBlock usedInLayout: aFlag
]

{ #category : #private }
RTGDEdgeB >> createEdgesFor: object [
	"Return the list of edges for the object. Note that the edges are not added in the view"
	
	"NOTE :: THIS METHOD NEEDS TO BE UPDATED. IT IS REALLY REALLY UGLY"
	| el v toElements res answer shape center |
	answer := OrderedCollection new.
	v := graphBuilder view.
	el := v elementFromModel: object.
	
	"Normal shapes"
	conditionalShapes do: [ :arr | 
		(arr first rtValue: object)
			ifTrue: [ 
				res := arr second rtValue: object.
				res isCollection ifFalse: [ res := Array with: res ].
				toElements := OrderedCollection new.
				res do: [ :o | 
					| t | 
					t := (v elementFromModel: o). 
					t ifNotNil: [ toElements add: t ] ].
				answer addAll: (toElements collect: [ :e | arr third edgeFrom: el to: e ]) ] ].


	"Edges taken into account for the layout"
	edgesForLayout do: [ :arr | 
		(arr first rtValue: object)
			ifTrue: [ 
				| edges |
				res := arr second rtValue: object.
				res isCollection ifFalse: [ res := Array with: res ].
				toElements := OrderedCollection new.
				res do: [ :o | 
					| t | 
					t := (v elementFromModel: o). 
					t ifNotNil: [ toElements add: t ] ].
				
				edges := toElements collect: [ :e | arr third edgeFrom: el to: e ].
				edgesUsedByLayout addAll: edges.
				answer addAll: edges ] ].


	"Bezier shapes"
	bundleConnectToElements do: [ :block |
		| intermediaryElement |
		toElements := (block rtValue: el) copyWithout: nil.
 
		shape := RTBezierLine new.
		center := (RTGroup withAll: toElements) center.
		intermediaryElement := (RTBox new color: Color red) element.
		intermediaryElement translateTo: center.
		
		"el view add: intermediaryElement."
		
		shape controllingElements: (Array with: intermediaryElement).
		answer addAll: (shape edgesFrom: el toAll: toElements). 
	].
	^ answer
]

{ #category : #accessing }
RTGDEdgeB >> edgesForLayout [
	^ edgesForLayout
]

{ #category : #accessing }
RTGDEdgeB >> edgesUsedByLayout [
	^ edgesUsedByLayout
]

{ #category : #public }
RTGDEdgeB >> if: condition bundleConnectTo: aBlock [
	^ self bundleConnectToElements: [ :anEl | 
		(condition rtValue: anEl model)
			ifTrue: [ (aBlock rtValue: anEl model) collect: [ :o | graphBuilder view elementFromModel: o ] ]
			ifFalse: [ #() ] ]
]

{ #category : #public }
RTGDEdgeB >> if: condition bundleConnectToElements: aBlock [
	bundleConnectToElements add: [ :anEl | 
		(condition rtValue: anEl model)
			ifTrue: [ (aBlock rtValue: anEl model) collect: [ :o | graphBuilder view elementFromModel: o ] ]
			ifFalse: [ #() ] ]
		
	
]

{ #category : #public }
RTGDEdgeB >> if: condition connectTo: toBlock [
	^ self if: condition connectTo: toBlock shape: RTLine new
]

{ #category : #public }
RTGDEdgeB >> if: condition connectTo: toBlock shape: aShape [
	conditionalShapes add: (Array with: condition with: toBlock with: aShape)
]

{ #category : #public }
RTGDEdgeB >> if: condition connectTo: toBlock shape: aShape usedInLayout: flagLayout [
	flagLayout 
		ifTrue: 
			[ edgesForLayout add: (Array with: condition with: toBlock with: aShape) ]
		ifFalse: 
			[ conditionalShapes add: (Array with: condition with: toBlock with: aShape) ]
]

{ #category : #public }
RTGDEdgeB >> if: condition connectTo: toBlock usedInLayout: aFlag [
	^ self if: condition connectTo: toBlock shape: RTLine new usedInLayout: aFlag
]

{ #category : #initialization }
RTGDEdgeB >> initialize [
	super initialize.
	conditionalShapes := OrderedCollection new.
	bundleConnectToElements := OrderedCollection new.
	edgesForLayout := OrderedCollection new.
	edgesUsedByLayout := OrderedCollection new.
]
