Class {
	#name : #RTNest,
	#superclass : #RTObject,
	#instVars : [
		'layout'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTNest >> centerOn: backElement element: elements [
	| encompassingRectangle off |
	encompassingRectangle := elements anyOne encompassingRectangle.
	elements do: [ :e | encompassingRectangle := encompassingRectangle merge: e encompassingRectangle ].
	
	backElement trachelShape extent: (encompassingRectangle width + (5 * 2)) @ (encompassingRectangle height + (5 * 2)).
	off := backElement encompassingRectangle topLeft.
	elements do: [ :e | e translateBy: (encompassingRectangle topLeft + off) ]
]

{ #category : #'as yet unclassified' }
RTNest >> initialize [
	super initialize.
	layout := RTHorizontalLineLayout new
]

{ #category : #'as yet unclassified' }
RTNest >> layout [
	^ layout
]

{ #category : #'as yet unclassified' }
RTNest >> layout: aLayout [
	layout := aLayout
]

{ #category : #'as yet unclassified' }
RTNest >> on: backElement nest: elements [
	"public method"
	"backElement is the elements on which elements are layout-ed"
	layout on: elements.
	self centerOn: backElement element: elements

]
