Class {
	#name : #TRSVGPathTest,
	#superclass : #TRTest,
	#category : #'Trachel-Core'
}

{ #category : #tests }
TRSVGPathTest >> testColor [
	| path |
	path := TRSVGPath new.
	self assert: path color equals: Color black.
	
	path color: Color blue.
	self assert: path color equals: Color blue.
]

{ #category : #tests }
TRSVGPathTest >> testDefault [
	| path |
	path := TRSVGPath new.
	self assert: path height equals: 0.
	self assert: path width equals: 0.
]
