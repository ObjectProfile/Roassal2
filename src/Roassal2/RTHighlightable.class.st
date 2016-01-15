"
A RTHighlightable changes color of elements which should be highlighted.

For example:

[ [ [ 
v := RTView new.
es := RTEllipse elementsOn: (20 to: 70 by: 5) asArray shuffle.
v addAll: es.
es @ RTPopup.
RTMetricNormalizer new
	elements: es;
	normalizeSize: #yourself;
	normalizeColor: #yourself.
RTFlowLayout on: es.

es @ RTHighlightable.
v
 ] ] ]

Another example:

[ [ [
v := RTView new.
es := RTEllipse elementsOn: (20 to: 70 by: 5) asArray shuffle.
v addAll: es.
es @ RTPopup.
RTMetricNormalizer new
	elements: es;
	normalizeSize: #yourself;
	normalizeColor: #yourself.
RTFlowLayout on: es.

es @ (RTHighlightable new highlight: [ :aNumber | aNumber to: 70 by: 5] ).
v			 
 ] ] ]

Here is a third example using highlightelements:
[ [ [  
v := RTView new.
es := RTEllipse elementsOn: (20 to: 70 by: 5) asArray shuffle.
v addAll: es.
es @ RTPopup.
RTMetricNormalizer new
	elements: es;
	normalizeSize: #yourself min: 5 max: 30;
	normalizeColor: #yourself.
RTFlowLayout on: es.

es @ (RTHighlightable new highlightElements: [ :element | 
	element view elements select: [ :e | e trachelShape height > 15 ] ] ).
v
] ] ]
"
Class {
	#name : #RTHighlightable,
	#superclass : #RTAbstractHighlightable,
	#instVars : [
		'color'
	],
	#category : #'Roassal2-Interactions'
}

{ #category : #'reset shape' }
RTHighlightable class >> highlightedColor [
	"Default color for highlighting"
	^ Color blue
]

{ #category : #visitor }
RTHighlightable >> accept: aVisitor with: args [
	aVisitor visitHightlightableInteraction: self with: args.
]

{ #category : #accessing }
RTHighlightable >> color [
	"Return the color used for the highlighting"
	^ color
]

{ #category : #accessing }
RTHighlightable >> color: aColor [
	"Set the color used for the highlighting"
	color := aColor
]

{ #category : #actions }
RTHighlightable >> doHighlightElement: anElement [
	| v |
	self recordElement: anElement.	"not sure if we need to return something"
	v := anElement trachelShape color: (self highlightColorFor: anElement).
	anElement view ifNotNil: [ anElement view signalUpdate ].
	^ v
]

{ #category : #actions }
RTHighlightable >> doUnhighlightElement: anElement [
	(anElement attributes includesKey: #originalColor)
		ifFalse: [ ^ self ].
	anElement trachelShape color: (anElement attributes at: #originalColor).
	anElement attributes removeKey: #originalColor.
	anElement view ifNotNil: [ anElement view signalUpdate ].
	
]

{ #category : #utility }
RTHighlightable >> highlightColorFor: anElement [
	"Return the highlight color"
	^ self highlightedColor rtValue: anElement model
]

{ #category : #configuration }
RTHighlightable >> highlightedColor [
	^ color
]

{ #category : #configuration }
RTHighlightable >> highlightedColor: aColorOrABlock [
	color := aColorOrABlock
]

{ #category : #initialize }
RTHighlightable >> initialize [
	super initialize.
	color := self class highlightedColor
]

{ #category : #actions }
RTHighlightable >> recordElement: anElement [
	(anElement attributes includesKey: #originalColor) ifTrue: [ ^ self ].
	anElement attributes at: #originalColor put: (anElement trachelShape color)

]
