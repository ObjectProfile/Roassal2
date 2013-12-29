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

{ #category : #'as yet unclassified' }
RTView >> add: anElementOrAnEdge [
	anElementOrAnEdge addedIn: self

]

{ #category : #'as yet unclassified' }
RTView >> addAll: someElements [
	someElements do: [ :el | self add: el ]
]

{ #category : #'as yet unclassified' }
RTView >> addAnimation: animation [
	trCanvas addAnimation: animation
]

{ #category : #'as yet unclassified' }
RTView >> addEdge: anEdge [
	edges add: anEdge
]

{ #category : #'as yet unclassified' }
RTView >> addElement: anElement [
	elements add: anElement
]

{ #category : #'as yet unclassified' }
RTView >> createAndFillCanvas [
	elements do: [ :el | el renderOn: trCanvas ].
	edges do: [ :el | el renderOn: trCanvas ].
	animations do: [ :a | trCanvas addAnimation: a ].
	trCanvas camera focusOnCenter.
	^ trCanvas
]

{ #category : #'as yet unclassified' }
RTView >> edges [
	^ edges copy
]

{ #category : #'as yet unclassified' }
RTView >> elementFromModel: anObject [
	"Return an element that corresponds to the object provided as parameter. If none is found, then return nil"
	^ elements detect: [ :el | el model == anObject ] ifNone: [ nil ]
]

{ #category : #'as yet unclassified' }
RTView >> elements [
	^ elements copy
]

{ #category : #'as yet unclassified' }
RTView >> initialize [
	super initialize.
	elements := OrderedCollection new.
	animations := OrderedCollection new.
	edges := OrderedCollection new.
	trCanvas := TRCanvas new.
]

{ #category : #'as yet unclassified' }
RTView >> numberOfEdges [
	^ edges size
]

{ #category : #'as yet unclassified' }
RTView >> numberOfElements [
	^ elements size
]

{ #category : #'as yet unclassified' }
RTView >> open [
	"^ trachelCanvas open"

	^ self createAndFillCanvas open
]
