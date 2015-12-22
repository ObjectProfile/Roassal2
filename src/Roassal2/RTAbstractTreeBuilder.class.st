"
I am a base class for some builders of roassal like:

RTTreeMapBuilder
RTCircularTreeMapBuilder
RTBundleBuilder
RTSunburstBuilder
"
Class {
	#name : #RTAbstractTreeBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'weight',
		'elements',
		'rootNodes'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #color }
RTAbstractTreeBuilder >> borderColor: aBlockOrObject [
	self shape borderColor: aBlockOrObject
]

{ #category : #'default-values' }
RTAbstractTreeBuilder >> childrenKey [
	^ #elements
]

{ #category : #color }
RTAbstractTreeBuilder >> color: aBlockOrObject [
	self shape color: aBlockOrObject
]

{ #category : #private }
RTAbstractTreeBuilder >> createElements: atree nesting: block1 leaves: block2 depth: depth [
	| children e leaves nodes|
	
	e := shapeBuilder elementOn: atree.
	self interaction setUpElement: e.
	self elements add: e.
	
	children := block1 rtValue: atree.
	e attributes at: #depth put: depth.
	children := children collect: [ :child | | e2 |
		e2 := self createElements: child nesting: block1 
			leaves: block2 depth: depth + 1.
		e2 attributes at: #parent put: e.
		e2 ] as: Array.
	leaves := (block2 rtValue: atree) collect: [:child | | e2 |
		e2 := self createElements: child nesting: #() 
			leaves: #() depth: depth +1.
		e2 attributes at: #parent put: e.
		e2 ] as: Array.
	nodes := OrderedCollection new: (leaves size + children size).
	nodes addAll: children; addAll: leaves.
		
	e attributes at: self childrenKey put: nodes.
	^ e.
]

{ #category : #private }
RTAbstractTreeBuilder >> createElements: atree using: ablock depth: depth [
	| children e |
	
	e := shapeBuilder elementOn: atree.
	self interaction setUpElement: e.
	self elements add: e.
	
	children := ablock rtValue: atree.
	e attributes at: #depth put: depth.
	children := children collect: [ :child | | e2 |
		e2 := self createElements: child using: ablock depth: depth + 1.
		e2 attributes at: #parent put: e.
		e2 ] as: Array.
	e attributes at: self childrenKey put: children.
	^ e.
]

{ #category : #accessing }
RTAbstractTreeBuilder >> elements [
	^ elements
]

{ #category : #accessing }
RTAbstractTreeBuilder >> elements: anArray [
	elements := anArray
]

{ #category : #building }
RTAbstractTreeBuilder >> explore: atree nesting: block1 leaves: block2 [
	^ (self from: (Array with: atree) nesting: block1 leaves: block2) first
]

{ #category : #building }
RTAbstractTreeBuilder >> explore: atree using: ablock [
	^ (self from: (Array with: atree) using: ablock) first.
	
]

{ #category : #building }
RTAbstractTreeBuilder >> from: objects nesting: block1 leaves: block2 [

	rootNodes := objects collect: [:obj | self createElements: obj nesting: block1 leaves: block2 depth: 1 ].
	
	^ rootNodes
]

{ #category : #building }
RTAbstractTreeBuilder >> from: objects using: ablock [

	rootNodes := objects collect: [:obj | self createElements: obj using: ablock depth: 1 ].
	
	^ rootNodes
]

{ #category : #initialization }
RTAbstractTreeBuilder >> initialize [
	super initialize.
	elements := OrderedCollection new.
	rootNodes := OrderedCollection new.
]

{ #category : #color }
RTAbstractTreeBuilder >> leafColor: aBlockOrColor [
	self shape 
		ifElement: [ :e | 
			(e attributes includesKey: self childrenKey) and: 
			[ (e attributes at: self childrenKey) isEmpty ]  ]
		fillColor: [:e | aBlockOrColor rtValue: e model ] .
]

{ #category : #weight }
RTAbstractTreeBuilder >> leafWeight: block [
	self weightElement: [ :e | 
		(e attributes includesKey: #weight) 
			ifTrue: [ e attributes at: #weight ]
			ifFalse: [ | w children |
				children := e attributes at: self childrenKey.
				children 
					ifEmpty: [ w := block rtValue: e model ]
					ifNotEmpty: [ 
						w := children
							inject: 0 
							into: [ :s :el | s + (weight rtValue: el) ] ].
				w := w max: self minWeightValue.
				e attributes at: #weight put: w.
				w ] ].
]

{ #category : #'default-values' }
RTAbstractTreeBuilder >> minWeightValue [
	^ 1
]

{ #category : #accessing }
RTAbstractTreeBuilder >> rootNodes [
	^ rootNodes
]

{ #category : #accessing }
RTAbstractTreeBuilder >> rootNodes: anArray [
	rootNodes := anArray
]

{ #category : #weight }
RTAbstractTreeBuilder >> weight [
	^ weight
]

{ #category : #weight }
RTAbstractTreeBuilder >> weight: anObject [
	self weightElement: [ :e| anObject rtValue: e model ].
]

{ #category : #weight }
RTAbstractTreeBuilder >> weightElement: block [
	"
	This builder uses weight variable do calculate the size of each rectangle
	weight block recives an element of the square and return a number
	self weightElement: [:element | 1 ]"
	weight := block
	
	
]
