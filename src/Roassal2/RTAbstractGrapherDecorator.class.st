Class {
	#name : #RTAbstractGrapherDecorator,
	#superclass : #RTObject,
	#instVars : [
		'builder',
		'shapeBuilder',
		'placedInFront'
	],
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #utility }
RTAbstractGrapherDecorator >> boxFrom: fromPoint to: toPoint [
	| l ext |
	ext := fromPoint corner: toPoint.
	l := (RTBox new width: ext width abs; height: ext height abs; color: (Color blue alpha: 0.3)) element.
	l translateTo: ext center.
	builder view add: l.
	^ l
]

{ #category : #accessing }
RTAbstractGrapherDecorator >> builder: aGraphBuilder [
	builder := aGraphBuilder
]

{ #category : #accessing }
RTAbstractGrapherDecorator >> datasetValues [
	^ builder datasets flatCollect: #getValuesY
]

{ #category : #initialization }
RTAbstractGrapherDecorator >> initialize [
	super initialize.
	shapeBuilder := RTShapeBuilder new. 
	shapeBuilder line.
	placedInFront := true.
]

{ #category : #configuration }
RTAbstractGrapherDecorator >> isBehind [
	^ placedInFront = false
]

{ #category : #configuration }
RTAbstractGrapherDecorator >> isInFront [
	^ placedInFront = true
]

{ #category : #utility }
RTAbstractGrapherDecorator >> label: aString above: position [
	"Add a label in the view"
	| e |
	e := self label: aString on: position.
	e translateTo: position - (e extent / 2).
	^ e
]

{ #category : #utility }
RTAbstractGrapherDecorator >> label: aString on: position [
	"Add a label in the view"
	| e |
	e := RTLabel elementOn: aString.
	e translateTo: position.
	builder view add: e.
	^ e
]

{ #category : #utility }
RTAbstractGrapherDecorator >> lineFrom: fromPoint to: toPoint [
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
RTAbstractGrapherDecorator >> moveBehind [
	placedInFront := false
]

{ #category : #configuration }
RTAbstractGrapherDecorator >> moveInFront [
	placedInFront := true
]

{ #category : #accessing }
RTAbstractGrapherDecorator >> shape [
	^ shapeBuilder
]
