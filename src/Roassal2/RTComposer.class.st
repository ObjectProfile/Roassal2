"
I am responsible to compose several visualizations.

For example:
====
compo := RTComposer new.

b := RTMondrian new.
b view: compo view.
b nodes: (1 to: 3).
b build.
compo group: #g1.

b := RTMondrian new.
b view: compo view.
b nodes: (1 to: 4).
b build.

compo group: #g2.

compo layout: RTVerticalLineLayout new alignCenter. 
compo view
====
"
Class {
	#name : #RTComposer,
	#superclass : #RTObject,
	#instVars : [
		'stack',
		'view',
		'gap',
		'mapping',
		'groups'
	],
	#category : #'Roassal2-Builder-Composer'
}

{ #category : #accessing }
RTComposer >> allGroupedElements [
	^ mapping values flatCollect: #yourself
]

{ #category : #accessing }
RTComposer >> currentElements [
	^ view elements 
]

{ #category : #accessing }
RTComposer >> currentElementsAsGroup [
	^ RTGroup withAll: self currentElements
]

{ #category : #accessing }
RTComposer >> gap [
	"Return the space between visualizations"
	^ gap
]

{ #category : #accessing }
RTComposer >> gap: anInteger [
	gap := anInteger
]

{ #category : #'public-layout' }
RTComposer >> group [
	"Define a new group with the elements added to the view using a computed name"
	^ self group: ('group', (mapping size asString)) asSymbol
]

{ #category : #'public-layout' }
RTComposer >> group: aName [
	"Define a new group with the elements added to the view"
	| group |
	group := self newElementsAsGroup.
	groups add: group.
	mapping at: aName put: group.
]

{ #category : #initialization }
RTComposer >> initialize [
	super initialize.
	view := RTView new.
	view @ RTDraggableView.
	groups := OrderedCollection new.
	mapping := Dictionary new.
	gap := 20
]

{ #category : #'public-layout' }
RTComposer >> layout: aLayout [
	"Layout all the group of elements"
	aLayout on: groups.

]

{ #category : #'public-layout' }
RTComposer >> move: name1 above: name2 [
	
	| g1 g2 |
	g1 := mapping at: name1. 
	g2 := mapping at: name2.
	TRConstraint move: g1 above: g2.
	g1 translateBy: 0 @ gap negated
]

{ #category : #'public-layout' }
RTComposer >> move: name1 below: name2 [
	
	| g1 g2 |
	g1 := mapping at: name1. 
	g2 := mapping at: name2.
	TRConstraint move: g1 below: g2.
	g1 translateBy: 0 @ gap
]

{ #category : #'public-layout' }
RTComposer >> move: name1 belowAlignFromLeft: name2 [
	
	| g1 g2 |
	g1 := mapping at: name1. 
	g2 := mapping at: name2.
	TRConstraint move: g1 belowAlignFromLeft: g2 gap: gap.
]

{ #category : #'public-layout' }
RTComposer >> move: name1 onTheLeftOf: name2 [
	
	| g1 g2 |
	g1 := mapping at: name1. 
	g2 := mapping at: name2.
	TRConstraint move: g1 onTheLeftOf: g2.
	g1 translateBy: gap negated @ 0
]

{ #category : #'public-layout' }
RTComposer >> move: name1 onTheRightBelowOf: name2 [
	
	| g1 g2 |
	g1 := mapping at: name1. 
	g2 := mapping at: name2.
	TRConstraint move: g1 onTheRightBelowOf: g2.
	g1 translateBy: 0 @ gap
]

{ #category : #'public-layout' }
RTComposer >> move: name1 onTheRightOf: name2 [
	
	| g1 g2 |
	g1 := mapping at: name1. 
	g2 := mapping at: name2.
	RTConstraint move: g1 onTheRightOf: g2.
	g1 translateBy: gap @ 0
]

{ #category : #'public-naming' }
RTComposer >> nameBelowGroup: aName as: title [
	"Give a title to a group.
	
	For example:
	
| compo |
compo := RTComposer new.

b := RTMondrian new.
b view: compo view.
b nodes: (1 to: 30).
b layout grid.
b build.
compo group: #g1.

b := RTMondrian new.
b view: compo view.
b nodes: (1 to: 30).
b layout grid.
b build.
compo group: #g2. 

compo layout: RTVerticalLineLayout new alignCenter.

compo setBackgroundForGroup: #g1 color: Color red trans.
compo nameGroup: #g1 as: 'Goup 1'.
compo view

	"
	| lbl |
	lbl := (RTLabel new text: title) element.
	TRConstraint move: lbl below: (mapping at: aName).
	view add: lbl.
	^ lbl
]

{ #category : #'public-naming' }
RTComposer >> nameGroup: aName as: title [
	"Give a title to a group.
	
	For example:
	
| compo |
compo := RTComposer new.

b := RTMondrian new.
b view: compo view.
b nodes: (1 to: 30).
b layout grid.
b build.
compo group: #g1.

b := RTMondrian new.
b view: compo view.
b nodes: (1 to: 30).
b layout grid.
b build.
compo group: #g2. 

compo layout: RTVerticalLineLayout new alignCenter.

compo setBackgroundForGroup: #g1 color: Color red trans.
compo nameGroup: #g1 as: 'Goup 1'.
compo view

	"
	| lbl |
	lbl := (RTLabel new text: title) element.
	TRConstraint move: lbl above: (mapping at: aName).
	view add: lbl.
	^ lbl
]

{ #category : #accessing }
RTComposer >> newElementsAsGroup [
	| es |
	es := view elements select: [ :e | e hasNotAttribute: #AlreadyGrouped ].
	es do: [ :e | e attributeAt: #AlreadyGrouped put: true ].
	^ es 
"	^ RTGroup withAll: (view elements copyWithoutAll: self allGroupedElements)"
]

{ #category : #'public-layout' }
RTComposer >> open [
	^ view open
]

{ #category : #'public-interaction' }
RTComposer >> propagateHighlight [

	self newElementsAsGroup @ RTHighlightable allSibblings.
]

{ #category : #'public-interaction' }
RTComposer >> propagateHighlightToAll [
	"Highlight all the elements that have the same model"
	mapping value do: [ :g | g @ RTHighlightable allSibblings ]
]

{ #category : #'public-interaction' }
RTComposer >> propagateHighlightUsing: aBlock [
	"Highlight all the elements return by aBlock. 
	 The aBlock variable is evaluated for a Roassal element"
	mapping value do: [ :g | g @ (RTHighlightable new highlightElements: aBlock) ]
]

{ #category : #'public-background' }
RTComposer >> setBackgroundColor: aColor forGroup: aName [
"
Set a background for a visualization.

Example:
compo := RTComposer new.

b := RTMondrian new.
b view: compo view.
b nodes: (1 to: 3).
b build.
compo group: #g1.

b := RTMondrian new.
b view: compo view.
b nodes: (1 to: 4).
b build.
compo group: #g2.

compo layout: RTVerticalLineLayout new alignCenter. 

compo setBackgroundForGroup: #g1 color: Color red.
compo view

"


	| box g outterGap |
	outterGap := 5 @ 5.
	box := TRRoundedBoxShape new.
	box color: aColor.
	box strokeWidth: 0.
	box borderRadius: 5.
	g := mapping at: aName.
	box translateTo: g center.
	box extent: g extent + outterGap.
	"RTNest new centerOnTrachelShape: box elements: g."
	view canvas addShape: box.
	box pushBack.
	^ box
	
"	| box g |
	box := RTBox element.
	g := mapping at: aName.
	RTNest new centerOn: box elements: g.
	view add: box.
	box pushBack.
	^ box"
]

{ #category : #'public title' }
RTComposer >> setGeneralTitle: aTitleAsString [
	self setGeneralTitle: aTitleAsString gap: 0 @ -50
]

{ #category : #'public title' }
RTComposer >> setGeneralTitle: aTitleAsString gap: gapAsPoint [
	| title |
	title := (RTLabel new text: aTitleAsString; height: 20) element.
	TRConstraint move: title above: self allGroupedElements asGroup.
	title translateBy: gapAsPoint.
	self view add: title
]

{ #category : #accessing }
RTComposer >> view [
	^ view
]

{ #category : #accessing }
RTComposer >> view: aView [
	view := aView
]
