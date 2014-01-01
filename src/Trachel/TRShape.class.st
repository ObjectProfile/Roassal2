Class {
	#name : #TRShape,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'color',
		'path',
		'strokePaint',
		'announcer',
		'element',
		'callbacks'
	],
	#category : #Trachel
}

{ #category : #actions }
TRShape >> addCallback: aCallback [
	callbacks ifNil: [ callbacks := OrderedCollection new ].
	callbacks add: aCallback
]

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
TRShape >> center [
	self subclassResponsibility
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

{ #category : #accessing }
TRShape >> encompassingRectangle [
	self subclassReponsibility
]

{ #category : #testing }
TRShape >> hasCallback [
	^ callbacks notNil
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
	
]

{ #category : #testing }
TRShape >> isFixed [

	^ self canvas fixedShapes includes: self
]

{ #category : #testing }
TRShape >> isMovable [

	^ self canvas isMovableShape: self
]

{ #category : #testing }
TRShape >> isNotFixed [

	^ self isMovable
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

{ #category : #actions }
TRShape >> resetPath [
	path := nil
]

{ #category : #actions }
TRShape >> setAsFixed [
	canvas removeShape: self.
	canvas addFixedShape: self.
]

{ #category : #actions }
TRShape >> setAsNotFixed [
	canvas removeFixedShape: self.
	canvas addShape: self.
]

{ #category : #testing }
TRShape >> shouldBeDrawn [
	^ true
]

{ #category : #actions }
TRShape >> signalUpdate [
	"Refresh the canvas"
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
	self subclassResponsibility
]

{ #category : #actions }
TRShape >> translateTo: aPoint [
	self subclassResponsibility
]
