Class {
	#name : #RTArrow,
	#superclass : #RTShape,
	#instVars : [
		'line',
		'head'
	],
	#category : #'Roassal2-Core'
}

{ #category : #public }
RTArrow class >> edgeFrom: el1 to: el2 [
	^ (RTEdge from: el1 to: el2) addShape: self new
]

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
RTArrow >> edgeFrom: el1 to: el2 [
	^ (RTEdge from: el1 to: el2) addShape: self
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
RTArrow >> updateFor: edge trachelShape: trachelShape [
	line updateFor: edge trachelShape: edge trachelShape shapes first.
	head updateFor: edge trachelShape: edge trachelShape shapes second
]

{ #category : #public }
RTArrow >> withOffsetIfMultiple [
	| ap |
	ap := RTShorterDistanceWithOffsetAttachPoint new.
	line attachPoint: ap.
	head attachPoint: ap
]
