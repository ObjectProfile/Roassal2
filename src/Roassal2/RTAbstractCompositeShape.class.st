Class {
	#name : #RTAbstractCompositeShape,
	#superclass : #RTShape,
	#instVars : [
		'shape1',
		'shape2',
		'offset2'
	],
	#category : #'Roassal2-Core'
}

{ #category : #rendering }
RTAbstractCompositeShape >> heightFor: anElement [
	^ (shape1 heightFor: anElement) max: (shape2 heightFor: anElement)
]

{ #category : #initialization }
RTAbstractCompositeShape >> initialize [
	super initialize.
	offset2 := 0 @ 0
]

{ #category : #accessing }
RTAbstractCompositeShape >> offset2 [
	^ offset2
]

{ #category : #accessing }
RTAbstractCompositeShape >> offset2: aPoint [
	offset2 := aPoint
]

{ #category : #copying }
RTAbstractCompositeShape >> postCopy [
	super postCopy.
	shape1 := shape1 copy.
	shape2 := shape2 copy.
]

{ #category : #accessing }
RTAbstractCompositeShape >> shape1 [
	^ shape1
]

{ #category : #accessing }
RTAbstractCompositeShape >> shape1: anRTShape [
	shape1 := anRTShape
]

{ #category : #accessing }
RTAbstractCompositeShape >> shape2 [
	^ shape2
]

{ #category : #accessing }
RTAbstractCompositeShape >> shape2: aRTShape [
	shape2 := aRTShape
]

{ #category : #hooks }
RTAbstractCompositeShape >> trachelShapeFor: anElement [
	| s1 s2 c |
	s1 := shape1 trachelShapeFor: anElement.
	s2 := shape2 trachelShapeFor: anElement.
	c := TRCompositeShape 
			with: s1 
			with: s2.
	c offset2: offset2.
	^ c
]

{ #category : #hooks }
RTAbstractCompositeShape >> updateFor: anElement [
	shape1 updateFor: anElement trachelShape: anElement trachelShape shape1.
	shape2 updateFor: anElement trachelShape: anElement trachelShape shape2
]

{ #category : #rendering }
RTAbstractCompositeShape >> widthFor: anElement [
	^ (shape1 widthFor: anElement) max: (shape2 widthFor: anElement)
]
