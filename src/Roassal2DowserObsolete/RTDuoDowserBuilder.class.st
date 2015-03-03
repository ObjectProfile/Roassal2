"
A RTDuoDowserBuilder is a 2 column dowser with its own API for managing the builder values.

"
Class {
	#name : #RTDuoDowserBuilder,
	#superclass : #RTDowserBuilder,
	#category : #Roassal2DowserObsolete
}

{ #category : #accessing }
RTDuoDowserBuilder >> colorLeft [
	^colors at: 2 ifAbsent: [ colors at: 1]
]

{ #category : #accessing }
RTDuoDowserBuilder >> colorLeft: aMessage [
	^colors at: 2 put: aMessage
]

{ #category : #accessing }
RTDuoDowserBuilder >> colorRight [
	^colors at: 3 ifAbsent: [ colors at: 1]
]

{ #category : #accessing }
RTDuoDowserBuilder >> colorRight: aMessage [
	^colors at: 3 put: aMessage
]

{ #category : #'adding edges' }
RTDuoDowserBuilder >> edgesFromLeft:  aBlock [
	self edgesWith: aBlock from: 1 to: 2.
]

{ #category : #'adding edges' }
RTDuoDowserBuilder >> edgesFromLeft: aBlock edgesFromRight: anotherBlock [
	self edgesFromLeft: aBlock.
	self edgesFromRight: anotherBlock.
]

{ #category : #'adding edges' }
RTDuoDowserBuilder >> edgesFromLeft: aBlock edgesToLeft: anotherBlock [
	self edgesFromLeft: aBlock.
	self edgesToLeft: anotherBlock.
]

{ #category : #'adding edges' }
RTDuoDowserBuilder >> edgesFromRight: aBlock [
	self edgesWith: aBlock from: 2 to: 1.
]

{ #category : #'adding edges' }
RTDuoDowserBuilder >> edgesToLeft:  aBlock [
	self edgesWith: aBlock to: 2 from: 1
]

{ #category : #'adding edges' }
RTDuoDowserBuilder >> edgesToLeft: aBlock edgesToRight: anotherBlock [
	self edgesToLeft: aBlock.
	self edgesToRight: anotherBlock.
]

{ #category : #'adding edges' }
RTDuoDowserBuilder >> edgesToRight:  aBlock [
	self edgesWith: aBlock to: 1 from: 2
]

{ #category : #'adding edges' }
RTDuoDowserBuilder >> edgesToRight: aBlock edgesFromRight: anotherBlock [
	self edgesToRight: aBlock.
	self edgesFromRight: anotherBlock.
]

{ #category : #accessing }
RTDuoDowserBuilder >> heightLeft [
	^heights at: 2 ifAbsent: [ heights at: 1]
]

{ #category : #accessing }
RTDuoDowserBuilder >> heightLeft: aBlock [
	heights at: 2 put: aBlock
]

{ #category : #accessing }
RTDuoDowserBuilder >> heightRight [
	^heights at: 3 ifAbsent: [ heights at: 1]
]

{ #category : #accessing }
RTDuoDowserBuilder >> heightRight: aBlock [
	heights at: 3 put: aBlock
]

{ #category : #initialization }
RTDuoDowserBuilder >> initialize [
	super initialize.
	self addColumn: OrderedCollection new.
	self addColumn: OrderedCollection new.

]

{ #category : #accessing }
RTDuoDowserBuilder >> labelLeft [
	^labels at: 2 ifAbsent: [ labels at: 1]
]

{ #category : #accessing }
RTDuoDowserBuilder >> labelLeft: aMessage [
	labels at: 2 put: aMessage
]

{ #category : #accessing }
RTDuoDowserBuilder >> labelRight [
	^labels at: 3 ifAbsent: [ labels at: 1 ] 
]

{ #category : #accessing }
RTDuoDowserBuilder >> labelRight: aMessage [
	labels at: 3 put: aMessage
]

{ #category : #accessing }
RTDuoDowserBuilder >> left [
	^(columns at: 1)
]

{ #category : #accessing }
RTDuoDowserBuilder >> left: aCollection [
	self models addAll: aCollection.
	columns at: 1 put: (self from: aCollection in: 1).
]

{ #category : #accessing }
RTDuoDowserBuilder >> onLeftAndRight: aCollection [
	self left: aCollection.
	self right: aCollection.
]

{ #category : #accessing }
RTDuoDowserBuilder >> right [
	^ (columns at: 2)
]

{ #category : #accessing }
RTDuoDowserBuilder >> right: aCollection [
	self models addAll: aCollection.
	columns at: 2 put: (self from: aCollection in: 2).
]
