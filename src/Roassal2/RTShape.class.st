Class {
	#name : #RTShape,
	#superclass : #RTObject,
	#instVars : [
		'color'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTShape class >> element [

	^ self instance element
]

{ #category : #'as yet unclassified' }
RTShape class >> elementOn: aModel [

	^ self instance elementOn: aModel
]

{ #category : #'as yet unclassified' }
RTShape class >> elementsOn: models [
	"Return a group of elements, which is a kind of ordered collection"
	| group |
	group := RTGroup new.
	models do: [ :m | 
		group add: (self instance elementOn: m) ].
	^ group
]

{ #category : #'as yet unclassified' }
RTShape class >> instance [
	^ self new
]

{ #category : #public }
RTShape >> + anotherShape [
	^ RTCompositeShape with: self with: anotherShape instance
]

{ #category : #accessing }
RTShape >> color [
	^ color
]

{ #category : #accessing }
RTShape >> color: aValueOrAOneArgBlock [
	"aValueOrAOneArgBlock is applied on the object model"
	self colorElement: [ :anElement | aValueOrAOneArgBlock rtValue: anElement model ]
]

{ #category : #accessing }
RTShape >> colorElement: aBlock [
	color := aBlock
]

{ #category : #rendering }
RTShape >> colorFor: anElement [
	^ color rtValue: anElement
]

{ #category : #configuration }
RTShape >> defaultColor [

	^ Color veryVeryLightGray
]

{ #category : #public }
RTShape >> element [

	^ RTElement new addShape: self; yourself
]

{ #category : #public }
RTShape >> elementOn: aModel [

	^ RTElement new model: aModel; addShape: self; yourself
]

{ #category : #public }
RTShape >> elementsOn: models [
	| group |
	group := RTGroup new.
	models do: [ :m | group add: (self elementOn: m) ].
	^ group
]

{ #category : #accessing }
RTShape >> fillColor [
	^ self color
]

{ #category : #accessing }
RTShape >> fillColor: arg [
	^ self color: arg
]

{ #category : #accessing }
RTShape >> fillColorElement: arg [
	^ self colorElement: arg
]

{ #category : #initialization }
RTShape >> initialize [
	super initialize.
	color := self defaultColor
]

{ #category : #accessing }
RTShape >> instance [
	^ self
]

{ #category : #hooks }
RTShape >> trachelShapeFor: element [
	self subclassResponsibility
]

{ #category : #hooks }
RTShape >> updateFor: edgeOrElement [
	self updateFor: edgeOrElement trachelShape: edgeOrElement trachelShape
]

{ #category : #hooks }
RTShape >> updateFor: edgeOrElement trachelShape: trachelShape [

	self subclassResponsibility
]
