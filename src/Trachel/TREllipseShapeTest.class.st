"
A TREllipseShapeTest is a test class for testing the behavior of TREllipseShape
"
Class {
	#name : #TREllipseShapeTest,
	#superclass : #TRTest,
	#category : #'Trachel-Tests'
}

{ #category : #tests }
TREllipseShapeTest >> testWidth [

	| s |
	s := TREllipseShape new size: 30.
	self assert: s strokeWidth equals: 0.005.
]
