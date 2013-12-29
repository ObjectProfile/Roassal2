Class {
	#name : #RTLabel,
	#superclass : #RTShape,
	#instVars : [
		'text'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTLabel >> defaultText [
	^ [ :e | e model asString ]
]

{ #category : #'as yet unclassified' }
RTLabel >> initialize [
	super initialize.
	text := self defaultText
]

{ #category : #'as yet unclassified' }
RTLabel >> text: aStringOrABlock [

	text := aStringOrABlock
]

{ #category : #'as yet unclassified' }
RTLabel >> textFor: element [
	^ text roValue: element
]

{ #category : #'as yet unclassified' }
RTLabel >> trachelShapeFor: anElement [
	|  shape |
	"ex := (self widthFor: anElqement) @ (self heightFor: anElement)."
	"rec := (anElement position ) extent: ex."
	
	shape := TRLabelShape new.
	shape text: (self textFor: anElement) on: anElement position.
	^ shape
]
