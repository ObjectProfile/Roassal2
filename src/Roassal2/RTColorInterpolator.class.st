Class {
	#name : #RTColorInterpolator,
	#superclass : #RTInterpolator,
	#category : #'Roassal2-Experimental'
}

{ #category : #accessing }
RTColorInterpolator >> interpolate: t [
	^ Color
		r: start red + ((stop red - start red) * t)
		g: start green + ((stop green - start green)  * t)
		b: start blue + ((stop blue - start blue) * t)
		alpha: start alpha + ((stop alpha - start alpha) * t)
]

{ #category : #'as yet unclassified' }
RTColorInterpolator >> start: anObject [
	start := Color colorFrom: anObject
]

{ #category : #'as yet unclassified' }
RTColorInterpolator >> stop: anObject [
	stop := Color colorFrom: anObject
]
