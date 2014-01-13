"
A ROCircleLayout is xxxxxxxxx.

"
Class {
	#name : #RTCircleLayout,
	#superclass : #RTAbstractCircleLayout,
	#category : #'Roassal2-Layouts'
}

{ #category : #'instance creation' }
RTCircleLayout class >> scaleBy: aNumber [
	
	^self new scaleBy: aNumber
]

{ #category : #hook }
RTCircleLayout >> computeIncrementalAngleFor: elements [
	"Return the value _in radian_ of the incremental angle"
	
	^ initialIncrementalAngle = 0
		ifTrue: [ 2 * Float pi / elements size ]
		ifFalse: [ initialIncrementalAngle ]
]

{ #category : #hook }
RTCircleLayout >> computeRadiusFor: elements [
	"Return the radius of the circle. If none has been set (i.e., initialRadius = 0), then it is computed as the scale factor times the number of elements"
	^ initialRadius = 0 
		ifTrue: [ elements size * self scaleFactor ]
		ifFalse: [ initialRadius ]
]

{ #category : #hook }
RTCircleLayout >> doExecute: elements [
	| angleIncrement angle rad center |
	rad := self computeRadiusFor: elements.
	center := Point x: rad y: rad.
	angleIncrement := self computeIncrementalAngleFor: elements.
	angle := self initialAngle.
	elements
		do: [ :each | 
			| point |
			point := center + (Point radius: rad theta: angle).
			angle := angle + angleIncrement.
			translator translate: each to: point.
			self step ]
]
