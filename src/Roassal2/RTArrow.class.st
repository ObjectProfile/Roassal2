Class {
	#name : #RTArrow,
	#superclass : #RTShape,
	#instVars : [
		'line',
		'head'
	],
	#category : #'Roassal2-Core'
}

{ #category : #accessing }
RTArrow >> attachPoint: anAttachPoint [
	head attachPoint: anAttachPoint.
	line attachPoint: anAttachPoint
]

{ #category : #accessing }
RTArrow >> color: aColor [
	head color: aColor.
	line color: aColor
]

{ #category : #public }
RTArrow >> directed [

	self line: RTDirectedLine new
]

{ #category : #public }
RTArrow >> empty [
	self head: RTEmptyArrowHead new
]

{ #category : #accessing }
RTArrow >> head [
	^ head
]

{ #category : #accessing }
RTArrow >> head: aLineDecorationShape [
	head := aLineDecorationShape
]

{ #category : #initialization }
RTArrow >> initialize [
	super initialize.
	self simple; straight
]

{ #category : #accessing }
RTArrow >> line [
	^ line
]

{ #category : #accessing }
RTArrow >> line: aLineShape [
	line := aLineShape
]

{ #category : #public }
RTArrow >> simple [
	self head: RTSimpleArrowHead new
]

{ #category : #accessing }
RTArrow >> straight [
	self line: RTLine new
]

{ #category : #public }
RTArrow >> trachelShapeFor: anEdge [
	| lineTrachelShape headTrachelShape |
	lineTrachelShape := line trachelShapeFor: anEdge.
	headTrachelShape := head trachelShapeFor: anEdge.
	^ TRCompositeShape new shape1: lineTrachelShape; shape2: headTrachelShape
]

{ #category : #hooks }
RTArrow >> updateFor: edge trachelShape: trachelShape [
	line updateFor: edge trachelShape: edge trachelShape shape1.
	head updateFor: edge trachelShape: edge trachelShape shape2
]
