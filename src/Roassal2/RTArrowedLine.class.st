"
A RTArrow is an arrowed line between its extremities

Instance Variables
	head:		<Object>
	line:		<Object>

head
	- xxxxx

line
	- xxxxx

"
Class {
	#name : #RTArrowedLine,
	#superclass : #RTAbstractLine,
	#instVars : [
		'line',
		'head'
	],
	#category : #'Roassal2-Core'
}

{ #category : #public }
RTArrowedLine class >> edgeFrom: el1 to: el2 [
	^ (RTEdge from: el1 to: el2) addShape: self new
]

{ #category : #accessing }
RTArrowedLine >> attachPoint: anAttachPoint [
	super attachPoint: anAttachPoint.
	head attachPoint: anAttachPoint.
	line attachPoint: anAttachPoint
]

{ #category : #accessing }
RTArrowedLine >> color: aColor [
	head color: aColor.
	line color: aColor
]

{ #category : #public }
RTArrowedLine >> directed [

	self line: RTDirectedLine new
]

{ #category : #public }
RTArrowedLine >> edgeFrom: el1 to: el2 [
	^ (RTEdge from: el1 to: el2) addShape: self
]

{ #category : #public }
RTArrowedLine >> empty [
	self head: RTEmptyArrowHead new
]

{ #category : #accessing }
RTArrowedLine >> head [
	^ head
]

{ #category : #accessing }
RTArrowedLine >> head: aLineDecorationShape [
	head := aLineDecorationShape
]

{ #category : #initialization }
RTArrowedLine >> initialize [
	super initialize.
	self simple; straight
]

{ #category : #accessing }
RTArrowedLine >> line [
	^ line
]

{ #category : #accessing }
RTArrowedLine >> line: aLineShape [
	line := aLineShape
]

{ #category : #public }
RTArrowedLine >> simple [
	self head: RTSimpleArrowHead new
]

{ #category : #accessing }
RTArrowedLine >> straight [
	self line: RTLine new
]

{ #category : #public }
RTArrowedLine >> trachelShapeFor: anEdge [
	| lineTrachelShape headTrachelShape |
	lineTrachelShape := line trachelShapeFor: anEdge.
	headTrachelShape := head trachelShapeFor: anEdge.
	^ TRCompositeShape new 
			addShape: lineTrachelShape; 
			addShape: headTrachelShape; 
			yourself
	
	
"	| lineTrachelShape headTrachelShape |
	lineTrachelShape := line trachelShapeFor: anEdge.
	headTrachelShape := head trachelShapeFor: anEdge.
	^ TRCompositeShape new shape1: lineTrachelShape; shape2: headTrachelShape"
]

{ #category : #hooks }
RTArrowedLine >> updateFor: edge trachelShape: trachelShape [
	line updateFor: edge trachelShape: edge trachelShape shapes first.
	head updateFor: edge trachelShape: edge trachelShape shapes second
]

{ #category : #public }
RTArrowedLine >> width: aValue [
	line width: aValue
]

{ #category : #public }
RTArrowedLine >> withOffsetIfMultiple [
	self attachPoint: RTShorterDistanceWithOffsetAttachPoint new.
]
