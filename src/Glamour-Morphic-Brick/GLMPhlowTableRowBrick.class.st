Class {
	#name : #GLMPhlowTableRowBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'#entity => GLMPhlowSlot',
		'#table => GLMPhlowSlot'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #adding }
GLMPhlowTableRowBrick >> addColumn: aColumn [
	|brick|
	brick := (aColumn computation phlowValue: self entity) asBrick.
	brick := aColumn style phlowValue: brick.
	^ self addBrickBack: brick
]

{ #category : #phlow }
GLMPhlowTableRowBrick >> entity [

	^ entity
]

{ #category : #phlow }
GLMPhlowTableRowBrick >> entity: anObject [
	
	entity := anObject.
	self initializeColumns.
]

{ #category : #acessing }
GLMPhlowTableRowBrick >> in: aTableBrick [

	table := aTableBrick.
	self initializeColumns.
]

{ #category : #initialization }
GLMPhlowTableRowBrick >> initialize [
	super initialize.
	
	"My height is the height of the tallest subbrick"
	self layout vShrinkWrap
]

{ #category : #initialization }
GLMPhlowTableRowBrick >> initializeColumns [
	"you can initialize only if entity and table both not nil"
	self removeAllBricks.
	(self entity isNil | self table isNil) ifTrue: [ ^ self ].
	self table columns do: [ :each | self addColumn: each ].
	self updateWidthPercentage
]

{ #category : #acessing }
GLMPhlowTableRowBrick >> table [

	^ table
]

{ #category : #updating }
GLMPhlowTableRowBrick >> updateWidthPercentage [
	
	self subbricks ifEmpty: [ ^ self ].
	self subbricks do: [ :each | each layoutProperties horizontalPercent: (100 / self subbricksCount) ]
]
