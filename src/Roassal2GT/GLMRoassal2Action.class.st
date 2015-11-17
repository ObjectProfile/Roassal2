Class {
	#name : #GLMRoassal2Action,
	#superclass : #RTObject,
	#instVars : [
		'roassalPresentation'
	],
	#category : #'Roassal2GT-Glamour-Actions'
}

{ #category : #initialization }
GLMRoassal2Action class >> allLeafSubclasses [
	^ self allSubclasses select: #isLeaf
]

{ #category : #initialization }
GLMRoassal2Action class >> initializePresentation: aRoassal2Presentation [
	| instances orderedInstances |
	instances := self allLeafSubclasses collect: #new.
	orderedInstances := instances sortedAs: #order.
	orderedInstances
		do:
			[ :inst | 
			inst roassalPresentation: aRoassal2Presentation.
			inst icon notNil
				ifTrue:
					[ aRoassal2Presentation
						act: [ :r | inst execute ]
						icon: inst icon
						entitled: inst title ]
				ifFalse:
					[ aRoassal2Presentation
						act: [ :r | inst execute ]
						entitled: inst title ] ]
]

{ #category : #testing }
GLMRoassal2Action class >> isLeaf [
	^ self subclasses size = 0
]

{ #category : #hooks }
GLMRoassal2Action >> execute [
	"Override please"
	self subclassReponsibility
]

{ #category : #hooks }
GLMRoassal2Action >> icon [
	"Override please"
	^ nil
]

{ #category : #hooks }
GLMRoassal2Action >> order [
	^ 10
]

{ #category : #accessing }
GLMRoassal2Action >> roassalPresentation [
	^ roassalPresentation
]

{ #category : #accessing }
GLMRoassal2Action >> roassalPresentation: anObject [
	roassalPresentation := anObject
]

{ #category : #do }
GLMRoassal2Action >> roassalUpdate [
	self roassalView signalUpdate 
]

{ #category : #accessing }
GLMRoassal2Action >> roassalView [
	"Return the roassal view. Handy to be used in the actions"
	^ self roassalPresentation view view
]

{ #category : #hooks }
GLMRoassal2Action >> title [
	"Override please"
	^ 'Unamed'
]

{ #category : #accessing }
GLMRoassal2Action >> trachelCanvas [
	^ self roassalView canvas
]