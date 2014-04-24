Class {
	#name : #RTShape,
	#superclass : #RTObject,
	#instVars : [
		'color'
	],
	#category : #'Roassal2-Core'
}

{ #category : #public }
RTShape class >> color: aColor [
	^ self new color: aColor
]

{ #category : #accessing }
RTShape class >> element [

	^ self instance element
]

{ #category : #public }
RTShape class >> elementOn: aModel [

	^ self instance elementOn: aModel
]

{ #category : #public }
RTShape class >> elementsOn: models [
	"Return a group of elements, which is a kind of ordered collection"
	| group aShape |
	group := RTGroup new.
	aShape := self instance.
	models do: [ :m | 
		group add: (aShape elementOn: m) ].
	^ group
]

{ #category : #accessing }
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
RTShape >> trachelShapeClass [
	self subclassResponsibility 
]

{ #category : #public }
RTShape >> trachelShapeFor: anElement [
	| trachelShape |
	trachelShape := self trachelShapeClass new.
	self updateFor: anElement trachelShape: trachelShape.
	^ trachelShape
]

{ #category : #hooks }
RTShape >> updateFor: edgeOrElement [
	self updateFor: edgeOrElement trachelShape: edgeOrElement trachelShape
]

{ #category : #hooks }
RTShape >> updateFor: edgeOrElement trachelShape: trachelShape [

	self subclassResponsibility
]
