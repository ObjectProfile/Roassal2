Class {
	#name : #RTSunburstBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'visitor',
		'startingNode'
	],
	#category : #'Roassal2-Builder-Sunburst'
}

{ #category : #configuration }
RTSunburstBuilder >> angularSpacing: anInteger [
	self visitor angularSpacing: anInteger
]

{ #category : #public }
RTSunburstBuilder >> explore: anObject using: aBlock [ 
	"This is the main public method of Sunburst. 
	This method allows for the inspection of a domain"

	| parentNode |
	parentNode := RTNode new.
	parentNode model: anObject.
	self recurse: parentNode using: aBlock.
	startingNode := parentNode.
	parentNode accept: self visitor.
]

{ #category : #initialization }
RTSunburstBuilder >> initialize [
	super initialize.
	visitor :=RTSunburstNodeVisitor new.
	visitor builder: self.
	self shape arc
				color:  [ :o | Color random ]
]

{ #category : #configuration }
RTSunburstBuilder >> radialSpacing: anInteger [
	self visitor radialSpacing: anInteger
]

{ #category : #utility }
RTSunburstBuilder >> recurse: parentNode using: aBlock [

	| children |
	children := aBlock rtValue: parentNode model.
	children do: [ :childObject | 
		| n |
		n := RTNode new.
		n model: childObject.
		parentNode addChild: n.
		self recurse: n using: aBlock ]
]

{ #category : #'as yet unclassified' }
RTSunburstBuilder >> renderIn: aView [
	aView addAll: visitor arcs.
	visitor lines do: [ :line | aView canvas addShape: line].
	
]

{ #category : #accessing }
RTSunburstBuilder >> visitor [
	^ visitor
]
