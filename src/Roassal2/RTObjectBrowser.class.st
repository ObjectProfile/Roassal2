"
I am a simple builder of interactive view that allows you to inspect and navigate an  object.
"
Class {
	#name : #RTObjectBrowser,
	#superclass : #RTBuilder,
	#instVars : [
		'target',
		'objects',
		'last'
	],
	#category : #'Roassal2-Experimental'
}

{ #category : #private }
RTObjectBrowser >> addNewElement: anElement [
	| pos anime |
	pos := self positionFor: anElement.
	anElement first translateTo: pos.
	view addAll: anElement.
	anime := RTAddElementAnimation new.
	anime shape circle color: Color transparent; borderColor: Color blue.
	anime element: anElement during: 1.
	view canvas focusOnCenterScaled.
	view addAnimation: anime.
]

{ #category : #private }
RTObjectBrowser >> addNewObject: anObject [
	| newElement |
	newElement := self createElementsFor: anObject.
	self addNewElement: newElement.
	self objects at: anObject put: newElement.
]

{ #category : #'adding item' }
RTObjectBrowser >> addObject: anObject [
	| bool |
	bool := false.
	(self contains: anObject) ifFalse: [
		self addNewObject: anObject.
		bool := true ].
	
	self selectObject: anObject.
	^ bool.
	
]

{ #category : #testing }
RTObjectBrowser >> contains: anObject [
	^ self objects includesKey: anObject
]

{ #category : #private }
RTObjectBrowser >> createElementsFor: anObject [
	| b obj |
	b := RTMondrian new.
	b shape box color: Color veryLightGray; 
		withTextAbove: [ anObject class name ].
	b interaction menu
		item: 'Inspect' action: [:e | e model inspect];
		item: 'Browse class' action: [ :e | e model class browse ];
		item: 'Close ' action: [:e | 
			(self objects at: anObject) do: #remove.
			view canvas focusOnCenterScaled.
			view signalUpdate ].
	b interaction
		when: TRMouseDragEnd do: [ :e | view canvas focusOnCenterScaled. view signalUpdate ].
	b node: anObject forIt: [ 
		b shape label text: #key;
			if: [ :assoc | assoc value isNil ] color: Color red.
		b interaction 
			noInteractions;
			highlight;
			when: TRMouseClick do: [ :evt |
				obj := evt element model value.
				self addObject: obj.
				view add: (RTArrowedLine new 
					withShorterDistanceAttachPoint; 
					color: Color blue;
					edgeFrom: evt element to: (self objects at: obj) first)
				 ];
			popupText: [:ass | ass value asString ].
		b nodes: (anObject class allInstVarNames collect: [ :n |
			n -> (anObject instVarNamed: n) ] ).
		b layout verticalLine ].
	b build.
	^ b view elements
]

{ #category : #hooks }
RTObjectBrowser >> createView [
	^ super createView @ RTDraggableView @ RTZoomableView.
]

{ #category : #initialization }
RTObjectBrowser >> initialize [
	super initialize.
	objects := Dictionary new.
]

{ #category : #public }
RTObjectBrowser >> object: anObject [
	target := anObject
]

{ #category : #accessing }
RTObjectBrowser >> objects [
	^ objects
]

{ #category : #private }
RTObjectBrowser >> positionFor: anElement [
	"something fancy here to find a nice position for this element"
	| rect res |
	rect := view canvas encompassingRectangle.
	(last isNil or: [last > 4]) ifTrue: [ last := 1 ].
	res := rect corners at: last.
	last := last + 1.
	^ res.
	
]

{ #category : #hooks }
RTObjectBrowser >> renderIn: aView [
	view := aView.
	target ifNotNil: [ 
		self addNewObject: target].
]

{ #category : #acctions }
RTObjectBrowser >> selectObject: anObject [
	
]
