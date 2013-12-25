Class {
	#name : #TRShape,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'color',
		'path',
		'strokePaint',
		'position',
		'announcer',
		'element'
	],
	#category : #Trachel
}

{ #category : #events }
TRShape >> announce: anEvent [
	self announcer announce: anEvent
]

{ #category : #events }
TRShape >> announcer [
	announcer isNil ifTrue: [ announcer := Announcer new ].
	^ announcer
]

{ #category : #events }
TRShape >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #accessing }
TRShape >> athensCanvas [
	^ self canvas athensCanvas
]

{ #category : #accessing }
TRShape >> canvas [
	"Return a Trachel Canvas"
	^ canvas
]

{ #category : #accessing }
TRShape >> canvas: aSurface [
	"aCanvas is a AthensCairoSurface"
	canvas := aSurface
]

{ #category : #accessing }
TRShape >> color [
	
	^ color
]

{ #category : #accessing }
TRShape >> color: aColor [
	
	color := aColor
]

{ #category : #hooks }
TRShape >> computePath [
	self subclassResponsibility
]

{ #category : #drawing }
TRShape >> drawOn: athensCanvas [

	athensCanvas pathTransform restoreAfter: [
		athensCanvas pathTransform 
			translateBy: position.

		athensCanvas
			setPaint: color;
			drawShape: self path.
			
		athensCanvas
			setStrokePaint: strokePaint;
			drawShape: self path  ]
]

{ #category : #accessing }
TRShape >> element [
	"A shape has a reference to an object, typically the object odel that the trachel shape represents"
	^ element 
]

{ #category : #accessing }
TRShape >> element: anObject [
	"anObject could be any kind of object. A shape has a reference to an object, typically the object odel that the trachel shape represents"
	element := anObject
]

{ #category : #testing }
TRShape >> includesPoint: aPoint [
	^ false
]

{ #category : #initialization }
TRShape >> initialize [
	super initialize.
	color := Color gray.
	strokePaint := Color black.	
	position := 0 @ 0
]

{ #category : #events }
TRShape >> on: event do: aBlock [
	self announcer on: event do: aBlock
]

{ #category : #accessing }
TRShape >> path [
	path ifNil: [ self computePath ].
	^ path
]

{ #category : #'as yet unclassified' }
TRShape >> resetPath [
	path := nil
]

{ #category : #actions }
TRShape >> signalUpdate [
	canvas signalUpdate
]

{ #category : #accessing }
TRShape >> strokePaint [
	"Return the color of the border line"
	^ strokePaint
]

{ #category : #accessing }
TRShape >> strokePaint: aColor [
	"set the color of the border line"
	strokePaint := aColor
]

{ #category : #actions }
TRShape >> translateBy: aPoint [
	"We should not have this..."
	self translateTo: (position + aPoint)
]

{ #category : #actions }
TRShape >> translateTo: aPoint [
	position := aPoint
]
