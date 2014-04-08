Class {
	#name : #TRCallbackTest,
	#superclass : #TRTest,
	#instVars : [
		'canvas',
		'circle1',
		'circle2'
	],
	#category : #'Trachel-Core'
}

{ #category : #running }
TRCallbackTest >> setUp [

	canvas := TRCanvas new.
	circle1 := canvas buildCircleFrom: 20 @ 20 to: 150 @ 100 color: (Color green alpha: 0.1).
	circle2 := canvas buildCircleFrom: 200 @ 200 to: 240 @ 230 color: (Color blue alpha: 0.1).	
]

{ #category : #tests }
TRCallbackTest >> testCallback [
	| callback v s  |
	callback := TRTranslationCallback 
						block: [ :shape :step | 
									v := shape. s := step ].
	circle1 addCallback: callback.

	self assert: circle1 position = (0 @ 0).
	circle1 translateTo: 20 @ 30.
	self assert: v == circle1.
	self assert: v center = (20 @ 30).
	self assert: s = (20 @ 30).

	v := nil.
	circle1 translateBy: 5 @ 3.
	self assert: v == circle1.
	self assert: v center = (25 @ 33).
	self assert: s = (5 @ 3).
	
]

{ #category : #tests }
TRCallbackTest >> testHasCallBack [

	self deny: TREllipseShape new hasCallback.
	self assert: (TREllipseShape new addCallback: TRTranslationCallback new) hasCallback
]
