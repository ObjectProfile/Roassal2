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
	"| shape |
	shape := (conditionalShapes detect: [ :arr | arr first rtValue: object ]) second.
	^ shape elementOn: object
	"
	| el v toElements res |
	v := graphBuilder view.
	el := v elementFromModel: object.
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
				^ toElements collect: [ :e | arr third edgeFrom: el to: e ] ] ].
				
	^ nil
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
