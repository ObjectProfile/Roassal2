"
A GLMTabLabelTurboBrick is  single resizable Tab Label used in LazyTabGroupMorph.

Instance Variables
	normalLabel:		<Object>
	selectedLabel:		<Object>
	tabSelector:		<Object>

normalLabel
	- xxxxx

selectedLabel
	- xxxxx

tabSelector
	- xxxxx

"
Class {
	#name : #GLMTabLabelBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'tabSelector',
		'normalLabel',
		'selectedLabel'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #accessing }
GLMTabLabelBrick >> adoptPaneColor: paneColor [
	"Use the theme for fillStyle and border."
	
	super adoptPaneColor: paneColor.
	paneColor ifNil: [^self].
	self fillStyle: self fillStyleToUse.
	self borderStyle: self borderStyleToUse
]

{ #category : #accessing }
GLMTabLabelBrick >> borderStyleToUse [
	"Answer the borderStyle that should be used for the receiver."
	
	^self isSelected
		ifTrue: [self theme tabLabelSelectedBorderStyleFor: self]
		ifFalse: [self theme tabLabelNormalBorderStyleFor: self]
]

{ #category : #actions }
GLMTabLabelBrick >> deselect [
	self layoutProperties minWidth: 0.
	self brickRoot changed.
	self brickRoot doLayout.
	self brickRoot changed.
]

{ #category : #accessing }
GLMTabLabelBrick >> fillStyleToUse [
	"Answer the basic fill style for the receiver."

	^self isSelected
		ifTrue: [self selectedFillStyle] 
		ifFalse: [self normalFillStyle]
]

{ #category : #accessing }
GLMTabLabelBrick >> font: aFont [
	"Set the label font"

	self normalLabel allMorphsDo: [:m |
		(m respondsTo: #font:) ifTrue: [m font: aFont]].
	self selectedLabel allMorphsDo: [:m |
		(m respondsTo: #font:) ifTrue: [m font: aFont]]
]

{ #category : #initialization }
GLMTabLabelBrick >> initialize [
	"Initialize the receiver."
	
	super initialize.
	self fillStyle: self fillStyleToUse.
	self borderStyle: self borderStyleToUse.
	
	self enable.
]

{ #category : #accessing }
GLMTabLabelBrick >> isSelected [
	"Answer whether the tab is selected."

	^self tabSelector
		ifNil: [false]
		ifNotNil: [:selector | selector selectedTab == self]
]

{ #category : #accessing }
GLMTabLabelBrick >> label [
	"Answer the label contents."

	^self isSelected
		ifTrue: [self selectedLabel userString ifNil: [self firstSubmorph]]
		ifFalse: [self normalLabel userString ifNil: [self firstSubmorph]]
]

{ #category : #accessing }
GLMTabLabelBrick >> label: aTrickMorph [
	"Change the label contents"
	
	aTrickMorph layoutProperties horizontalPercent: 100.
	self layoutProperties maxWidthBlock: aTrickMorph layoutProperties maxWidthBlock.

	self
		normalLabel: aTrickMorph;
		selectedLabel: aTrickMorph;
		selected: self isSelected
]

{ #category : #'as yet unclassified' }
GLMTabLabelBrick >> label: aTrickMorph selected: selectedTrickMorph [
	"Change the label contents"

	aTrickMorph layoutProperties horizontalPercent: 100.
	selectedTrickMorph layoutProperties horizontalPercent: 100.
	
	self layoutProperties maxWidthBlock: aTrickMorph layoutProperties maxWidthBlock.
	
	self
		normalLabel: aTrickMorph;
		selectedLabel: selectedTrickMorph;
		selected: self isSelected
]

{ #category : #'as yet unclassified' }
GLMTabLabelBrick >> normalFillStyle [
	"Return the normal fillStyle of the receiver."
	
	^ self theme tabLabelNormalFillStyleFor: self
]

{ #category : #accessing }
GLMTabLabelBrick >> normalLabel [

	^ normalLabel
]

{ #category : #accessing }
GLMTabLabelBrick >> normalLabel: anObject [

	normalLabel := anObject
]

{ #category : #actions }
GLMTabLabelBrick >> select [
	self layoutProperties minWidthBlock: [ (self label layoutProperties maxWidthBlock value: self label) min: self brickRoot width ].
	self brickRoot doLayout.
	self brickRoot changed.
]

{ #category : #accessing }
GLMTabLabelBrick >> selected: aBoolean [
	"Use the appropriate label."

	self removeAllBricks.
	self isSelected
		ifTrue: [self addBrickBack: self selectedLabel]
		ifFalse: [self addBrickBack: self normalLabel]
]

{ #category : #'as yet unclassified' }
GLMTabLabelBrick >> selectedFillStyle [
	"Return the selected fillStyle of the receiver."
	
	^ self theme tabLabelSelectedFillStyleFor: self
]

{ #category : #accessing }
GLMTabLabelBrick >> selectedLabel [

	^ selectedLabel
]

{ #category : #accessing }
GLMTabLabelBrick >> selectedLabel: anObject [

	selectedLabel := anObject
]

{ #category : #accessing }
GLMTabLabelBrick >> tabSelector [

	^ tabSelector
]

{ #category : #accessing }
GLMTabLabelBrick >> tabSelector: anObject [

	tabSelector := anObject
]
