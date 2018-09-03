Class {
	#name : #GLMPhlowListBrick,
	#superclass : #GLMPhlowBrick,
	#instVars : [
		'#scrollList => GLMPhlowSlot'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #examples }
GLMPhlowListBrick class >> example [
	
	^ GLMCompositeBrick exampleList
]

{ #category : #examples }
GLMPhlowListBrick class >> example2 [
	
	^ GLMCompositeBrick exampleListWithCustomItem
]

{ #category : #phlow }
GLMPhlowListBrick >> display: anObject [
	
	self listBrick adaptor
		morphAtLogic: [ :index :morph | self styledLogic phlowValue: (self formatLogic phlowValue: (anObject phlowValue: (self entity at: index))) asBrick ]
]

{ #category : #phlow }
GLMPhlowListBrick >> entity: anObject [
	super entity: anObject.
	
	self listBrick adaptor on: anObject
]

{ #category : #phlow }
GLMPhlowListBrick >> format: anObject [

	self setProperty: #phlowFormat toValue: anObject
]

{ #category : #accessing }
GLMPhlowListBrick >> formatLogic [

	^ self valueOfProperty: #phlowFormat ifAbsent: [ #yourself ]
]

{ #category : #initialization }
GLMPhlowListBrick >> initialize [
	super initialize.
		
	self listBrick: self newScrollList
]

{ #category : #accessing }
GLMPhlowListBrick >> listBrick [

	^ scrollList
]

{ #category : #accessing }
GLMPhlowListBrick >> listBrick: aBrick [

	scrollList := aBrick.
	
	self listBrick adaptor: GLMBrickListAdaptor new.
	self listBrick layoutProperties vSpaceFill.
	self addBrickBack: self listBrick
]

{ #category : #'instance creation' }
GLMPhlowListBrick >> newScrollList [

	^ GLMScrollListBrick new
]

{ #category : #phlow }
GLMPhlowListBrick >> styled: anObject [
	
	self setProperty: #phlowStyled toValue: anObject
]

{ #category : #accessing }
GLMPhlowListBrick >> styledLogic [
	
	^ self valueOfProperty: #phlowStyled ifAbsent: [ #yourself ]
]
