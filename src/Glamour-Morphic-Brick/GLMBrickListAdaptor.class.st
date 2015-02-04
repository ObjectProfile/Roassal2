"
A GLMBrickListAdaptor is scriptable implementation of adaptor that is mostly used with list scroll brick

Instance Variables
	countLogic:		<Object>
	morphLogic:		<Object>
	origin:		<Object>

countLogic
	- xxxxx

morphLogic
	- xxxxx

origin
	- xxxxx

"
Class {
	#name : #GLMBrickListAdaptor,
	#superclass : #GLMBrickAbstractAdaptor,
	#instVars : [
		'origin',
		'countLogic',
		'morphLogic'
	],
	#category : #'Glamour-Morphic-Brick-Model'
}

{ #category : #'instance creation' }
GLMBrickListAdaptor class >> on: anObject [

	^ self new on: anObject
]

{ #category : #'adaptor api' }
GLMBrickListAdaptor >> count [

	^ countLogic
		ifNil: [ origin size ]
		ifNotNil: [ countLogic cull: origin ] 
]

{ #category : #'adaptor api' }
GLMBrickListAdaptor >> morphAt: anInteger convert: aMorph [

	^ morphLogic
		ifNil: [ (origin at: anInteger) asMorph ]
		ifNotNil: [
			morphLogic isSymbol
				ifTrue: [ origin perform: morphLogic withEnoughArguments: { anInteger . aMorph }  ]
				ifFalse: [ morphLogic cull: anInteger cull: aMorph ] ]
]

{ #category : #'instance creation' }
GLMBrickListAdaptor >> morphAtLogic: aBlockWithTwoParameters [

	morphLogic := aBlockWithTwoParameters
]

{ #category : #'instance creation' }
GLMBrickListAdaptor >> on: anObject [

	origin := anObject
]

{ #category : #accessing }
GLMBrickListAdaptor >> origin [

	^ origin
]

{ #category : #'instance creation' }
GLMBrickListAdaptor >> sizeLogic: aBlockWithNoParameters [

	countLogic := aBlockWithNoParameters
]
