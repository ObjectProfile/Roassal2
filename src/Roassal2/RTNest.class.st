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
		- translate all the elements on top of backElement
		- perform a layout if one is set"

	self centerOnTrachelShape: backElement trachelShape elements: elements
	
	"This is a big big question whether we need this or not"
	"backElement attributes at: #nestedElements put: elements."
	
]

{ #category : #public }
RTNest >> centerOnTrachelShape: trachelShape elements: elements [
	"Public method. This method does the following actions:
		- resize the backElement to encompasse all the elements
		- translate all the elements on top of backElement
		- perform a layout if one is set"
	| encompassingRectangle off |
	self doLayoutIfNecessaryOn: elements.
	encompassingRectangle := self encompassingRectangleOf: elements.

	trachelShape extent: (encompassingRectangle width + (padding * 2)) @ (encompassingRectangle height + (padding * 2)).

	off := trachelShape encompassingRectangle center - encompassingRectangle center. 
	off := off asIntegerPoint.
	elements do: [ :e | e translateBy: off ].
	
]

{ #category : #utility }
RTNest >> doLayoutIfNecessaryOn: elements [
	layout ifNotNil: [ layout on: elements ]
]

{ #category : #utility }
RTNest >> encompassingRectangleOf: elements [
	"Maybe in the future, we should enforce to have a group provided as argument, and not a collection"
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
	"Set a layout that is used before doing the nesting"
	layout := aLayout
]

{ #category : #utility }
RTNest >> makeElements: elements draggableBy: backElement [
	^ self makeElements: elements draggableByTrachelShape: backElement trachelShape
	 
]

{ #category : #utility }
RTNest >> makeElements: elements draggableByTrachelShape: trachelShape [
	| callback |
	callback := TRTranslationCallback block: [ :shape :step | elements do: [ :e | e translateBy: step ] ].
	trachelShape addCallback: callback 
]

{ #category : #utility }
RTNest >> makeElements: elements resizable: backElement [
	"If an element of elements is resized, then the backElement should be resized as well.
	"
	| callback1 callback2 |
	callback1 := TRExtentCallback block: [ :shape :newsize |
		self resizeWithoutRecursion: backElement for: elements
	].
	callback2 := TRTranslationCallback block: [ :shape :newsize |
		self resizeWithoutRecursion: backElement for: elements
	].
	elements do: [ :e | e trachelShape addCallback: callback1 ; addCallback: callback2 ] 
]

{ #category : #utility }
RTNest >> makeElements: elements resizableWithoutRecursion: backElement [
	"If an element of elements is resized, then the backElement should be resized as well.
	"
	| callback1 callback2 |
	callback1 := TRExtentCallback block: [ :shape :newsize |
		self resizeWithoutRecursion: backElement for: elements
	].
	callback2 := TRTranslationCallback block: [ :shape :newsize |
		self resizeWithoutRecursion: backElement for: elements
	].
	elements do: [ :e | e trachelShape addCallback: callback1 ; addCallback: callback2 ] 
]

{ #category : #utility }
RTNest >> makeElements: elements transformable: backElement [
	"It makes a scaling/zooming effect.
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
RTNest >> on: element inShape: aSymbol nest: elements [
	"public method"
	"aSymbol could be #first, #second, #third, #fourth"
	
	"We assume that the roassal shape of element is composed"
	^ self on: element inShape: aSymbol nest: elements layout: #vertical
]

{ #category : #public }
RTNest >> on: element inShape: aSymbol nest: elements layout: aSymbolLayout [
	"public method"
	"aSymbol could be #first, #second, #third, #fourth
	
	aSymbolLayout is either #vertical or #horizontal"
	
	"We assume that the roassal shape of element is composed"
	| callback |
	self onTrachelShape: (aSymbol rtValue: element trachelShape shapes) nest: elements.

	callback := TRTranslationCallback block: [ :shape :step | aSymbolLayout rtValue: element trachelShape ].
	element trachelShape addCallback: callback.

	callback := TRExtentCallback block: [ :shape :step | aSymbolLayout rtValue: element trachelShape ].
	element trachelShape addCallback: callback.

	aSymbolLayout rtValue: element trachelShape
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

{ #category : #public }
RTNest >> onResizable: backElement nest: elements [
	"public method"
	"backElement is the elements on which elements are layout-ed"
	"- position the elements above backElement. 
	 - resize backElement to encapsulate the elements
	 - perform a layout of the elements if a layout has been set
	 - make the inner elements draggable"
	
	layout ifNotNil: [ layout on: elements ].
	self centerOn: backElement elements: elements.
	self makeElements: elements draggableBy: backElement.
"	self makeElements: elements transformable: backElement."
	self makeElements: elements resizableWithoutRecursion: backElement.

]

{ #category : #public }
RTNest >> onTrachelShape: trachelShape nest: elements [
	"public method"
	"backElement is the elements on which elements are layout-ed"
	"- position the elements above backElement. 
	 - resize backElement to encapsulate the elements
	 - perform a layout of the elements if a layout has been set
	 - make the inner elements draggable"

	layout ifNotNil: [ layout on: elements ].
	self centerOnTrachelShape: trachelShape elements: elements.
	self makeElements: elements draggableByTrachelShape: trachelShape.

]

{ #category : #accessing }
RTNest >> padding [
	^ padding
]

{ #category : #accessing }
RTNest >> padding: aNumber [
	padding := aNumber
]

{ #category : #utility }
RTNest >> resize: backElement bounds: encompassingRectangle [
	"it translates backElement, but does not trigger events."
	| newRec |
	newRec := (encompassingRectangle topLeft - (padding @ padding)) extent: 
					((encompassingRectangle width + (padding * 2)) @ 
					 (encompassingRectangle height + (padding * 2))).

	backElement trachelShape
		extent: (encompassingRectangle width + (padding * 2)) @ (encompassingRectangle height + (padding * 2)).	
	backElement translateTo: encompassingRectangle center
]

{ #category : #utility }
RTNest >> resize: backElement for: elements [
	| encompassingRectangle |
	encompassingRectangle := self encompassingRectangleOf: elements.
	self resize: backElement bounds: encompassingRectangle.

]

{ #category : #utility }
RTNest >> resizeWithoutRecursion: backElement bounds: encompassingRectangle [
	"it translates backElement, but does not trigger events."
	| newRec |
	newRec := (encompassingRectangle topLeft - (padding @ padding)) extent: 
					((encompassingRectangle width + (padding * 2)) @ 
					 (encompassingRectangle height + (padding * 2))).

	backElement trachelShape
		extent: (encompassingRectangle width + (padding * 2)) @ (encompassingRectangle height + (padding * 2)).	
	backElement trachelShape doWithoutCallbacks: [ backElement translateTo: encompassingRectangle center ]
]

{ #category : #utility }
RTNest >> resizeWithoutRecursion: backElement for: elements [
	| encompassingRectangle |
	encompassingRectangle := self encompassingRectangleOf: elements.
	self resizeWithoutRecursion: backElement bounds: encompassingRectangle.

]
