Class {
	#name : #RTLinearClosedInterpolator,
	#superclass : #RTInterpolator,
	#category : #'Roassal2-Experimental'
}

{ #category : #'as yet unclassified' }
RTLinearClosedInterpolator >> closed [
	^ true
]

{ #category : #'as yet unclassified' }
RTLinearClosedInterpolator >> interpolate: points [
	^ (RTLinearInterpolator new interpolate: points),'Z'.
]
