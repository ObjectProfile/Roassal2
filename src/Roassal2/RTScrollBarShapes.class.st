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

{ #category : #accessing }
RTScrollBarShapes >> bar [
	^ bar
]

{ #category : #accessing }
RTScrollBarShapes >> bar: aTRShape [
	bar := aTRShape. 
	collection add: aTRShape.
]

{ #category : #accessing }
RTScrollBarShapes >> collection [
	^ collection
]

{ #category : #initialization }
RTScrollBarShapes >> initialize [
	super initialize.
	collection := OrderedCollection new.
]

{ #category : #accessing }
RTScrollBarShapes >> margeRectangle [
	^ margeRectangle
]

{ #category : #accessing }
RTScrollBarShapes >> margeRectangle: aTRShape [
	margeRectangle := aTRShape.
	collection add: aTRShape. 
]

{ #category : #accessing }
RTScrollBarShapes >> start [
	^ start
]

{ #category : #accessing }
RTScrollBarShapes >> start: aTRShape [
	start := aTRShape.
	collection add: aTRShape.
]

{ #category : #accessing }
RTScrollBarShapes >> stop [
	^ stop
]

{ #category : #accessing }
RTScrollBarShapes >> stop: aTRShape [
	stop := aTRShape.
	collection add: aTRShape.
]

{ #category : #accessing }
RTScrollBarShapes >> surroundingRectangle [
	^ surroundingRectangle 
]

{ #category : #accessing }
RTScrollBarShapes >> surroundingRectangle: aTRShape [
	surroundingRectangle := aTRShape.
	collection add: aTRShape. 
]
