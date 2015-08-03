Class {
	#name : #RTResizeTest,
	#superclass : #RTTest,
	#instVars : [
		'elements',
		'resize'
	],
	#category : #'Roassal2-Core-Tests'
}

{ #category : #running }
RTResizeTest >> setUp [
	elements := (RTBox new height: #yourself; width: [ :o | o + 1 ]) elementsOn: (1 to: 3).
	resize := RTResize new.
	resize elements: elements.
]

{ #category : #tests }
RTResizeTest >> testBiggestExtent [
	self assert: resize biggestExtent equals: 4 @ 3
]

{ #category : #tests }
RTResizeTest >> testSameHeight [
	resize fixedElement: elements second.
	resize sameHeight.
	self assert: (elements collect: #extent) asSet asArray equals: (Array with: (2.0@2.0) with: (4.0@2.0) with: (3.0@2.0))
]

{ #category : #tests }
RTResizeTest >> testSameWidth [
	resize fixedElement: elements second.
	resize sameWidth.
	self assert: (elements collect: #extent) asSet asArray equals: (Array with: (3.0@1.0) with:(3.0@2.0) with: (3.0@3.0))
]
