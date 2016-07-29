"
this depends on the RTScale

For example to use one instance of my class, try:

linear  := RTScale linear domain: #(40 80); range: #(20 60).
linear scale: 50 ""30""

In this case RTScale linear is using a number interpolator, because the domain and the range are number
"
Class {
	#name : #RTNumberInterpolator,
	#superclass : #RTInterpolator,
	#category : #'Roassal2-Experimental'
}

{ #category : #'as yet unclassified' }
RTNumberInterpolator >> interpolate: t [
	^ (start * (1 - t)) + (stop * t).
]
