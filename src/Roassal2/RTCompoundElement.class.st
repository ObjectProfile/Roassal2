"
I describe a compound element. Note that this is preliminary work. This class is not completed.

-=-=-=
classes := RTShape withAllSubclasses.
v := RTView new.
v @ RTDraggableView.

es := classes asGroup collect: [ :c |
	b := RTPieBuilder new.
	b objects: (Array with: (c instVarNames size) with: (c methods size)).
	b slice: #yourself.
	b build.
	b view asElementOn: c. 
].

v addAll: es.
es @ RTPopup @ RTDraggable.

eb := RTEdgeBuilder new.
eb shape line width: 3; color: Color red; withShorterDistanceAttachPoint.
eb view: v.
eb elements: es.
eb moveBehind.
eb connectToAll: #dependentClasses.

RTOptimizedForceBasedLayout new
	charge: -8000; length: 1000; on: es.
v
-=-=-=
"
Class {
	#name : #RTCompoundElement,
	#superclass : #RTElement,
	#instVars : [
		'children',
		'layoutBuilder'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTCompoundElement >> add: anElement [
	children add: anElement.
]

{ #category : #'as yet unclassified' }
RTCompoundElement >> addAll: someElements [
	children addAll: someElements
]

{ #category : #'as yet unclassified' }
RTCompoundElement >> addedIn: aView [
	super addedIn: aView.
	"aView addAll: children."
	children do: [ :c | c addedIn: aView ].

	self doLayoutIfNecessary.
	self doNesting
]

{ #category : #'as yet unclassified' }
RTCompoundElement >> children [
	"Defensive copy"
	^ children copy
]

{ #category : #'as yet unclassified' }
RTCompoundElement >> doLayoutIfNecessary [
	"Perform a layout on the children elements if necessary."
	layoutBuilder ifNil: [ ^ self ].
	layoutBuilder setUpElements: children
]

{ #category : #'as yet unclassified' }
RTCompoundElement >> doNesting [
	RTNest new on: self nest: children
]

{ #category : #'as yet unclassified' }
RTCompoundElement >> initialize [
	super initialize.
	children := RTGroup new.
	
]

{ #category : #'as yet unclassified' }
RTCompoundElement >> layout [
	"We do a lazy initialization"
	layoutBuilder := RTLayoutBuilder new.
	^ layoutBuilder
]

{ #category : #'as yet unclassified' }
RTCompoundElement >> renderOn: trachelCanvas [
	super renderOn: trachelCanvas.
	children do: [ :c | c renderOn: trachelCanvas ]
]
