Class {
	#name : #RTAbstractElementShape,
	#superclass : #RTShape,
	#instVars : [
		'height',
		'width'
	],
	#category : #Roassal2
}

{ #category : #configuration }
RTAbstractElementShape >> defaultHeight [
	^ 5
]

{ #category : #configuration }
RTAbstractElementShape >> defaultWidth [
	^ 5
]

{ #category : #accessing }
RTAbstractElementShape >> height: aValueOrASymbolOrAOneArgBlock [
	height := aValueOrASymbolOrAOneArgBlock
]

{ #category : #rendering }
RTAbstractElementShape >> heightFor: anElement [
	^ height rtValue: anElement
]

{ #category : #initialization }
RTAbstractElementShape >> initialize [
	super initialize.
	width := self defaultWidth.
	height := self defaultHeight.
	
]

{ #category : #accessing }
RTAbstractElementShape >> size: aValueOrASymbolOrAOneArgBlock [
	self height: aValueOrASymbolOrAOneArgBlock.
	self width: aValueOrASymbolOrAOneArgBlock
]

{ #category : #accessing }
RTAbstractElementShape >> width: aValueOrASymbolOrAOneArgBlock [
	width := aValueOrASymbolOrAOneArgBlock
]

{ #category : #rendering }
RTAbstractElementShape >> widthFor: anElement [
	^ width rtValue: anElement
]
