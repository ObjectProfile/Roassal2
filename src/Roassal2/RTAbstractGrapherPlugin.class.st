Class {
	#name : #RTAbstractGrapherPlugin,
	#superclass : #RTObject,
	#instVars : [
		'builder',
		'shapeBuilder',
		'placedInFront'
	],
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #utility }
RTAbstractGrapherPlugin >> boxFrom: fromPoint to: toPoint [
	| l ext |
	ext := fromPoint corner: toPoint.
	l := (RTBox new width: ext width abs; height: ext height abs; color: (Color blue alpha: 0.3)) element.
	l translateTo: ext center.
	builder view add: l.
	^ l
]

{ #category : #accessing }
RTAbstractGrapherPlugin >> builder: aGraphBuilder [
	builder := aGraphBuilder
]

{ #category : #accessing }
RTAbstractGrapherPlugin >> datasetValues [
	^ builder datasets flatCollect: #getValuesY
]

{ #category : #initialization }
RTAbstractGrapherPlugin >> initialize [
	super initialize.
	shapeBuilder := RTShapeBuilder new. 
	shapeBuilder line.
	placedInFront := true.
]

{ #category : #configuration }
RTAbstractGrapherPlugin >> isBehind [
	^ placedInFront = false
]

{ #category : #configuration }
RTAbstractGrapherPlugin >> isInFront [
	^ placedInFront = true
]

{ #category : #utility }
RTAbstractGrapherPlugin >> lineFrom: fromPoint to: toPoint [
	| e1 e2 l |
	e1 := (RTEllipse new size: 0) element.
	e2 := (RTEllipse new size: 0) element.
	e1 translateTo: fromPoint.
	e2 translateTo: toPoint.
	l := shapeBuilder edgeFrom: e1 to: e2.
	builder view add: e1; add: e2; add: l.
	^ l
]

{ #category : #configuration }
RTAbstractGrapherPlugin >> moveBehind [
	placedInFront := false
]

{ #category : #configuration }
RTAbstractGrapherPlugin >> moveInFront [
	placedInFront := true
]

{ #category : #accessing }
RTAbstractGrapherPlugin >> shape [
	^ shapeBuilder
]
