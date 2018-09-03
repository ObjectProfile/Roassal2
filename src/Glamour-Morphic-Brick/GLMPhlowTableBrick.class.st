Class {
	#name : #GLMPhlowTableBrick,
	#superclass : #GLMPhlowListBrick,
	#instVars : [
		'#transformedEntity => GLMPhlowSlot',
		'#columns => GLMPhlowSlot'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #examples }
GLMPhlowTableBrick class >> example [
	
	^ GLMCompositeBrick exampleTable
]

{ #category : #accessing }
GLMPhlowTableBrick >> addColumn: aColumn [

	self columns add: aColumn
]

{ #category : #phlow }
GLMPhlowTableBrick >> column: anObject evaluated: otherObject [

	self column: anObject evaluated: otherObject styled: nil
]

{ #category : #phlow }
GLMPhlowTableBrick >> column: anObject evaluated: otherObject styled: anotherObject [

	self addColumn: (GLMPhlowTableColumn new 
		title: anObject;
		computation: otherObject;
		style: anotherObject)
]

{ #category : #accessing }
GLMPhlowTableBrick >> columns [

	^ columns ifNil: [ columns := OrderedCollection new ]
]

{ #category : #phlow }
GLMPhlowTableBrick >> display: anObject [
	
	self setProperty: #phlowDisplay toValue: anObject
	
]

{ #category : #accessing }
GLMPhlowTableBrick >> displayLogic [

	^ self valueOfProperty: #phlowDisplay ifAbsent: [ #yourself ]
]

{ #category : #phlow }
GLMPhlowTableBrick >> entity: anObject [
	super entity: anObject.
	
	self transformedEntity: (self displayLogic phlowValue: anObject).
	self listBrick adaptor on: self transformedEntity
]

{ #category : #initialization }
GLMPhlowTableBrick >> initialize [
	super initialize.

	self listBrick adaptor
		morphAtLogic: [ :index | GLMPhlowTableRowBrick new in: self; entity: (self transformedEntity at: index) ]
]

{ #category : #accessing }
GLMPhlowTableBrick >> transformedEntity [

	^ transformedEntity
]

{ #category : #accessing }
GLMPhlowTableBrick >> transformedEntity: anObject [

	transformedEntity := anObject
]
