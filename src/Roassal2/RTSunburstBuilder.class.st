Class {
	#name : #RTSunburstBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'strategy',
		'elements',
		'weight',
		'interactions',
		'maxLevel'
	],
	#category : #'Roassal2-Builder-Sunburst'
}

{ #category : #configuration }
RTSunburstBuilder >> angularSpacing: anInteger [
	self strategy angularSpacing: anInteger
]

{ #category : #public }
RTSunburstBuilder >> explore: anObject using: aBlock [ 
	| e |
	elements := OrderedCollection new.
	maxLevel := 0.
	e := self recurse: anObject using: aBlock level: 0.
	e attributes at: #parent put: nil.
]

{ #category : #initialization }
RTSunburstBuilder >> initialize [
	super initialize.
	self strategy: RTSunburstConstantWidthStrategy new.
	self shape arc color:  [ :o | Color random ].
	self weight: [ :e | 1 ].
	
	self interactions add: RTPopup.
]

{ #category : #accessing }
RTSunburstBuilder >> interactions [
	^ interactions ifNil: [ interactions := OrderedCollection new ]
]

{ #category : #accessing }
RTSunburstBuilder >> maxLevel [
	^ maxLevel
]

{ #category : #configuration }
RTSunburstBuilder >> radialSpacing: anInteger [
	self strategy radialSpacing: anInteger
]

{ #category : #utility }
RTSunburstBuilder >> recurse: object using: aBlock level: level [

	| children e list total |
	
	e := shapeBuilder elementOn: object.
	elements add: e.
	self interactions do: [ :i | e @ i ].
	children := aBlock rtValue: object.
	list := OrderedCollection new: children size.
	total := 0.
	children do: [ :childObject | 
		| n |
		n := self recurse: childObject using: aBlock level: level + 1.
		n attributes at: #parent put: e.
		total := total + (self weight rtValue: childObject ).
		list add: n. ].
	e attributes at: #children put: list.
	e attributes at: #depth put: level.
	level > maxLevel ifTrue: [ maxLevel := level ].
	e attributes at: #weight put: total.
	^ e.
]

{ #category : #hooks }
RTSunburstBuilder >> renderIn: aView [
	strategy on: elements.
	aView addAll: elements.
	"visitor lines do: [ :line | aView canvas addShape: line]."
	
]

{ #category : #accessing }
RTSunburstBuilder >> strategy [
	^ strategy
]

{ #category : #accessing }
RTSunburstBuilder >> strategy: aRTStrategy [
	strategy := aRTStrategy.
	strategy builder: self.
]

{ #category : #accessing }
RTSunburstBuilder >> weight [
	^ weight
]

{ #category : #accessing }
RTSunburstBuilder >> weight: aBlock [
	weight := aBlock 
]
