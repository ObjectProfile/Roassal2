"
This implements the Null pattern for a Roassal shape. It is typically used for defaults.
"
Class {
	#name : #RTNoShape,
	#superclass : #RTShape,
	#classInstVars : [
		'instance'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTNoShape class >> new [
	instance ifNil: [ instance := super new ].
	^ instance
]

{ #category : #rendering }
RTNoShape >> heightFor: element [
	^ 0
]

{ #category : #hooks }
RTNoShape >> trachelShapeFor: element [
	"Nothing to do here"
	self flag: 'actually, we should return a null trachel shape because the shape is cached in the element, and the element works directly with the trachel shape'
]

{ #category : #rendering }
RTNoShape >> updateFor: anElement [
	"Do nothing"
]

{ #category : #rendering }
RTNoShape >> widthFor: element [
	^ 0
]
