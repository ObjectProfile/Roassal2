Class {
	#name : #RTAbstractElementShape,
	#superclass : #RTShape,
	#instVars : [
		'height',
		'width',
		'borderColor'
	],
	#category : #'Roassal2-Core'
}

{ #category : #accessing }
RTAbstractElementShape >> borderColor [
	^ borderColor
]

{ #category : #accessing }
RTAbstractElementShape >> borderColor [
	^ borderColor
]

{ #category : #accessing }
RTAbstractElementShape >> borderColor: aValueOrAOneArgBlock [
	borderColor := aValueOrAOneArgBlock
]

{ #category : #accessing }
RTAbstractElementShape >> borderColor: aValueOrAOneArgBlock [
	borderColor := aValueOrAOneArgBlock
]

{ #category : #accessing }
RTAbstractElementShape >> borderColorFor: anElement [
	^ borderColor rtValue: anElement
]

{ #category : #accessing }
RTAbstractElementShape >> borderColorFor: anElement [
	^ borderColor rtValue: anElement
]

{ #category : #configuration }
RTAbstractElementShape >> defaultHeight [
	^ 5
]

{ #category : #configuration }
RTAbstractElementShape >> defaultHeight [
	^ 5
]

{ #category : #configuration }
RTAbstractElementShape >> defaultWidth [
	^ 5
]

{ #category : #configuration }
RTAbstractElementShape >> defaultWidth [
	^ 5
]

{ #category : #accessing }
RTAbstractElementShape >> extent: extentAsPoint [
	self width: extentAsPoint x.
	self height: extentAsPoint y.

]

{ #category : #accessing }
RTAbstractElementShape >> extent: extentAsPoint [
	self width: extentAsPoint x.
	self height: extentAsPoint y.

]

{ #category : #accessing }
RTAbstractElementShape >> height [
	^ height
]

{ #category : #accessing }
RTAbstractElementShape >> height [
	^ height
]

{ #category : #accessing }
RTAbstractElementShape >> height: aValueOrASymbolOrAOneArgBlock [
	height := aValueOrASymbolOrAOneArgBlock
]

{ #category : #accessing }
RTAbstractElementShape >> height: aValueOrASymbolOrAOneArgBlock [
	height := aValueOrASymbolOrAOneArgBlock
]

{ #category : #rendering }
RTAbstractElementShape >> heightFor: anElement [
	^ height rtValue: anElement
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
RTAbstractElementShape >> size: aValueOrASymbolOrAOneArgBlock [
	self height: aValueOrASymbolOrAOneArgBlock.
	self width: aValueOrASymbolOrAOneArgBlock
]

{ #category : #accessing }
RTAbstractElementShape >> width [
	^ width
]

{ #category : #accessing }
RTAbstractElementShape >> width [
	^ width
]

{ #category : #accessing }
RTAbstractElementShape >> width: aValueOrASymbolOrAOneArgBlock [
	width := aValueOrASymbolOrAOneArgBlock
]

{ #category : #accessing }
RTAbstractElementShape >> width: aValueOrASymbolOrAOneArgBlock [
	width := aValueOrASymbolOrAOneArgBlock
]

{ #category : #rendering }
RTAbstractElementShape >> widthFor: anElement [
	^ width rtValue: anElement
]

{ #category : #rendering }
RTAbstractElementShape >> widthFor: anElement [
	^ width rtValue: anElement
]
