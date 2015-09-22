"
A TRMorph is at the interface between Morphic and Trachel. 
"
Class {
	#name : #TRMorph,
	#superclass : #Morph,
	#instVars : [
		'trachelCanvas',
		'surface',
		'eventBeginingDragging',
		'shapeBeingPointed',
		'shouldRefresh',
		'session'
	],
	#category : #'Trachel-MorphSpecific'
}

{ #category : #'event handling' }
TRMorph >> announceToEventOverseer: evt [
	self eventOverseer ifNil: [ ^ self ].
	self eventOverseer firedEvent: evt 
]

{ #category : #accessing }
TRMorph >> canvas: aTrachelCanvas [
	trachelCanvas := aTrachelCanvas.
	surface := AthensCairoSurface extent: (aTrachelCanvas extent) asIntegerPoint
]

{ #category : #'session management' }
TRMorph >> checkSession [
	session == Smalltalk session
		ifFalse: [ 
			surface := nil.
			self createSurface ]
]

{ #category : #'session management' }
TRMorph >> createSurface [
	surface := AthensCairoSurface extent: self extent asIntegerPoint.
	session := Smalltalk session.
]

{ #category : #drawing }
TRMorph >> drawOn: aCanvas [
	"aCanvas is a FormCanvas"
	
	self checkSession.
	
	aCanvas fillRectangle: bounds color: trachelCanvas color.
	trachelCanvas playAnimations.
	
	"The drawing has to be done when a change in the shapes occured or when there is an animation."
	surface drawDuring: [:cs |
		surface clear.
		
		"We display the elements that are subject to the camera"
		cs pathTransform
			translateBy: (self extent / 2) asFloatPoint;
			    scaleBy: trachelCanvas camera scale asFloat;
			translateBy: trachelCanvas camera position negated asFloatPoint.
		trachelCanvas shapes do: [ :trachelShape |
			trachelShape drawOn: cs.
		].
	
		"We display the elements that are _NOT_ subject to the camera"
		cs pathTransform loadIdentity scaleBy: 1.001.
		trachelCanvas fixedShapes do: [ :trachelShape |
			trachelShape drawOn: cs.
		].
	].
	"aCanvas translucentImage: surface asForm at: self bounds origin."
	"asForm creates a new Form, which is likely to be expensive. This can be cached"
	aCanvas image: surface asForm at: self bounds origin sourceRect: (0 @ 0 extent: surface extent) rule: 34.
]

{ #category : #drawing }
TRMorph >> drawOnMockCanvas [
	"This method is used to trigger all the rendering in a temporary FormCanvas. This method is useful when a bug happens when rendering. Such situation are difficult to debug to the multi-threading and low level graphical primitive. The method #drawOnMockCanvas helps addressing this.

Here is an example:
v := RTView new.
es := RTBox elementsOn: (1 to: 10).
v addAll: es.
RTGridLayout on: es.
v canvas buildMorph drawOnMockCanvas

	"
	self drawOn: (FormCanvas extent: 500 @ 500)
]

{ #category : #accessing }
TRMorph >> eventOverseer [
	^ trachelCanvas eventOverseer
]

{ #category : #'events-processing' }
TRMorph >> handleKeystroke: anEvent [
	
	self rtKeyStroke: anEvent.
]

{ #category : #'events-processing' }
TRMorph >> handleMouseMove: anEvent [
	super handleMouseMove: anEvent.
	self rtMouseMoving: anEvent.
]

{ #category : #'events-processing' }
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
			event canvas: trachelCanvas.
			event position: (self relativePositionFor: anEvent).
			event shape: shapeBeingPointed.

			shapeBeingPointed announce: event.
			shapeBeingPointed := currentElement.
			self rtMouseEnter: anEvent ].

]

{ #category : #'events-processing' }
TRMorph >> handlesKeyboard: evt [

	^true
]

{ #category : #'event handling' }
TRMorph >> handlesMouseDown: anEvent [
	anEvent wasHandled ifTrue:[ ^ false ]. "not interested"

	^ true
]

{ #category : #morphic }
TRMorph >> handlesMouseOver: evt [
	^ true
]

{ #category : #'events-processing' }
TRMorph >> handlesMouseWheel: evt [
	"Do I want to receive mouseWheel events?." 

	^true
]

{ #category : #initialization }
TRMorph >> initialize [
	super initialize.
	self createSurface.
	shouldRefresh := false.
	session := Smalltalk session.
]

{ #category : #testing }
TRMorph >> isDragging [
	^ eventBeginingDragging notNil
]

{ #category : #morphic }
TRMorph >> layoutChanged [ 
	"react on morph resize"
	super layoutChanged.
	self checkSession.
	surface ifNotNil: [  
		self extent asIntegerPoint ~= surface extent ifTrue: [ 
			self createSurface.
			trachelCanvas extent: self extent ]
	].
	
]

{ #category : #'event handling' }
TRMorph >> mouseDown: evt [

	eventBeginingDragging ifNil: [
		evt hand 
					waitForClicksOrDrag: self 
					event: evt 
					selectors: { #rtMouseClick:. #rtMouseDoubleClick:. nil. #rtMouseDragBegin: }
					threshold: 5.
		^ self ].
	
	evt anyButtonPressed ifTrue: [
		self rtMouseDragging: evt.
	].
	evt wasHandled: true.
	^ true
]

{ #category : #'event handling' }
TRMorph >> mouseEnter: evt [
	evt anyButtonPressed ifFalse: [
		self rtMouseEnter: evt.
	].
	evt wasHandled: true.
	^ true
]

{ #category : #'event handling' }
TRMorph >> mouseLeave: evt [
	
	evt anyButtonPressed ifFalse: [
		self rtMouseLeave: evt.
	].
	evt wasHandled: true.
	^ true
]

{ #category : #'event handling' }
TRMorph >> mouseMove: evt [
	
	evt anyButtonPressed
		ifTrue: [ self rtMouseDragging: evt ] 
		ifFalse: [ self rtMouseMoving: evt ].
	evt wasHandled: true.
	^ true
]

{ #category : #'event handling' }
TRMorph >> mouseUp: evt [
	self isDragging ifTrue: 
		[self rtMouseDragEnd: evt ].
	evt wasHandled: true.
]

{ #category : #'event handling' }
TRMorph >> mouseWheel: evt [

	self rtMouseWheel: evt.
	evt wasHandled: true.
	^ true
]

{ #category : #'events-roassal' }
TRMorph >> relativePositionFor: evt [
	"Return the position within the window"
	^ evt position - self bounds origin
	"^ trachelCanvas camera fromPixelToSpace: (evt position - self bounds origin) "
]

{ #category : #'event-processed' }
TRMorph >> rtKeyStroke: evt [
	| relativePosition ev  shape |
	
	(evt commandKeyPressed and: [ evt keyCharacter = $w ]) ifTrue: [ self owner delete ].
	relativePosition := self relativePositionFor: evt.
	
	ev := TRKeyDown new 
				keyValue: evt keyValue;
				keyCombination: evt asKeyCombination;
				yourself.
	shape := self shapeWithAction: TRKeyDown forPositionInPixels: relativePosition.

	ev shape: shape.
	ev morph: self.
	ev canvas: trachelCanvas.
	ev position: (trachelCanvas camera fromPixelToSpace: relativePosition).

	shape announce: ev.

]

{ #category : #'event-processed' }
TRMorph >> rtMouseClick: evt [
	| relativePosition ev  shape |
	relativePosition := self relativePositionFor: evt.	
	evt yellowButtonChanged
		ifTrue: [ ev := TRMouseRightClick new ].
	evt redButtonChanged
		ifTrue: [ ev := TRMouseLeftClick new ].
	evt blueButtonChanged
		ifTrue: [ ev := TRMouseClick new ].

	shape := self shapeWithAction: TRMouseClick forPositionInPixels: relativePosition.
	ev commandKeyPressed: evt commandKeyPressed.
	ev controlKeyPressed: evt controlKeyPressed.
	ev shiftKeyPressed: evt shiftPressed.
	ev shape: shape.
	ev morph: self.
	ev canvas: trachelCanvas.
	ev position: (trachelCanvas camera fromPixelToSpace: relativePosition).
	shape announce: ev.
	self announceToEventOverseer: ev
]

{ #category : #'event-processed' }
TRMorph >> rtMouseDoubleClick: evt [
	| relativePosition ev  shape |
	relativePosition := self relativePositionFor: evt.	
	evt yellowButtonChanged
		ifTrue: [ ev := TRMouseDoubleRightClick new ].
	evt redButtonChanged
		ifTrue: [ ev := TRMouseDoubleLeftClick new ].
	evt blueButtonChanged
		ifTrue: [ ev := TRMouseDoubleClick new ].

	shape := self shapeWithAction: TRMouseDoubleClick forPositionInPixels: relativePosition.
	ev commandKeyPressed: evt commandKeyPressed.
	ev controlKeyPressed: evt controlKeyPressed.
	ev shiftKeyPressed: evt shiftPressed.
	ev shape: shape.
	ev morph: self.
	ev canvas: trachelCanvas.
	ev position: (trachelCanvas camera fromPixelToSpace: relativePosition).
	shape announce: ev.
	self announceToEventOverseer: ev
	
]

{ #category : #'event-processed' }
TRMorph >> rtMouseDragBegin: evt [
	| relativePosition ee |
	eventBeginingDragging := evt copy.
	relativePosition := self relativePositionFor: evt.
	shapeBeingPointed := self shapeWithAction: TRMouseDragging forPositionInPixels: relativePosition.

	evt yellowButtonChanged
		ifTrue: [ ee := TRMouseRightDragStart new ].
	evt redButtonChanged
		ifTrue: [ ee := TRMouseLeftDragStart new ].
	evt blueButtonChanged
		ifTrue: [ ee := TRMouseDragStart new ].
		
	ee shape: shapeBeingPointed.
	ee position: relativePosition.
	ee canvas: trachelCanvas.
	ee morph: self.
	shapeBeingPointed announce: ee.
	self announceToEventOverseer: ee
]

{ #category : #'event-processed' }
TRMorph >> rtMouseDragEnd: evt [

	| ee relativePosition |
	relativePosition := self relativePositionFor: evt.
	ee := TRMouseDragEnd new.
	ee shape: shapeBeingPointed.
	ee canvas: trachelCanvas.
	ee morph: self.
	ee position: relativePosition.
	shapeBeingPointed announce: ee.
	self announceToEventOverseer: ee.
	
	eventBeginingDragging := nil.
	shapeBeingPointed := nil
]

{ #category : #'event-processed' }
TRMorph >> rtMouseDragging: evt [
	| step relativePosition event  |
	eventBeginingDragging ifNil: [ ^ self ].
	relativePosition := self relativePositionFor: evt.
	step := evt position - eventBeginingDragging position.

	shapeBeingPointed ifNil: [  
			shapeBeingPointed := self shapeWithAction: TRMouseDragging forPositionInPixels: relativePosition ].
	
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
	event canvas: trachelCanvas.
	event morph: self.
	shapeBeingPointed announce: event.
	self announceToEventOverseer: event.
	eventBeginingDragging := evt copy.
]

{ #category : #'event-processed' }
TRMorph >> rtMouseEnter: evt [
	| relativePosition ev shape |
	
	relativePosition := self relativePositionFor: evt.

	shape := self shapeWithAction: TRMouseEnter forPositionInPixels: relativePosition.

	ev := TRMouseEnter new.
	ev position: relativePosition.
	ev shape: shape.
	ev morph: self.
	ev canvas: trachelCanvas.
	shape announce: ev.
	self announceToEventOverseer: ev

]

{ #category : #'event-processed' }
TRMorph >> rtMouseLeave: evt [
	| position ev shape |
	
	position := self relativePositionFor: evt.
	shape := self shapeWithAction: TRMouseLeave forPositionInPixels: position.
	ev := TRMouseLeave new.
	ev position: position.
	ev shape: shape.
	ev morph: self.
	ev canvas: trachelCanvas.
	shape announce: ev.
	self announceToEventOverseer: ev

]

{ #category : #'event-processed' }
TRMorph >> rtMouseMoving: evt [

	| relativePosition ev shape |
	relativePosition := self relativePositionFor: evt.	
	shape := self shapeWithAction: TRMouseMove forPositionInPixels: relativePosition.

	ev := TRMouseMove new.
	ev position: relativePosition.
	ev shape: shape.
	ev morph: self.
	ev canvas: trachelCanvas.
	shape announce: ev.
	self announceToEventOverseer: ev
]

{ #category : #'event-processed' }
TRMorph >> rtMouseWheel: evt [
	trachelCanvas
		announce:
			(TRMouseWheelEvent
				fromDirection: evt direction
				position: (trachelCanvas camera fromPixelToSpace: (self relativePositionFor: evt)))
]

{ #category : #'event-processed' }
TRMorph >> shapeForEvent: anEvent [	
	^ self shapeWithActionForPositionInPixels: (self relativePositionFor: anEvent)
]

{ #category : #accessing }
TRMorph >> shapeForPositionInPixels: point [
	"Return the shape located that contains point"
	 ^ trachelCanvas shapeForPositionInPixels: point
]

{ #category : #accessing }
TRMorph >> shapeWithAction: eventClass forPositionInPixels: position [
	"Return the shape with event handler located that contains point"
	 ^ trachelCanvas shapeWithAction: eventClass forPositionInPixels: position
]

{ #category : #accessing }
TRMorph >> shapeWithActionForPositionInPixels: point [
	"Return the shape with event handler located that contains point"
	 ^ trachelCanvas shapeWithActionForPositionInPixels: point
]

{ #category : #signalling }
TRMorph >> signalUpdate [
	self changed
]

{ #category : #stepping }
TRMorph >> step [
	self wantsSteps ifFalse: [ ^ self ].
	self changed
]

{ #category : #stepping }
TRMorph >> stepTime [
	"Answer the desired time between steps in milliseconds. This default implementation requests that the 'step' method be called once every second."

	^ 20
]

{ #category : #accessing }
TRMorph >> surface [
	^ surface
]

{ #category : #'events-processing' }
TRMorph >> takesKeyboardFocus [
	"Answer whether the receiver can normally take keyboard focus."

	^ true
]

{ #category : #accessing }
TRMorph >> trachelCanvas [
	^ trachelCanvas
]

{ #category : #testing }
TRMorph >> wantsSteps [
	^ trachelCanvas hasAnimation 
]
