Class {
	#name : #RTCompositeShape,
	#superclass : #RTShape,
	#instVars : [
		'shape1',
		'shape2',
		'offset2'
	],
	#category : #'Roassal2-Core'
}

{ #category : #public }
RTCompositeShape class >> with: s1 with: s2 [
	^ self new shape1: s1; shape2: s2; yourself
]

{ #category : #rendering }
RTCompositeShape >> heightFor: anElement [
	^ (shape1 heightFor: anElement) max: (shape2 heightFor: anElement)
]

{ #category : #'as yet unclassified' }
RTCompositeShape >> initialize [
	super initialize.
	offset2 := 0 @ 0
]

{ #category : #accessing }
RTCompositeShape >> offset2: aPoint [
	offset2 := aPoint
]

{ #category : #copying }
RTCompositeShape >> postCopy [
	super postCopy.
	shape1 := shape1 copy.
	shape2 := shape2 copy.
]

{ #category : #accessing }
RTCompositeShape >> shape1 [
	^ shape1
]

{ #category : #accessing }
RTCompositeShape >> shape1: anRTShape [
	shape1 := anRTShape
]

{ #category : #accessing }
RTCompositeShape >> shape2 [
	^ shape2
]

{ #category : #accessing }
RTCompositeShape >> shape2: aRTShape [
	shape2 := aRTShape
]

{ #category : #hooks }
RTCompositeShape >> trachelShapeFor: anElement [
	| s1 s2 |
	s1 := shape1 trachelShapeFor: anElement.
	s2 := shape2 trachelShapeFor: anElement.
	s2 translateBy: offset2.
	^ TRCompositeShape 
			with: s1 
			with: s2
]

{ #category : #hooks }
RTCompositeShape >> updateFor: anElement [
	shape1 updateFor: anElement trachelShape: anElement trachelShape shape1.
	shape2 updateFor: anElement trachelShape: anElement trachelShape shape2.
	anElement trachelShape shape2 translateBy: offset2
]

{ #category : #rendering }
RTCompositeShape >> widthFor: anElement [
	^ (shape1 widthFor: anElement) max: (shape2 widthFor: anElement)
]
