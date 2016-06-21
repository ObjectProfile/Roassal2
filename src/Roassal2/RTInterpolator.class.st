"
I am a base Interpolator, my sbuclasses are
	RTColorInterpolator, and RTNumberInterpolator
	
"
Class {
	#name : #RTInterpolator,
	#superclass : #RTObject,
	#instVars : [
		'start',
		'stop'
	],
	#category : #'Roassal2-Experimental'
}

{ #category : #'as yet unclassified' }
RTInterpolator class >> interpolate: a and: b [
	| clazz |
	clazz := self interpolatorFor: b.
	
	^ clazz new start: a; stop: b .
		
]

{ #category : #'as yet unclassified' }
RTInterpolator class >> interpolatorFor: b [
	b isString
		ifTrue: [ 
			('#*' match: b) ifTrue: [ ^ RTColorInterpolator ].
			^ nil. "RTStringInterpolator" ]. "TODO"
	b isColor
		ifTrue: [ ^ RTColorInterpolator ].
	"b isArray
		ifTrue: [ ^ RTArrayInterpolator ].
	b isNumber
		ifFalse: [^ RTObjectInterpolator]" "TODO"
	^ RTNumberInterpolator


		
]

{ #category : #accessing }
RTInterpolator >> interpolate: anObject [
	self subclassResponsibility 
]

{ #category : #accessing }
RTInterpolator >> start: anObject [
	start := anObject
]

{ #category : #accessing }
RTInterpolator >> stop: anObject [
	stop := anObject
]
