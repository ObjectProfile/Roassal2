Class {
	#name : #RTLabel,
	#superclass : #RTShape,
	#instVars : [
		'text',
		'font',
		'height'
	],
	#category : #'Roassal2-Core'
}

{ #category : #configuration }
RTLabel >> defaultColor [

	^ Color black
]

{ #category : #'instance creation' }
RTLabel >> defaultText [
	^ [ :e | e model asString ]
]

{ #category : #accessing }
RTLabel >> height: aValueOrAOneArgBlock [
	"aValueOrAOneArgBlock is applied on the object model"
	self heightElement: [ :anElement | aValueOrAOneArgBlock rtValue: anElement model ]
]

{ #category : #accessing }
RTLabel >> heightElement: aValueOrABlock [
	height := aValueOrABlock
]

{ #category : #rendering }
RTLabel >> heightFor: element [
	^ height rtValue: element
]

{ #category : #initialization }
RTLabel >> initialize [
	super initialize.
	text := self defaultText.
	height := TRLabelShape defaultFontSize
]

{ #category : #accessing }
RTLabel >> text: aValueOrAOneArgBlock [
	"aValueOrAOneArgBlock is applied on the object model"
	self textElement: [ :anElement | aValueOrAOneArgBlock rtValue: anElement model ]
]

{ #category : #accessing }
RTLabel >> textElement: aStringOrABlock [

	text := aStringOrABlock
]

{ #category : #rendering }
RTLabel >> textFor: element [
	^ (text rtValue: element) asString
]

{ #category : #hooks }
RTLabel >> trachelShapeFor: anElement [
	|  shape |
	"ex := (self widthFor: anElement) @ (self heightFor: anElement)."
	"rec := (anElement position ) extent: ex."
	
	shape := TRLabelShape new.
	shape text: (self textFor: anElement);
			color: (self colorFor: anElement);
			position: anElement position;
			fontSize: (self heightFor: anElement).
	^ shape
]

{ #category : #rendering }
RTLabel >> updateFor: anElement trachelShape: trachelShape [	
	trachelShape isNil ifTrue: [ ^ self ].
	trachelShape 
		color: (self colorFor: anElement);
		text: (self textFor: anElement) on: anElement position
]

{ #category : #rendering }
RTLabel >> widthFor: anElement [
	^ TRLabelShape widthOfText: (self textFor: anElement) fontSize: (self heightFor: anElement)
]
