Class {
	#name : #RTMondrian,
	#superclass : #RTBuilder,
	#instVars : [
		'stack',
		'edgeBuilder'
	],
	#category : #'Roassal2-Builder-NewMondrian'
}

{ #category : #'as yet unclassified' }
RTMondrian >> applyLayout [
	layoutBuilder setUpElements: self topElements
]

{ #category : #'as yet unclassified' }
RTMondrian >> createInteractionBuilder [
	^ RTInteractionBuilder new popup; draggable; yourself
]

{ #category : #'as yet unclassified' }
RTMondrian >> createLayoutBuilder [
	| newLayoutBuilder |
	newLayoutBuilder := RTLayoutBuilder new.
	newLayoutBuilder horizontalLine.
	^ newLayoutBuilder
]

{ #category : #'as yet unclassified' }
RTMondrian >> createShapeBuilder [
	| sb |
	sb := RTShapeBuilder new.
	sb rectangle color: Color white; borderColor: Color black.
	^ sb
]

{ #category : #'as yet unclassified' }
RTMondrian >> edges [
	^ edgeBuilder
]

{ #category : #'as yet unclassified' }
RTMondrian >> initialize [
	super initialize.
	stack := OrderedCollection new.
	layoutBuilder := self createLayoutBuilder.
	edgeBuilder := RTEdgeBuilder new
]

{ #category : #'as yet unclassified' }
RTMondrian >> layout [
	^ layoutBuilder 
]

{ #category : #'as yet unclassified' }
RTMondrian >> node: anObject [
	"Add a new node to the view"
	^ (self nodes: (Array with: anObject)) first
]

{ #category : #'as yet unclassified' }
RTMondrian >> node: anObject forIt: aBlock [
	^ (self nodes: (Array with: anObject) forEach: [ :each | aBlock value ]) first
]

{ #category : #'as yet unclassified' }
RTMondrian >> nodes: objects [
	| els |
	self pushFrame: (RTMondrianFrame new).
	els := self elementsOn: objects.
	self topFrame setTopElements: els.
	view addAll: els.
	^ els
]

{ #category : #'as yet unclassified' }
RTMondrian >> nodes: objects forEach: aOneArgBlock [
	| result |
	result := self nodes: objects.

	self topElements do: [ :element | 
		aOneArgBlock rtValue: element model.
		
		RTNest new
			layout: layoutBuilder layout;
			on: element nest: self topFrame topElements.
		self popFrame.
	].
	^ result
]

{ #category : #'as yet unclassified' }
RTMondrian >> popFrame [
	^ stack removeLast
	
]

{ #category : #'as yet unclassified' }
RTMondrian >> pushFrame: aFrame [
	stack add: aFrame
]

{ #category : #'as yet unclassified' }
RTMondrian >> topElements [
	^ self topFrame topElements
]

{ #category : #'as yet unclassified' }
RTMondrian >> topFrame [
	^ stack last
]
