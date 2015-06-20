Class {
	#name : #RTScaleBilinear,
	#superclass : #RTScale,
	#instVars : [
		'u',
		'i'
	],
	#category : #'Roassal2-Experimental'
}

{ #category : #'as yet unclassified' }
RTScaleBilinear >> rescale [
	u := uninterpolate uninterpolate: domain first and: domain second.
	i := interpolate interpolate: range first and: range second.
]

{ #category : #'as yet unclassified' }
RTScaleBilinear >> scale: x [
	^ i interpolate: (u uninterpolate: x)
]
