Class {
	#name : #RTMondrianFrame,
	#superclass : #RTObject,
	#instVars : [
		'parentFrame',
		'depth',
		'parent',
		'elements',
		'childrenFrame'
	],
	#category : #'Roassal2-Builder-NewMondrian'
}

{ #category : #'as yet unclassified' }
RTMondrianFrame >> addElements: someElements [
	elements addAll: someElements
]

{ #category : #'as yet unclassified' }
RTMondrianFrame >> childrenFrames [
	^ childrenFrame copy
]

{ #category : #accessing }
RTMondrianFrame >> depth [
	"Return the depth of the frame, as integer"
	^ depth
]

{ #category : #accessing }
RTMondrianFrame >> depth: anInteger [
	"Set the depth of the frame, an integer"
	depth := anInteger
]

{ #category : #'as yet unclassified' }
RTMondrianFrame >> elements [
	^ elements
]

{ #category : #'as yet unclassified' }
RTMondrianFrame >> initialize [
	super initialize.
	depth := 1.
	childrenFrame := OrderedCollection new.
	elements := RTGroup new.
]

{ #category : #'as yet unclassified' }
RTMondrianFrame >> numberOfAllFrames [
	^ 1 + (childrenFrame inject: 0 into: [ :sum :frame | sum + frame numberOfAllFrames ])
]

{ #category : #'as yet unclassified' }
RTMondrianFrame >> numberOfChildrenFrames [
	^ childrenFrame size
]

{ #category : #'as yet unclassified' }
RTMondrianFrame >> numberOfElements [
	^ elements size
]

{ #category : #accessing }
RTMondrianFrame >> parentFrame [
	^ parentFrame
]

{ #category : #accessing }
RTMondrianFrame >> parentFrame: anObject [
	parentFrame := anObject
]

{ #category : #'as yet unclassified' }
RTMondrianFrame >> pushFrame: aFrame [
	childrenFrame add: aFrame.
	aFrame parentFrame: self.
	aFrame depth: self depth + 1
]
