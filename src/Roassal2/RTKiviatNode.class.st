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

{ #category : #adding }
RTKiviatNode >> addEdgeElement: anElement [
	edgeElements add: anElement.
]

{ #category : #adding }
RTKiviatNode >> addEdgeElements: anElementsCollection [
	anElementsCollection do: [ :e | edgeElements add: e].
]

{ #category : #adding }
RTKiviatNode >> addNodeElement: anElement [
	nodeElements add: anElement.
]

{ #category : #adding }
RTKiviatNode >> addNodeElements: anElementsCollection [
	anElementsCollection do: [ :e | nodeElements add: e].
]

{ #category : #accessing }
RTKiviatNode >> arrayValues [
	^ arrayValues.
]

{ #category : #default }
RTKiviatNode >> defaultArrayValues [
	arrayValues := Array new.
]

{ #category : #default }
RTKiviatNode >> defaultShapeEdge [
	shapeEdge := RTLine new.
]

{ #category : #default }
RTKiviatNode >> defaultShapeNode [
	shapeNode := RTEllipse new color: (Color blue alpha: 0.3); size: 10.
]

{ #category : #accessing }
RTKiviatNode >> edgeElements [
	^ edgeElements
]

{ #category : #initialization }
RTKiviatNode >> initialize [
	super initialize.
	self defaultArrayValues.
	self defaultShapeNode.
	self defaultShapeEdge.
	nodeElements := OrderedCollection new.
	edgeElements := OrderedCollection new.
]

{ #category : #accessing }
RTKiviatNode >> named [
	^ named
]

{ #category : #accessing }
RTKiviatNode >> named: aString [
	named := aString
]

{ #category : #accessing }
RTKiviatNode >> nodeElements [
	^ nodeElements
]

{ #category : #accessing }
RTKiviatNode >> shapeEdge [
	^ shapeEdge.
]

{ #category : #accessing }
RTKiviatNode >> shapeEdge: aShape [
	shapeEdge := aShape.
]

{ #category : #accessing }
RTKiviatNode >> shapeNode [
	^ shapeNode.
]

{ #category : #accessing }
RTKiviatNode >> shapeNode: aShape [
	shapeNode := aShape.
]

{ #category : #accessing }
RTKiviatNode >> values: anArrayValue [
	arrayValues := anArrayValue.
]
