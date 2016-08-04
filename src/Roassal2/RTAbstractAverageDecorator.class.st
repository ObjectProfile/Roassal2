Class {
	#name : #RTAbstractAverageDecorator,
	#superclass : #RTAbstractGrapherDecorator,
	#instVars : [
		'shouldHaveLabel',
		'lineColor',
		'shapes',
		'labelBlock'
	],
	#category : #'Roassal2-Builder-Grapher-Decorators'
}

{ #category : #initialization }
RTAbstractAverageDecorator >> initialize [
	super initialize.
	self noLabel.
	labelBlock := #yourself.
	shapes := OrderedCollection new
]

{ #category : #utility }
RTAbstractAverageDecorator >> label: aString on: position color: aColor [
	| e |
	e := super label: aString on: position color: aColor.
	shapes add: e.
	^ e
]

{ #category : #accessing }
RTAbstractAverageDecorator >> labelConvertion: aBlockOrSymbol [
	self
		deprecated: 'use #withLabel: instead (also #withLabel is implied when using #withLabel:)'.
	self withLabel: aBlockOrSymbol
]

{ #category : #configuration }
RTAbstractAverageDecorator >> lineColor: aColor [
	"Set the color of the line"
	shapeBuilder line color: aColor
]

{ #category : #utility }
RTAbstractAverageDecorator >> lineFrom: fromPoint to: toPoint [
	| l |
	l := super lineFrom: fromPoint to: toPoint.
	shapes
		add: l from;
		add: l to;
		add: l.
	^ l
]

{ #category : #configuration }
RTAbstractAverageDecorator >> noLabel [
	shouldHaveLabel := false
]

{ #category : #accessing }
RTAbstractAverageDecorator >> remove [
	[ shapes isNotEmpty ]
		whileTrue: [ shapes first view ifNotNil: [ shapes first remove ].
			shapes removeFirst ].
	builder view signalUpdate
]

{ #category : #'drawing-hooks' }
RTAbstractAverageDecorator >> render [
	self subclassResponsibility
]

{ #category : #configuration }
RTAbstractAverageDecorator >> withLabel [
	shouldHaveLabel := true
]

{ #category : #accessing }
RTAbstractAverageDecorator >> withLabel: aBlockOrSymbol [
	"This method is used to set how to convert the decorator's value.
	Take as argument the decorator's value, as a number and the block has to return a value or a string"

	self withLabel.
	labelBlock := aBlockOrSymbol
]
