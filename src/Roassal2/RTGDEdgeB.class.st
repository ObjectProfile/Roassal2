Class {
	#name : #RTGDEdgeB,
	#superclass : #Object,
	#instVars : [
		'conditionalShapes',
		'graphBuilder',
		'bundleConnectToElements'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #'as yet unclassified' }
RTGDEdgeB >> bundleConnectTo: aBlock [
	^ self bundleConnectToElements: [ :anEl | 
		(aBlock rtValue: anEl model) collect: [ :o | graphBuilder view elementFromModel: o ] ]
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> bundleConnectToElements: aBlock [
	bundleConnectToElements add: aBlock
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> connectTo: toBlock [
	^ self if: true connectTo: toBlock
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> createEdgesFor: object [
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
RTGDEdgeB >> graphBuilder [
	^ graphBuilder
]

{ #category : #accessing }
RTGDEdgeB >> graphBuilder: aGraphBuilder [
	graphBuilder := aGraphBuilder
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> if: condition bundleConnectTo: aBlock [
	^ self bundleConnectToElements: [ :anEl | 
		(condition rtValue: anEl model)
			ifTrue: [ (aBlock rtValue: anEl model) collect: [ :o | graphBuilder view elementFromModel: o ] ]
			ifFalse: [ #() ] ]
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> if: condition bundleConnectToElements: aBlock [
	bundleConnectToElements add: [ :anEl | 
		(condition rtValue: anEl model)
			ifTrue: [ (aBlock rtValue: anEl model) collect: [ :o | graphBuilder view elementFromModel: o ] ]
			ifFalse: [ #() ] ]
		
	
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> if: condition connectTo: toBlock [
	^ self if: condition connectTo: toBlock shape: RTLine new
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> if: condition connectTo: toBlock shape: aShape [
	conditionalShapes add: (Array with: condition with: toBlock with: aShape)
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> initialize [
	super initialize.
	conditionalShapes := OrderedCollection new.
	bundleConnectToElements := OrderedCollection new
]
