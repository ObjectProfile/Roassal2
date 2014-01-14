Class {
	#name : #RTView,
	#superclass : #RTObject,
	#instVars : [
		'elements',
		'edges',
		'animations',
		'trCanvas'
	],
	#category : #'Roassal2-Core'
}

{ #category : #adding }
RTView >> @ anInteractionClassOrInstance [
	"Add an interaction to the node"
	
	self addInteraction: anInteractionClassOrInstance
]

{ #category : #adding }
RTView >> add: anElementOrAnEdge [
	anElementOrAnEdge addedIn: self.
	anElementOrAnEdge renderOn: trCanvas 

]

{ #category : #adding }
RTView >> addAll: someElements [
	someElements do: [ :el | self add: el ]
]

{ #category : #adding }
RTView >> addAnimation: animation [
	trCanvas addAnimation: animation
]

{ #category : #adding }
RTView >> addEdge: anEdge [
	edges add: anEdge
]

{ #category : #adding }
RTView >> addElement: anElement [
	elements add: anElement
]

{ #category : #adding }
RTView >> addInteraction: anInteractionClassOrInstance [
 	anInteractionClassOrInstance initializeElement: self
]

{ #category : #menu }
RTView >> addMenu: aTitle callback: aBlock [
	self canvas addMenu: aTitle callback: aBlock
	"| el |
	el := RTLabel elementOn: aTitle.
	el on: TRMouseClick do: [ :event | aBlock value ].
	self add: el.
	el trachelShape setAsFixed"
]

{ #category : #accessing }
RTView >> canvas [
	"Return the trachel canvas on which everything is drawn"
	^ trCanvas
]

{ #category : #accessing }
RTView >> edges [
	^ edges copy
]

{ #category : #actions }
RTView >> elementFromModel: anObject [
	"Return an element that corresponds to the object provided as parameter. If none is found, then return nil"
	^ elements detect: [ :el | el model == anObject ] ifNone: [ nil ]
]

{ #category : #accessing }
RTView >> elements [
	^ elements copy
]

{ #category : #initialization }
RTView >> initialize [
	super initialize.
	elements := OrderedCollection new.
	animations := OrderedCollection new.
	edges := OrderedCollection new.
	trCanvas := TRCanvas new.
]

{ #category : #'accessing-computed' }
RTView >> numberOfEdges [
	^ edges size
]

{ #category : #'accessing-computed' }
RTView >> numberOfElements [
	^ elements size
]

{ #category : #'instance creation' }
RTView >> open [
	^ self setUpCanvas open
]

{ #category : #'instance creation' }
RTView >> openWithMenu [
	self canvas addMenu: 'In' callback: [ RTZoomInMove on: self ].
	self canvas addMenu: 'Out' callback: [ RTZoomOutMove on: self ].

	^ self setUpCanvas open
]

{ #category : #adding }
RTView >> removeElement: anElement [
	elements remove: anElement ifAbsent: [ ].
	anElement trachelShape remove.
]

{ #category : #initialization }
RTView >> setUpCanvas [
	trCanvas camera focusOnCenter.
	^ trCanvas
]
