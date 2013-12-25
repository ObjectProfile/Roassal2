Class {
	#name : #RTNull,
	#superclass : #RTShape,
	#classInstVars : [
		'instance'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTNull class >> new [
	instance ifNil: [ instance := super new ].
	^ instance
]

{ #category : #'as yet unclassified' }
RTNull >> heightFor: element [
	^ 0
]

{ #category : #'as yet unclassified' }
RTNull >> renderOn: trachelCanvas for: aShapedObject [
	"Nothing to do here"
]

{ #category : #'as yet unclassified' }
RTNull >> trachelShapeFor: element [
	"Nothing to do here"
]

{ #category : #'as yet unclassified' }
RTNull >> updateFor: anElement [
	"Do nothing"
]

{ #category : #'as yet unclassified' }
RTNull >> widthFor: element [
	^ 0
]
