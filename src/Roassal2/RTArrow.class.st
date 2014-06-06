Class {
	#name : #RTArrow,
	#superclass : #RTShape,
	#instVars : [
		'line',
		'head'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTArrow >> attachPoint: anAttachPoint [
	head attachPoint: anAttachPoint.
	line attachPoint: anAttachPoint
]

{ #category : #'as yet unclassified' }
RTArrow >> color: aColor [
	head color: aColor.
	line color: aColor
]

{ #category : #'as yet unclassified' }
RTArrow >> directed [

	self line: RTDirectedLine new
]

{ #category : #'as yet unclassified' }
RTArrow >> empty [
	self head: RTEmptyArrowHead new
]

{ #category : #'as yet unclassified' }
RTArrow >> head: aLineDecorationShape [
	head := aLineDecorationShape
]

{ #category : #'as yet unclassified' }
RTArrow >> initialize [
	super initialize.
	self simple; straight
]

{ #category : #'as yet unclassified' }
RTArrow >> line: aLineShape [
	line := aLineShape
]

{ #category : #'as yet unclassified' }
RTArrow >> simple [
	self head: RTSimpleArrowHead new
]

{ #category : #'as yet unclassified' }
RTArrow >> straight [
	self line: RTLine new
]

{ #category : #'as yet unclassified' }
RTArrow >> trachelShapeFor: anEdge [
	| lineTrachelShape headTrachelShape |
	lineTrachelShape := line trachelShapeFor: anEdge.
	headTrachelShape := head trachelShapeFor: anEdge.
	^ TRCompositeShape new shape1: lineTrachelShape; shape2: headTrachelShape
]

{ #category : #'as yet unclassified' }
RTArrow >> updateFor: edge trachelShape: trachelShape [
	line updateFor: edge trachelShape: edge trachelShape shape1.
	head updateFor: edge trachelShape: edge trachelShape shape2
]
