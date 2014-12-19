Class {
	#name : #RTAbstractGrapherPlugin,
	#superclass : #RTObject,
	#instVars : [
		'builder',
		'shapeBuilder'
	],
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #accessing }
RTAbstractGrapherPlugin >> builder: aGraphBuilder [
	builder := aGraphBuilder
]

{ #category : #utility }
RTAbstractGrapherPlugin >> lineFrom: fromPoint to: toPoint [
	| e1 e2 l |
	e1 := (RTEllipse new size: 0) element.
	e2 := (RTEllipse new size: 0) element.
	e1 translateTo: fromPoint.
	e2 translateTo: toPoint.
	l := RTLine edgeFrom: e1 to: e2.
	builder view add: e1; add: e2; add: l
]

{ #category : #accessing }
RTAbstractGrapherPlugin >> shape [
	shapeBuilder ifNil: [ shapeBuilder := RTShapeBuilder new. shapeBuilder line ].
	^ shapeBuilder
]
