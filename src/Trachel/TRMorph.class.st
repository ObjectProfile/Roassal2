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
		'session',
		'isDrawing'
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
	
	| f |
	"#drawOn: cannot be reintrant"
	isDrawing ifTrue: [ ^ self ].
	isDrawing := true. 
	self checkSession.

	self recreateSurfaceIfNecessary.
		
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
	surface hasBeenFreed ifTrue: [ self createSurface ].
	f := surface asForm.
"
	aCanvas image: f at: self bounds origin sourceRect: (0 @ 0 extent: surface extent) rule: 34.
"
	"surface displayOnMorphicCanvas: aCanvas at: self position."
	[ aCanvas image: f at: self bounds origin sourceRect: (0 @ 0 extent: surface extent) rule: 34 ]
		on: PrimitiveFailed
		do: [ "Maybe just memory object pinning issue so skipping a single paint cycle" ].

	isDrawing := false.
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
	self drawOn: (FormCanvas extent: self extent)
]

{ #category : #'event-processed' }
TRMorph >> eventOfClass: anEventClass actionClass: anActionClass from: aMorphicEvent [
	| relativePosition trEvent shape |
	relativePosition := self relativePositionFor: aMorphicEvent.
	shape := self shapeWithAction: anActionClass forPositionInPixels: relativePosition.

	trEvent := anEventClass fromEvent: aMorphicEvent.
	trEvent
		morph: self;
		canvas: trachelCanvas;
		shape: shape;
		position: relativePosition.
	^ trEvent
]

{ #category : #'event-processed' }
TRMorph >> eventOfClass: anEventClass from: aMorphicEvent [
	^ self eventOfClass: anEventClass actionClass: anEventClass from: aMorphicEvent
]

{ #category : #accessing }
TRMorph >> eventOverseer [
	^ trachelCanvas eventOverseer
]

{ #category : #'event handling' }
TRMorph >> handleKeystroke: anEvent [
	
	self trKeyDown: anEvent.
]

{ #category : #'events-processing' }
TRMorph >> handleMouseMove: anEvent [
	super handleMouseMove: anEvent.
	self trMouseMove: anEvent
]

{ #category : #'events-processing' }
TRMorph >> handleMouseOver: aMorphicEvent [
	| currentElement trEvent |
	super handleMouseOver: aMorphicEvent.
	aMorphicEvent wasHandled
		ifTrue: [ ^ self ].	"Do nothing if it was already handled"
	self isDragging
		ifTrue: [ ^ self ].	"Do nothing if we are dragging"
	shapeBeingPointed ifNil: [ shapeBeingPointed := self shapeForEvent: aMorphicEvent ].
	currentElement := self shapeForEvent: aMorphicEvent.
	currentElement == shapeBeingPointed
		ifTrue: [ ^ self ].
	trEvent := self eventOfClass: TRMouseLeave from: aMorphicEvent.
	trEvent shape: shapeBeingPointed.
	shapeBeingPointed announce: trEvent.
	shapeBeingPointed := currentElement.
	self trMouseEnter: aMorphicEvent
]

{ #category : #'event handling' }
TRMorph >> handlesKeyboard: evt [

	^true
]

{ #category : #'event handling' }
TRMorph >> handlesMouseDown: anEvent [
	^ anEvent wasHandled not	"not interested if handled"
]

{ #category : #'event handling' }
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
	isDrawing := false
]

{ #category : #testing }
TRMorph >> isDragging [
	^ eventBeginingDragging notNil
]

{ #category : #accessing }
TRMorph >> isDrawing [
	^ isDrawing
]

{ #category : #recategorized }
TRMorph >> layoutChanged [
	"react on morph resize"

	super layoutChanged.
	self checkSession.
	
]

{ #category : #'event handling' }
TRMorph >> mouseDown: evt [
	eventBeginingDragging
		ifNil:
			[ evt hand
				waitForClicksOrDrag: self
				event: evt
				selectors: {#trMouseClick:. #trMouseDoubleClick:. nil. #trMouseDragStart:. }
				threshold: 5.
			^ self ].

	evt anyButtonPressed
		ifTrue: [ self trMouseDragging: evt ].
	evt wasHandled: true
]

{ #category : #'event handling' }
TRMorph >> mouseEnter: evt [
	evt anyButtonPressed
		ifFalse: [ self trMouseEnter: evt ].
	evt wasHandled: true
]

{ #category : #'event-processed' }
TRMorph >> mouseEventOfClass: defaultClass ifLeftButton: leftButtonClass ifRightButton: rightButtonClass from: aMorphicEvent [
	| trEventClass |
	trEventClass := defaultClass.
	aMorphicEvent redButtonChanged
		ifTrue: [ trEventClass := leftButtonClass ].
	aMorphicEvent yellowButtonChanged
		ifTrue: [ trEventClass := rightButtonClass ].
	^ self eventOfClass: trEventClass actionClass: defaultClass from: aMorphicEvent
]

{ #category : #'event handling' }
TRMorph >> mouseLeave: evt [
	evt anyButtonPressed
		ifFalse: [ self trMouseLeave: evt ].
	evt wasHandled: true
]

{ #category : #'event handling' }
TRMorph >> mouseMove: evt [
	evt anyButtonPressed
		ifTrue: [ self trMouseDragging: evt ]
		ifFalse: [ self trMouseMove: evt ].
	evt wasHandled: true
]

{ #category : #'event handling' }
TRMorph >> mouseUp: evt [
	self isDragging
		ifTrue: [ self trMouseDragEnd: evt ].
	evt wasHandled: true
]

{ #category : #'event handling' }
TRMorph >> mouseWheel: evt [
	self trMouseWheel: evt.
	evt wasHandled: true
]

{ #category : #recategorized }
TRMorph >> recreateSurfaceIfNecessary [
	surface
		ifNotNil: [ self extent asIntegerPoint ~= surface extent
				ifTrue: [ self createSurface.
					trachelCanvas extent: self extent ] ]
]

{ #category : #'events-roassal' }
TRMorph >> relativePositionFor: evt [
	"Return the position within the window"
	^ evt position - self bounds origin
	"^ trachelCanvas camera fromPixelToSpace: (evt position - self bounds origin) "
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

{ #category : #'event-processed' }
TRMorph >> trKeyDown: aMorphicEvent [
	| trEvent |
	(aMorphicEvent commandKeyPressed and: [ aMorphicEvent keyCharacter = $w ])
		ifTrue: [ self owner delete ].

	trEvent := self eventOfClass: TRKeyDown from: aMorphicEvent.
	trEvent
		position: (trachelCanvas camera fromPixelToSpace: trEvent position);
		keyValue: aMorphicEvent keyValue;
		keyCombination: aMorphicEvent asKeyCombination.
	trEvent shape announce: trEvent
]

{ #category : #'event-processed' }
TRMorph >> trMouseClick: aMorphicEvent [
	| trEvent |
	trEvent := self
		mouseEventOfClass: TRMouseClick
		ifLeftButton: TRMouseLeftClick
		ifRightButton: TRMouseRightClick
		from: aMorphicEvent.
	trEvent position: (trachelCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #'event-processed' }
TRMorph >> trMouseDoubleClick: aMorphicEvent [
	| trEvent |
	trEvent := self
		mouseEventOfClass: TRMouseDoubleClick
		ifLeftButton: TRMouseDoubleLeftClick
		ifRightButton: TRMouseDoubleRightClick
		from: aMorphicEvent.
	trEvent position: (trachelCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #'event-processed' }
TRMorph >> trMouseDragEnd: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: TRMouseDragEnd from: aMorphicEvent.
	trEvent shape: shapeBeingPointed.
	shapeBeingPointed announce: trEvent.
	self announceToEventOverseer: trEvent.
	eventBeginingDragging := nil.
	shapeBeingPointed := nil
]

{ #category : #'event-processed' }
TRMorph >> trMouseDragStart: aMorphicEvent [
	| trEvent trEventClass |
	eventBeginingDragging := aMorphicEvent copy.
	
	trEventClass := TRMouseDragStart.
	aMorphicEvent redButtonChanged
		ifTrue: [ trEventClass := TRMouseLeftDragStart ].
	aMorphicEvent yellowButtonChanged
		ifTrue: [ trEventClass := TRMouseRightDragStart ].
	trEvent := self eventOfClass: trEventClass actionClass: TRMouseDragging from: aMorphicEvent.

	shapeBeingPointed := trEvent shape.
	shapeBeingPointed announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #'event-processed' }
TRMorph >> trMouseDragging: aMorphicEvent [
	| trEvent step |
	eventBeginingDragging ifNil: [ ^ self ].
	step := aMorphicEvent position - eventBeginingDragging position.

	trEvent := self eventOfClass: TRMouseDragging from: aMorphicEvent.
	trEvent step: step.

	shapeBeingPointed ifNil: [ shapeBeingPointed := trEvent shape ].
	"If the element was removed during the drag then cancel the event"
	shapeBeingPointed canvas
		ifNil: [ eventBeginingDragging := nil.
			shapeBeingPointed := nil.
			^ self ].

	trEvent shape: shapeBeingPointed.
	shapeBeingPointed announce: trEvent.
	self announceToEventOverseer: trEvent.
	eventBeginingDragging := aMorphicEvent copy
]

{ #category : #'event-processed' }
TRMorph >> trMouseEnter: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: TRMouseEnter from: aMorphicEvent.
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #'event-processed' }
TRMorph >> trMouseLeave: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: TRMouseLeave from: aMorphicEvent.
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #'event-processed' }
TRMorph >> trMouseMove: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: TRMouseMove from: aMorphicEvent.
	trEvent position: (trachelCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #'event-processed' }
TRMorph >> trMouseWheel: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: TRMouseWheelEvent from: aMorphicEvent.
	trEvent
		direction: aMorphicEvent direction;
		position: (trachelCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #accessing }
TRMorph >> trachelCanvas [
	^ trachelCanvas
]

{ #category : #testing }
TRMorph >> wantsSteps [
	^ trachelCanvas hasAnimation 
]
