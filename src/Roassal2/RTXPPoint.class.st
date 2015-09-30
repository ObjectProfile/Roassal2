"
I am an point with an offset
"
Class {
	#name : #RTXPPoint,
	#superclass : #RTObject,
	#instVars : [
		'x',
		'y',
		'y0'
	],
	#category : #'Roassal2-Experimental'
}

{ #category : #accessing }
RTXPPoint >> x: aNumber [
	x := aNumber
]

{ #category : #accessing }
RTXPPoint >> y0 [
	^ y0
]

{ #category : #accessing }
RTXPPoint >> y0: aNumber [
	y0 := aNumber
]

{ #category : #accessing }
RTXPPoint >> y: aNumber [
	y := aNumber
]
