"
A RTSizeVisitorTest is a test class for testing the behavior of RTSizeVisitor
"
Class {
	#name : #RTSizeVisitorTest,
	#superclass : #TestCase,
	#instVars : [
		'visitor'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'tests-accessing' }
RTSizeVisitorTest >> setUp [
	visitor:= RTSizeVisitor new.
]

{ #category : #'tests-accessing' }
RTSizeVisitorTest >> testBottomRight [
]

{ #category : #'tests-private' }
RTSizeVisitorTest >> testComputeDimensions [
]

{ #category : #'tests-private' }
RTSizeVisitorTest >> testComputeHeight [
	visitor bottomRight: 100@100.
	visitor upperLeft: 0@0.
	visitor computeHeight.
	self assert: visitor height = 101.
	visitor upperLeft: 50@50.
	visitor computeHeight.
	self assert: visitor height= 51.
]

{ #category : #'tests-private' }
RTSizeVisitorTest >> testComputeTranslation [
	visitor computeTranslation.
	self assert: visitor translation = (0@0).
	visitor upperLeft: (-50 @ 20).
	visitor computeTranslation.
	self assert: visitor translation = (50@0).
]

{ #category : #'tests-private' }
RTSizeVisitorTest >> testComputeWidth [
	visitor bottomRight: 100@100.
	visitor upperLeft: 0@0.
	visitor computeWidth.
	self assert: visitor width = 101.
	visitor upperLeft: 50@50.
	visitor computeWidth.
	self assert: visitor width= 51.
]

{ #category : #'tests-private' }
RTSizeVisitorTest >> testGetShapeDimensions [
]

{ #category : #'tests-initialization' }
RTSizeVisitorTest >> testInitialize [
]

{ #category : #'tests-accessing' }
RTSizeVisitorTest >> testTranslation [
	
]

{ #category : #'tests-private' }
RTSizeVisitorTest >> testUpdateBottomRight [
]

{ #category : #'tests-private' }
RTSizeVisitorTest >> testUpdateUpperLeft [
]

{ #category : #'tests-accessing' }
RTSizeVisitorTest >> testUpperLeft [
]

{ #category : #'tests-visitor' }
RTSizeVisitorTest >> testVisitCanvas [
]

{ #category : #'tests-visitor' }
RTSizeVisitorTest >> testVisitView [
]
