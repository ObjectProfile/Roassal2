Class {
	#name : #RTView,
	#superclass : #RTAnnounceableObject,
	#instVars : [
		'elements',
		'edges',
		'animations',
		'trCanvas'
	],
	#category : #'Roassal2-Core'
}

{ #category : #visitor }
RTView >> accept: aVisitor [
	aVisitor visitView: self
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

{ #category : #menu }
RTView >> addMenu: aTitle callback: aBlock [
	self canvas addMenu: aTitle callback: aBlock

]

{ #category : #accessing }
RTView >> canvas [
	"Return the trachel canvas on which everything is drawn"
	^ trCanvas
]

{ #category : #actions }
RTView >> edgeFromModel: anObject [
	"Return an edge that corresponds to the object provided as parameter. If none is found, then return nil"
	^ edges detect: [ :edge | edge model = anObject ] ifNone: [ nil ]
]

{ #category : #accessing }
RTView >> edges [
	^ edges copy
]

{ #category : #actions }
RTView >> elementFromModel: anObject [
	"Return an element that corresponds to the object provided as parameter. If none is found, then return nil"
	^ elements detect: [ :el | el model = anObject ] ifNone: [ nil ]
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
	
	"Share my announcer with the one of the Trachel Canvas"
	announcer := trCanvas announcer.
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

{ #category : #opening }
RTView >> openInWindowSized: anExtentAsPoint [
	^ self setUpCanvas openInWindowSized: anExtentAsPoint
]

{ #category : #opening }
RTView >> openInWindowSized: anExtentAsPoint titled: aTitle [
	^ self setUpCanvas openInWindowSized: anExtentAsPoint titled: aTitle
]

{ #category : #'instance creation' }
RTView >> openWithMenu [
	self canvas addMenu: 'In' callback: [ RTZoomInMove on: self ].
	self canvas addMenu: 'Out' callback: [ RTZoomOutMove on: self ].

	^ self setUpCanvas open
]

{ #category : #actions }
RTView >> removeEdge: anEdge [
	edges remove: anEdge ifAbsent: [ ].
	anEdge trachelShape remove.
]

{ #category : #adding }
RTView >> removeElement: anElement [
	elements remove: anElement ifAbsent: [ ].
	anElement trachelShape remove.
]

{ #category : #menu }
RTView >> setDefaultMenu [
	"Simply add some useful menu"
	| b |
	b := RTMenuBuilder new view: self.
	b menu: 'Zoom' submenu: '+' background: Color red callback: [ RTZoomInMove on: self ].
	b menu: 'Zoom' submenu: '-' background: Color red callback: [ RTZoomOutMove on: self ].
	b render
]

{ #category : #initialization }
RTView >> setUpCanvas [
	trCanvas camera focusOnCenter.
	^ trCanvas
]

{ #category : #'accessing-computed' }
RTView >> trachelShape [

	^ TRNoShape instance
]
