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
	#name : #RTArrowwedLine,
	#superclass : #RTAbstractLine,
	#instVars : [
		'line',
		'head'
	],
	#category : #'Roassal2-Core'
}

{ #category : #public }
RTArrowwedLine class >> edgeFrom: el1 to: el2 [
	^ (RTEdge from: el1 to: el2) addShape: self new
]

{ #category : #accessing }
RTArrowwedLine >> attachPoint: anAttachPoint [
	head attachPoint: anAttachPoint.
	line attachPoint: anAttachPoint
]

{ #category : #accessing }
RTArrowwedLine >> color: aColor [
	head color: aColor.
	line color: aColor
]

{ #category : #public }
RTArrowwedLine >> directed [

	self line: RTDirectedLine new
]

{ #category : #public }
RTArrowwedLine >> edgeFrom: el1 to: el2 [
	^ (RTEdge from: el1 to: el2) addShape: self
]

{ #category : #public }
RTArrowwedLine >> empty [
	self head: RTEmptyArrowHead new
]

{ #category : #accessing }
RTArrowwedLine >> head [
	^ head
]

{ #category : #accessing }
RTArrowwedLine >> head: aLineDecorationShape [
	head := aLineDecorationShape
]

{ #category : #initialization }
RTArrowwedLine >> initialize [
	super initialize.
	self simple; straight
]

{ #category : #accessing }
RTArrowwedLine >> line [
	^ line
]

{ #category : #accessing }
RTArrowwedLine >> line: aLineShape [
	line := aLineShape
]

{ #category : #public }
RTArrowwedLine >> simple [
	self head: RTSimpleArrowHead new
]

{ #category : #accessing }
RTArrowwedLine >> straight [
	self line: RTLine new
]

{ #category : #public }
RTArrowwedLine >> trachelShapeFor: anEdge [
	| lineTrachelShape headTrachelShape |
	lineTrachelShape := line trachelShapeFor: anEdge.
	headTrachelShape := head trachelShapeFor: anEdge.
	^ TRMultiCompositeShape new 
			addShape: lineTrachelShape; 
			addShape: headTrachelShape; 
			yourself
	
	
"	| lineTrachelShape headTrachelShape |
	lineTrachelShape := line trachelShapeFor: anEdge.
	headTrachelShape := head trachelShapeFor: anEdge.
	^ TRCompositeShape new shape1: lineTrachelShape; shape2: headTrachelShape"
]

{ #category : #hooks }
RTArrowwedLine >> updateFor: edge trachelShape: trachelShape [
	line updateFor: edge trachelShape: edge trachelShape shapes first.
	head updateFor: edge trachelShape: edge trachelShape shapes second
]

{ #category : #public }
RTArrowwedLine >> withOffsetIfMultiple [
	| ap |
	ap := RTShorterDistanceWithOffsetAttachPoint new.
	line attachPoint: ap.
	head attachPoint: ap
]
