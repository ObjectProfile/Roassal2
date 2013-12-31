Class {
	#name : #RTLabel,
	#superclass : #RTShape,
	#instVars : [
		'text',
		'font'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTLabel >> defaultText [
	^ [ :e | e model asString ]
]

{ #category : #'as yet unclassified' }
RTLabel >> heightFor: element [
	^ font height
]

{ #category : #'as yet unclassified' }
RTLabel >> initialize [
	super initialize.
	text := self defaultText.
	font := LogicalFont familyName: 'Arial' pointSize: 20.
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
	"ex := (self widthFor: anElement) @ (self heightFor: anElement)."
	"rec := (anElement position ) extent: ex."
	
	shape := TRLabelShape new.
	shape text: (self textFor: anElement) on: anElement position.
	^ shape
]

{ #category : #'as yet unclassified' }
RTLabel >> updateFor: anElement [
	| rec ex |
	
	anElement trachelShape isNil ifTrue: [ ^ self ].
	ex := (self widthFor: anElement) @ (self heightFor: anElement).
	rec := (anElement position - (ex / 2)) extent: ex.
	anElement trachelShape text: (self textFor: anElement) on: anElement position
]

{ #category : #'as yet unclassified' }
RTLabel >> widthFor: anElement [
	text := self textFor: anElement.
	^ (font widthOfString: text) * 2
]
