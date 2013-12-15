Class {
	#name : #RTBox,
	#superclass : #RTShape,
	#instVars : [
		'width',
		'height'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTBox >> defaultHeight [
	^ 5
]

{ #category : #'as yet unclassified' }
RTBox >> defaultWidth [
	^ 5
]

{ #category : #'as yet unclassified' }
RTBox >> height: aValueOrASymbolOrAOneArgBlock [
	height := aValueOrASymbolOrAOneArgBlock
]

{ #category : #'as yet unclassified' }
RTBox >> heightFor: anElement [
	^ height rtValue: anElement
]

{ #category : #'as yet unclassified' }
RTBox >> initialize [
	super initialize.
	width := self defaultWidth.
	height := self defaultHeight
]

{ #category : #'as yet unclassified' }
RTBox >> renderOn: trachelCanvas for: anElement [
	| rec ex |
	ex := (self widthFor: anElement) @ (self heightFor: anElement).
	rec := (anElement position - (ex / 2)) extent: ex.
	trachelCanvas buildRectangle: rec color: Color lightGray
]

{ #category : #'as yet unclassified' }
RTBox >> size: aValueOrASymbolOrAOneArgBlock [
	self height: aValueOrASymbolOrAOneArgBlock.
	self width: aValueOrASymbolOrAOneArgBlock
]

{ #category : #'as yet unclassified' }
RTBox >> width: aValueOrASymbolOrAOneArgBlock [
	width := aValueOrASymbolOrAOneArgBlock
]

{ #category : #'as yet unclassified' }
RTBox >> widthFor: anElement [
	^ width rtValue: anElement
]
