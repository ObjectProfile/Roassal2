"
this depends on the RTScale

For example to use one instance of my class, try:

linear  := RTScale linear domain: #(40 80); range: (Array with: Color gray with: Color red)
linear scale: 50 ""Color r: 0.626 g: 0.375 b: 0.375 alpha: 1.0)""

In this case RTScale linear is using a number interpolator, because the domain are numbers, but the range are colors


"
Class {
	#name : #RTColorInterpolator,
	#superclass : #RTInterpolator,
	#category : #'Roassal2-Experimental'
}

{ #category : #'as yet unclassified' }
RTColorInterpolator >> interpolate: t [
	^ Color
		r: start red + ((stop red - start red) * t)
		g: start green + ((stop green - start green)  * t)
		b: start blue + ((stop blue - start blue) * t).
]

{ #category : #'as yet unclassified' }
RTColorInterpolator >> start: anObject [
	start := Color colorFrom: anObject
]

{ #category : #'as yet unclassified' }
RTColorInterpolator >> stop: anObject [
	stop := Color colorFrom: anObject
]
