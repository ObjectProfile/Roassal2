Class {
	#name : #RTNest,
	#superclass : #RTObject,
	#instVars : [
		'layout',
		'padding'
	],
	#category : #'Roassal2-Core'
}

{ #category : #public }
RTNest >> centerOn: backElement elements: elements [
	"Public method. This method does the following actions:
		- resize the backElement to encompasse all the elements
		- translate all the elements on top of backElement"
		
	| encompassingRectangle off |
	encompassingRectangle := self encompassingRectangleOf: elements.
	
	backElement trachelShape extent: (encompassingRectangle width + (padding * 2)) @ (encompassingRectangle height + (padding * 2)).

	off := backElement encompassingRectangle center - encompassingRectangle center. 
	off := off asIntegerPoint.
	elements do: [ :e | e translateBy: off ].
]

{ #category : #utility }
RTNest >> encompassingRectangleOf: elements [
	| encompassingRectangle |
	elements isEmpty ifTrue: [ ^ (0 @ 0) extent: (0 @ 0) ]. 
	encompassingRectangle := elements anyOne encompassingRectangle.
	elements do: [ :e | encompassingRectangle := encompassingRectangle merge: e encompassingRectangle ].
	^ encompassingRectangle 
]

{ #category : #initialization }
RTNest >> initialize [
	super initialize.
	padding := 5.

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

{ #category : #utility }
RTNest >> makeElements: elements transformable: backElement [
	"It makes a scaling/zooming efect.
	If you change backElement's extent, it changes proportionaly extent and position of nested elements. 
	So the overall image --- composition of backElement and elements --- does not change. 
	It only zoom in/out the overall image."
	| callback |
	callback := TRExtentCallback block: [ :shape :ratio | 
		| mainPosition |
		mainPosition := backElement position.
		elements do: [ :eachElement | | eachPosition |
			eachPosition := eachElement position.
			eachElement 
				extent: eachElement extent * ratio;
				translateTo: mainPosition + ((eachPosition - mainPosition) * ratio) ] ].
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
	self centerOn: backElement elements: elements.
	self makeElements: elements draggableBy: backElement.
	self makeElements: elements transformable: backElement.

]

{ #category : #accessing }
RTNest >> padding [
	^ padding
]

{ #category : #accessing }
RTNest >> padding: aNumber [
	padding := aNumber
]
