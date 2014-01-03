Class {
	#name : #RTNest,
	#superclass : #RTObject,
	#instVars : [
		'layout'
	],
	#category : #'Roassal2-Core'
}

{ #category : #utility }
RTNest >> centerOn: backElement element: elements [
	| encompassingRectangle off |
	encompassingRectangle := self encompassingRectangleOf: elements.
	
	backElement trachelShape extent: (encompassingRectangle width + (5 * 2)) @ (encompassingRectangle height + (5 * 2)).

	off := backElement encompassingRectangle center - encompassingRectangle center. 
	off := off asIntegerPoint.
	elements do: [ :e | e translateBy: off ].
]

{ #category : #utility }
RTNest >> encompassingRectangleOf: elements [
	| encompassingRectangle |
	encompassingRectangle := elements anyOne encompassingRectangle.
	elements do: [ :e | encompassingRectangle := encompassingRectangle merge: e encompassingRectangle ].
	^ encompassingRectangle 
]

{ #category : #initialization }
RTNest >> initialize [
	super initialize.

]

{ #category : #accessing }
RTNest >> layout [
	^ layout
]

{ #category : #accessing }
RTNest >> layout: aLayout [
	layout := aLayout
]

{ #category : #utility }
RTNest >> makeElements: elements draggableBy: backElement [
	| callback |
	callback := TRTranslationCallback block: [ :shape :step | elements do: [ :e | e translateBy: step ] ].
	backElement trachelShape addCallback: callback 
]

{ #category : #public }
RTNest >> on: backElement nest: elements [
	"public method"
	"backElement is the elements on which elements are layout-ed"
	"- position the elements above backElement. 
	 - resize backElement to encapsulate the elements
	 - perform a layout of the elements if a layout has been set
	 - make the inner elements draggable"
	
	layout ifNotNil: [ layout on: elements ].
	self centerOn: backElement element: elements.
	self makeElements: elements draggableBy: backElement.

]
