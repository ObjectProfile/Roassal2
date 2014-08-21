"
A RTMultiLine represents 

Instance Variables
	blockProducingPath:		<Block>   a two arg block that produces the path. The block has to return the collection of points

blockProducingPath
	- xxxxx

"
Class {
	#name : #RTMultiLine,
	#superclass : #RTAbstractLine,
	#instVars : [
		'blockProducingPath'
	],
	#category : 'Roassal2-Core'
}

{ #category : #accessing }
RTMultiLine >> block: aTwoArgBlock [

	blockProducingPath := aTwoArgBlock 
]

{ #category : #initialization }
RTMultiLine >> initialize [
	super initialize.
	self straight
]

{ #category : #'public - configuration' }
RTMultiLine >> orthoHorizontal [

	self block: [ :fromPoint :toPoint | 
		| edgeBound midx |
		
		edgeBound := fromPoint corner: toPoint.
		midx := ((edgeBound corner x - edgeBound origin x) / 2) asInteger + edgeBound origin x.
		Array 
			with: fromPoint 
			with: (midx @ edgeBound origin y) 
			with: (midx @ edgeBound corner y) 
			with: toPoint ]
]

{ #category : #'public - configuration' }
RTMultiLine >> orthoVertical [
	self block: [ :fromPoint :toPoint | 
		| edgeBound midy |
		
		edgeBound := fromPoint corner: toPoint.
		midy := ((edgeBound corner y - edgeBound origin y) / 2) asInteger +
					 edgeBound origin y.
		Array 
			with: fromPoint 
			with: (edgeBound origin x @ midy) 
			with: (edgeBound corner x @ midy) 
			with: toPoint ]
]

{ #category : #'public - configuration' }
RTMultiLine >> straight [
	"A straight line"
	self block: [ :fromPoint :toPoint | Array with: fromPoint with: toPoint ]
]

{ #category : #public }
RTMultiLine >> trachelShapeFor: anEdge [
	| shape multiShape col fromPoint toPoint path |
	col := self colorFor: anEdge.
	fromPoint := attachPoint startingPointOf: anEdge.
	toPoint := attachPoint endingPointOf: anEdge.
	path := blockProducingPath value: fromPoint value: toPoint.
	
	multiShape := TRMultiCompositeShape new.
	2 to: path size do: [ :i |
		shape := TRLineShape new.
		shape width: width.
		shape from: (path at: i - 1) to: (path at: i).
		shape color: col.

		multiShape addShape: shape.
	].
	^ multiShape
]

{ #category : #public }
RTMultiLine >> updateFor: anEdge trachelShape: trachelShape [

	| shape col fromPoint toPoint path |
	col := self colorFor: anEdge.
	fromPoint := attachPoint startingPointOf: anEdge.
	toPoint := attachPoint endingPointOf: anEdge.
	path := blockProducingPath value: fromPoint value: toPoint.
	
	2 to: path size do: [ :i |
		shape := trachelShape shapes at: i - 1.
		shape width: width.
		shape from: (path at: i - 1) to: (path at: i).
		shape color: col.
	].
	^ trachelShape
]
