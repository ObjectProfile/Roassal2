Class {
	#name : #TRMorph,
	#superclass : #Morph,
	#instVars : [
		'trachelCanvas',
		'surface',
		'eventBeginingDragging',
		'shapeBeingPointed'
	],
	#category : #Trachel
}

{ #category : #'as yet unclassified' }
TRMorph >> canvas: aTrachelCanvas [
	trachelCanvas := aTrachelCanvas.
	surface := AthensCairoSurface extent: aTrachelCanvas extent
]

{ #category : #'as yet unclassified' }
TRMorph >> createSurface [
	surface := AthensCairoSurface extent: self extent asIntegerPoint
]

{ #category : #'as yet unclassified' }
TRMorph >> drawOn: aCanvas [
	"aCanvas is a form canvas"

	aCanvas fillRectangle: bounds color: Color lightGray.
	
	trachelCanvas playAnimations.
	
	"The drawing has to be done when a change in the shapes occured or when there is an animation."
	surface drawDuring: [:cs |
		surface clear.		
		"cs pathTransform 
			scaleBy: 1.0."
		trachelCanvas shapes do: [ :trachelShape |
			trachelShape drawOn: cs.
		]
	].
	"aCanvas translucentImage: surface asForm at: self bounds origin."
	"asForm creates a new Form, which is likely to be expensive. This can be cached"
	aCanvas image: surface asForm at: self bounds origin sourceRect: (0 @ 0 extent: surface extent) rule: 34
]

{ #category : #'as yet unclassified' }
TRMorph >> handleMouseMove: anEvent [
	super handleMouseMove: anEvent.
	self rtMouseMoving: anEvent.
]

{ #category : #'as yet unclassified' }
TRMorph >> handleMouseOver: anEvent [

	| currentElement event |
	anEvent wasHandled ifTrue:[ ^ self ]. "not interested"
	"Do nothing if we are dragging"
	self isDragging ifTrue: [ ^ self ].
	 
	shapeBeingPointed ifNil: [ shapeBeingPointed := self shapeForEvent: anEvent ].
	
	currentElement := self shapeForEvent: anEvent.
	(currentElement ~~ shapeBeingPointed)
		ifTrue: [ 
			event := TRMouseLeave new.
			event morph: self.
			event position: (self relativePositionFor: anEvent).
			event shape: shapeBeingPointed.

			shapeBeingPointed announce: event.
			shapeBeingPointed := currentElement.
			self rtMouseEnter: anEvent ].

]

{ #category : #'as yet unclassified' }
TRMorph >> handlesMouseDown: anEvent [
	anEvent wasHandled ifTrue:[ ^ false ]. "not interested"

	^ true
]

{ #category : #'as yet unclassified' }
TRMorph >> handlesMouseOver: evt [
	^ true
]

{ #category : #'as yet unclassified' }
TRMorph >> initialize [
	super initialize.
	self createSurface
	"session := Smalltalk session."
]

{ #category : #'as yet unclassified' }
TRMorph >> isDragging [
	^ eventBeginingDragging notNil
]

{ #category : #'as yet unclassified' }
TRMorph >> layoutChanged [ 
	"react on morph resize"
	super layoutChanged.
	surface ifNotNil: [  
		self extent asIntegerPoint ~= surface extent ifTrue: [ 
			self createSurface ]
	].
	
]

{ #category : #'as yet unclassified' }
TRMorph >> mouseDown: evt [

	eventBeginingDragging ifNil: [
		evt hand 
					waitForClicksOrDrag: self 
					event: evt 
					selectors: { #rtMouseClick:. nil. nil. #rtMouseDragBegin: }
					threshold: 5.
		^ self ].
	
	evt anyButtonPressed ifTrue: [
		self rtMouseDragging: evt.
	].
	evt wasHandled: true.
	^ true
]

{ #category : #'as yet unclassified' }
TRMorph >> mouseEnter: evt [
	evt anyButtonPressed ifFalse: [
		self rtMouseEnter: evt.
	].
	evt wasHandled: true.
	^ true
]

{ #category : #'as yet unclassified' }
TRMorph >> mouseLeave: evt [
	
	evt anyButtonPressed ifFalse: [
		self rtMouseLeave: evt.
	].
	evt wasHandled: true.
	^ true
]

{ #category : #'as yet unclassified' }
TRMorph >> mouseMove: evt [
	
	evt anyButtonPressed
		ifTrue: [ self rtMouseDragging: evt ] 
		ifFalse: [ self rtMouseMoving: evt ].
	evt wasHandled: true.
	^ true
]

{ #category : #'as yet unclassified' }
TRMorph >> mouseUp: evt [
	self isDragging ifTrue: 
		[self rtMouseDragEnd: evt ].
	evt wasHandled: true.
]

{ #category : #'as yet unclassified' }
TRMorph >> relativePositionFor: evt [
	"Return the position within the window"
	
	^ evt position - self bounds origin
]

{ #category : #'as yet unclassified' }
TRMorph >> rtMouseDragBegin: evt [
	| relativePosition |
	eventBeginingDragging := evt copy.
	
	relativePosition := self relativePositionFor: evt.
	shapeBeingPointed := self shapeForPosition: relativePosition
]

{ #category : #'as yet unclassified' }
TRMorph >> rtMouseDragEnd: evt [
	eventBeginingDragging := nil.
	shapeBeingPointed := nil
]

{ #category : #'as yet unclassified' }
TRMorph >> rtMouseDragging: evt [
	| step relativePosition event  |
	eventBeginingDragging ifNil: [ ^ self ].
	relativePosition := self relativePositionFor: evt.
	step := evt position - eventBeginingDragging position.

	shapeBeingPointed ifNil: 
		[ shapeBeingPointed := self shapeForPosition: relativePosition ].
	
	event := TRMouseDragging new 
				morph: self;
				shape: shapeBeingPointed;
				step: step; 
				yourself.

"	event commandKeyPressed: evt commandKeyPressed.
	event controlKeyPressed: evt controlKeyPressed.
	event shiftKeyPressed: evt shiftPressed.				
"
	event position: relativePosition.
	shapeBeingPointed announce: event.

	eventBeginingDragging := evt copy.
]

{ #category : #'as yet unclassified' }
TRMorph >> rtMouseEnter: evt [
	| relativePosition ev shape |
	
	relativePosition := self relativePositionFor: evt.

	shape := self shapeForPosition: relativePosition.
	ev := TRMouseEnter new.
	ev position: relativePosition.
	ev shape: shape.
	ev morph: self.
	shape announce: ev.

]

{ #category : #'as yet unclassified' }
TRMorph >> rtMouseLeave: evt [
	| position ev shape |
	
	position := self relativePositionFor: evt.
	shape := self shapeForPosition: position.
Transcript show: shape printString; cr.
	ev := TRMouseLeave new.
	ev position: position.
	ev shape: shape.
	ev morph: self.
	shape announce: ev

]

{ #category : #'as yet unclassified' }
TRMorph >> rtMouseMoving: evt [

	| relativePosition ev shape |
	relativePosition := self relativePositionFor: evt.	
	shape := self shapeForPosition: relativePosition.

	ev := TRMouseMove new.
	ev position: relativePosition.
	ev shape: shape.
	ev morph: self.
	(self shapeForPosition: relativePosition) announce: ev
]

{ #category : #'as yet unclassified' }
TRMorph >> shapeForEvent: anEvent [	
	^ self shapeForPosition: (self relativePositionFor: anEvent)
]

{ #category : #'as yet unclassified' }
TRMorph >> shapeForPosition: point [
	"Return the shape located that contains point"
	 ^ trachelCanvas shapeForPosition: point
]

{ #category : #'as yet unclassified' }
TRMorph >> step [
	self changed
]

{ #category : #'as yet unclassified' }
TRMorph >> stepTime [
	"Answer the desired time between steps in milliseconds. This default implementation requests that the 'step' method be called once every second."

	^ 20
]

{ #category : #'as yet unclassified' }
TRMorph >> wantsSteps [
	^ trachelCanvas hasAnimation 
]
