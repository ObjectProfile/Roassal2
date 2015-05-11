Class {
	#name : #RTScrollBarShapes,
	#superclass : #RTObject,
	#instVars : [
		'start',
		'stop',
		'margeRectangle',
		'bar',
		'surroundingRectangle',
		'collection'
	],
	#category : #'Roassal2-Builder-ScrollBar'
}

{ #category : #'as yet unclassified' }
RTScrollBarShapes >> bar [
	^ bar
]

{ #category : #'as yet unclassified' }
RTScrollBarShapes >> bar: aTRShape [
	bar := aTRShape. 
	collection add: aTRShape.
]

{ #category : #'as yet unclassified' }
RTScrollBarShapes >> collection [
	^ collection
]

{ #category : #'as yet unclassified' }
RTScrollBarShapes >> initialize [
	super initialize.
	collection := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
RTScrollBarShapes >> margeRectangle [
	^ margeRectangle
]

{ #category : #'as yet unclassified' }
RTScrollBarShapes >> margeRectangle: aTRShape [
	margeRectangle := aTRShape.
	collection add: aTRShape. 
]

{ #category : #'as yet unclassified' }
RTScrollBarShapes >> start [
	^ start
]

{ #category : #'as yet unclassified' }
RTScrollBarShapes >> start: aTRShape [
	start := aTRShape.
	collection add: aTRShape.
]

{ #category : #'as yet unclassified' }
RTScrollBarShapes >> stop [
	^ stop
]

{ #category : #'as yet unclassified' }
RTScrollBarShapes >> stop: aTRShape [
	stop := aTRShape.
	collection add: aTRShape.
]

{ #category : #'as yet unclassified' }
RTScrollBarShapes >> surroundingRectangle [
	^ surroundingRectangle 
]

{ #category : #'as yet unclassified' }
RTScrollBarShapes >> surroundingRectangle: aTRShape [
	surroundingRectangle := aTRShape.
	collection add: aTRShape. 
]
