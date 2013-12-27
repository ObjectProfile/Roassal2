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
RTShapedObject >> + aRTShape [

	self addShape: aRTShape
]

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
RTShapedObject >> addShape: aRTShape [

	"I am not sure we need to have aRTShape here. It should instead be a trachel shape"
	shape := aRTShape instance.
	trachelShape := shape trachelShapeFor: self.
"	width := width max: (shape widthFor: self).
	height := height max: (shape heightFor: self).
"	
	
]

{ #category : #'as yet unclassified' }
RTShapedObject >> addedIn: view [
	self subclassReponsibility
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

	"trachelShape := shape renderOn: trachelCanvas for: self."
	trachelCanvas addShape: trachelShape.
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
	"Update the trachel shape and reset the path. This has the effect of moving the visual widget"
	shape updateFor: self.
	trachelShape ifNotNil: [ trachelShape resetPath ]

]
