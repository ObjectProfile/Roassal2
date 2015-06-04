"
A simple clase for create Lines in SVG
"
Class {
	#name : #RTLinearInterpolator,
	#superclass : #RTInterpolator,
	#category : #'Roassal2-Experimental'
}

{ #category : #'as yet unclassified' }
RTLinearInterpolator >> interpolate: points [
	^ points inject: '' into: [ :str :each | 'L', each x asString, ' ', each y asString ].
]
