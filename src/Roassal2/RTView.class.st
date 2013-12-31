Class {
	#name : #RTView,
	#superclass : #RTObject,
	#instVars : [
		'elements',
		'edges',
		'animations',
		'trCanvas'
	],
	#category : #Roassal2
}

{ #category : #adding }
RTView >> @ anInteractionClassOrInstance [
	"Add an interaction to the node"
	
	self addInteraction: anInteractionClassOrInstance
]

{ #category : #adding }
RTView >> add: anElementOrAnEdge [
	anElementOrAnEdge addedIn: self

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

{ #category : #accessing }
RTView >> canvas [
	"Return the trachel canvas on which everything is drawn"
	^ trCanvas
]

{ #category : #initialization }
RTView >> createAndFillCanvas [
	elements do: [ :el | el renderOn: trCanvas ].
	edges do: [ :el | el renderOn: trCanvas ].
	animations do: [ :a | trCanvas addAnimation: a ].
	trCanvas camera focusOnCenter.
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
	"^ trachelCanvas open"

	^ self createAndFillCanvas open
]
