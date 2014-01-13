"
A ROCenteredCircleLayout is xxxxxxxxx.

Instance Variables
	center:		<Object>

center
	- xxxxx

"
Class {
	#name : #RTCenteredCircleLayout,
	#superclass : #RTAbstractCircleLayout,
	#instVars : [
		'center'
	],
	#category : #'Roassal2-Layouts'
}

{ #category : #accessing }
RTCenteredCircleLayout >> center [
	"Return the point around which the layout will place nodes"
	^ center
]

{ #category : #accessing }
RTCenteredCircleLayout >> center: aPoint [
	"Set the point around which the layout will place nodes"
	center := aPoint
]

{ #category : #'as yet unclassified' }
RTCenteredCircleLayout >> computeIncrementalAngleFor: elements [
	"Return the value _in radian_ of the incremental angle"
	
	^ initialIncrementalAngle = 0
		ifTrue: [ 2 * Float pi / elements size ]
		ifFalse: [ initialIncrementalAngle ]
]

{ #category : #'as yet unclassified' }
RTCenteredCircleLayout >> computeRadiusFor: elements [
	"Return the radius of the circle. If none has been set (i.e., initialRadius = 0), then it is computed as the scale factor times the number of elements"
	^ initialRadius = 0 
		ifTrue: [ elements size * self scaleFactor ]
		ifFalse: [ initialRadius ]
]

{ #category : #'as yet unclassified' }
RTCenteredCircleLayout >> doExecute: elements [
	| angleIncrement angle rad centerPoint |
	rad := self computeRadiusFor: elements.
	centerPoint := center.
	angleIncrement := self computeIncrementalAngleFor: elements.
	angle := self initialAngle.
	elements
		do: [ :each | 
			| point |
			point := centerPoint + (Point radius: rad theta: angle).
			angle := angle + angleIncrement.
			translator translate: each to: point.
			self step ]
]

{ #category : #'as yet unclassified' }
RTCenteredCircleLayout >> initialize [
	super initialize.
	center := 0 @ 0
]
