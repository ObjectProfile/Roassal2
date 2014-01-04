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
	"We return a Trachel null shape because shapedObjects play directly with the low level shape"

	^ TRNoShape new
]

{ #category : #rendering }
RTNoShape >> updateFor: anElement [
	"Do nothing"
]

{ #category : #rendering }
RTNoShape >> widthFor: element [
	^ 0
]
