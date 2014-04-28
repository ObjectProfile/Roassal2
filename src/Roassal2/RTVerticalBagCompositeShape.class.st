Class {
	#name : #RTVerticalBagCompositeShape,
	#superclass : #RTAbstractCompositeShape,
	#instVars : [
		'children',
		'shape'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTVerticalBagCompositeShape >> initialize [
	super initialize.
	children := #yourself.
	shape := RTLabel new
]

{ #category : #'as yet unclassified' }
RTVerticalBagCompositeShape >> shape [
	^ shape
]

{ #category : #'as yet unclassified' }
RTVerticalBagCompositeShape >> shape: aShape [
	shape := aShape
]

{ #category : #'as yet unclassified' }
RTVerticalBagCompositeShape >> trachelShapeFor: anElement [
	| s c |
	self error: 'This code is not finished. Do not use it'.
	c := children rtValue: anElement.
	c := c reversed.
	
	s := TRCompositeShape new.
	c do: [ :m |
		| ns |
		s shape1: (shape trachelShapeFor: m).
		ns := TRCompositeShape new.
		s shape2: ns.
		s := ns ].
	
	"s1 := shape1 trachelShapeFor: anElement.
	s2 := shape2 trachelShapeFor: anElement.
	c := TRCompositeShape 
			with: s1 
			with: s2.
	c offset2: (0 @ ((s1 height / 2) + (s2 height / 2))).
"	^ c
]
