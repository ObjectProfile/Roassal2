"
A RTMultiColoredLine is a colored shape for lines from a color array  (Can be a Color Palete Sequential.

Instance Variables
	colorArray:		<Object>
	path :

colorArray
	- xxxxx

"
Class {
	#name : #RTMultiColoredLine,
	#superclass : #RTAbstractLine,
	#instVars : [
		'colorArray',
		'path'
	],
	#category : #'Roassal2-Core'
}

{ #category : #accessing }
RTMultiColoredLine >> block: aTwoArgBlock [
	path := aTwoArgBlock 
]

{ #category : #'as yet unclassified' }
RTMultiColoredLine >> colorShape [
	self block: [ :fromPoint :toPoint | 
		| edgeBound tab |
		
		tab := Array with: fromPoint.
		edgeBound := fromPoint corner: toPoint.
		1 to: (colorArray size - 1) do: [ :i |
			tab := tab copyWith: ( ((i * (edgeBound corner x - edgeBound origin x) / (colorArray size)) asInteger + edgeBound origin x) @ ( (i * (edgeBound corner y - edgeBound origin y) / (colorArray size)) asInteger + edgeBound origin y) ).
		].
		tab := tab copyWith: toPoint.	
	 ]
]

{ #category : #accessing }
RTMultiColoredLine >> colors [
 ^ colorArray 
]

{ #category : #accessing }
RTMultiColoredLine >> colors: anArray [

colorArray := anArray.
]

{ #category : #initialization }
RTMultiColoredLine >> initialize [
	super initialize.
	self straight
]

{ #category : #accessing }
RTMultiColoredLine >> straight [
	"A single color line"
	self block: [ :fromPoint :toPoint | Array with: fromPoint with: toPoint ]
]

{ #category : #public }
RTMultiColoredLine >> trachelShapeFor: anEdge [
	| shape multiShape fromPoint toPoint p|
	
	fromPoint := attachPoint startingPointOf: anEdge.
	toPoint := attachPoint endingPointOf: anEdge.
	p := path value: fromPoint value: toPoint.
	
	multiShape := TRCompositeShape new.
	2 to: p size do: [ :i |
		shape := TRLineShape new.
		shape width: width.
		shape from: (p at: i - 1) to: (p at: i).
		shape color: (colorArray atWrap: (i - 1)).
		multiShape addShape: shape.
	].
	^ multiShape
]

{ #category : #rendering }
RTMultiColoredLine >> updateFor: anEdge trachelShape: trachelShape [
	| shape fromPoint toPoint p |
	fromPoint := attachPoint startingPointOf: anEdge.
	toPoint := attachPoint endingPointOf: anEdge.
	p := path value: fromPoint value: toPoint.
	
	2 to: p size do: [ :i |
		shape := trachelShape shapes at: i - 1.
		shape width: width.
		shape from: (p at: i - 1) to: (p at: i).
		shape color: (colorArray atWrap: (i - 1)).
	].
	^ trachelShape
]
