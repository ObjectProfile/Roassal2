Class {
	#name : #RTKiviatNode,
	#superclass : #RTObject,
	#instVars : [
		'arrayValues',
		'shapeNode',
		'shapeEdge',
		'named',
		'nodeElements',
		'edgeElements'
	],
	#category : #'Roassal2-Builder-Kiviat'
}

{ #category : #'as yet unclassified' }
RTKiviatNode >> addEdgeElement: anElement [
	edgeElements add: anElement.
]

{ #category : #'as yet unclassified' }
RTKiviatNode >> addEdgeElements: anElementsCollection [
	anElementsCollection do: [ :e | edgeElements add: e].
]

{ #category : #'as yet unclassified' }
RTKiviatNode >> addNodeElement: anElement [
	nodeElements add: anElement.
]

{ #category : #'as yet unclassified' }
RTKiviatNode >> addNodeElements: anElementsCollection [
	anElementsCollection do: [ :e | nodeElements add: e].
]

{ #category : #'as yet unclassified' }
RTKiviatNode >> arrayValues [
	^ arrayValues.
]

{ #category : #'as yet unclassified' }
RTKiviatNode >> defaultArrayValues [
	arrayValues := Array new.
]

{ #category : #'as yet unclassified' }
RTKiviatNode >> defaultShapeEdge [
	shapeEdge := RTLine new.
]

{ #category : #'as yet unclassified' }
RTKiviatNode >> defaultShapeNode [
	shapeNode := RTEllipse new color: (Color blue alpha: 0.3); size: 10.
]

{ #category : #'as yet unclassified' }
RTKiviatNode >> edgeElements [
	^ edgeElements
]

{ #category : #'as yet unclassified' }
RTKiviatNode >> initialize [
	super initialize.
	self defaultArrayValues.
	self defaultShapeNode.
	self defaultShapeEdge.
	nodeElements := OrderedCollection new.
	edgeElements := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
RTKiviatNode >> named [
	^ named
]

{ #category : #'as yet unclassified' }
RTKiviatNode >> named: aString [
	named := aString
]

{ #category : #'as yet unclassified' }
RTKiviatNode >> nodeElements [
	^ nodeElements
]

{ #category : #'as yet unclassified' }
RTKiviatNode >> shapeEdge [
	^ shapeEdge.
]

{ #category : #'as yet unclassified' }
RTKiviatNode >> shapeEdge: aShape [
	shapeEdge := aShape.
]

{ #category : #'as yet unclassified' }
RTKiviatNode >> shapeNode [
	^ shapeNode.
]

{ #category : #'as yet unclassified' }
RTKiviatNode >> shapeNode: aShape [
	shapeNode := aShape.
]

{ #category : #'as yet unclassified' }
RTKiviatNode >> values: anArrayValue [
	arrayValues := anArrayValue.
]
