Class {
	#name : #RTShapedObject,
	#superclass : #RTObject,
	#instVars : [
		'shape',
		'announcer',
		'trachelShape'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTShapedObject >> @ anInteractionClassOrInstance [
	"Add an interaction to the node"
	
	self addInteraction: anInteractionClassOrInstance
]

{ #category : #'as yet unclassified' }
RTShapedObject >> addInteraction: anInteractionClassOrInstance [
 	anInteractionClassOrInstance initializeElement: self
]

{ #category : #'as yet unclassified' }
RTShapedObject >> announce: evt [
	self announcer announce: evt
]

{ #category : #'as yet unclassified' }
RTShapedObject >> announcer [
	announcer ifNil: [ announcer := Announcer new ].
	^ announcer
]

{ #category : #'as yet unclassified' }
RTShapedObject >> initialize [
	super initialize.
	shape := RTNull new
]

{ #category : #'as yet unclassified' }
RTShapedObject >> on: evt do: aBlock [
	self announcer on: evt do: aBlock
]

{ #category : #'as yet unclassified' }
RTShapedObject >> renderOn: trachelCanvas [

	trachelShape := shape renderOn: trachelCanvas for: self.
	trachelShape announcer: self announcer.
	trachelShape element: self
]

{ #category : #'as yet unclassified' }
RTShapedObject >> shape [
	^ shape
]

{ #category : #'as yet unclassified' }
RTShapedObject >> trachelShape [
	^ trachelShape
]

{ #category : #'as yet unclassified' }
RTShapedObject >> update [
	"Update the path of the trachel shape. This has the effect of moving the visual widget"
	shape updateFor: self

]
