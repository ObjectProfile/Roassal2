Class {
	#name : #VIAnimatedPointTest,
	#superclass : #TRTest,
	#instVars : [
		'pZero'
	],
	#category : #'Trachel-Viva'
}

{ #category : #running }
VIAnimatedPointTest >> setUp [
	super setUp.
	pZero := VIAnimatedPoint new.
]

{ #category : #tests }
VIAnimatedPointTest >> testAddToZero [
	| p |
	p := pZero + (1 @ 1).
	self assert: p x value equals: 1.
	self assert: p y value equals: 1.
]

{ #category : #tests }
VIAnimatedPointTest >> testZero [

	self assert: pZero x value equals: 0.
	self assert: pZero y value equals: 0.
]
