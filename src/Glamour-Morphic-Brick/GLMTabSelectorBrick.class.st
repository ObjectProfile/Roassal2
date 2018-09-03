"
A GLMTabSelectorBrick is a simplified TabSelectorMorph with support of smart tab resizing.
New implementation doesn't have any scrollbars or scroll arrows.

Instance Variables
	controls:		<Object>
	font:		<Object>
	selectedIndex:		<Object>
	tabs:		<Object>
	visibleTabRange:		<Object>
	wrapScrolling:		<Object>

controls
	- xxxxx

font
	- xxxxx

selectedIndex
	- xxxxx

tabs
	- xxxxx

visibleTabRange
	- xxxxx

wrapScrolling
	- xxxxx

"
Class {
	#name : #GLMTabSelectorBrick,
	#superclass : #GLMFoundationBrick,
	#instVars : [
		'selectedIndex',
		'visibleTabRange',
		'font',
		'tabs',
		'controls',
		'wrapScrolling'
	],
	#category : #'Glamour-Morphic-Brick-Morphic'
}

{ #category : #adding }
GLMTabSelectorBrick >> addTab: aStringOrMorph [
	"Add a new tab with the given text."
	
	self tabs add: (self newLabelMorph: aStringOrMorph).
	self updateTabs
]

{ #category : #adding }
GLMTabSelectorBrick >> addTab: aStringOrMorph selected: selectedStringOrMorph [
	"Add a new tab with the given text or morph and alternate for when selected."
	
	self tabs add: (self newLabelMorph: aStringOrMorph selected: selectedStringOrMorph).
	self updateTabs
]

{ #category : #rounding }
GLMTabSelectorBrick >> cornerStyle: aSymbol [
	"Pass to tabs also."

	super cornerStyle: aSymbol.
	self tabs do: [:t | t cornerStyle: aSymbol]
]

{ #category : #accessing }
GLMTabSelectorBrick >> font [
	"Answer the label font"

	^font
]

{ #category : #accessing }
GLMTabSelectorBrick >> font: aFont [
	"Set the label font"

	font == aFont ifTrue: [^self].
	font := aFont.
	self updateFont
]

{ #category : #'event handling' }
GLMTabSelectorBrick >> handlesKeyboard: evt [
	"Yes, we do it here."
	
	^true
]

{ #category : #initialization }
GLMTabSelectorBrick >> initialize [
	"Initialize the receiver."

	super initialize.
	selectedIndex := 0.
	self
		tabs: OrderedCollection new;
		roundedCorners: #(1 4);
		borderWidth: 0.
]

{ #category : #'event handling' }
GLMTabSelectorBrick >> keyStroke: event [ 
	"Process keys navigation and space to toggle."

	(self navigationKey: event) ifTrue: [^self].
	event keyCharacter = Character arrowLeft
		ifTrue: [self selectPreviousTab].
	event keyCharacter = Character arrowRight
		ifTrue: [self selectNextTab]
]

{ #category : #'event handling' }
GLMTabSelectorBrick >> keyboardFocusChange: aBoolean [
	"The message is sent to a morph when its keyboard focus changes.
	Update for focus feedback."
	super keyboardFocusChange: aBoolean.
	self focusChanged
]

{ #category : #layout }
GLMTabSelectorBrick >> minHeight [
	^ self theme buttonMinHeight
]

{ #category : #'instance creation' }
GLMTabSelectorBrick >> newLabelMorph: aStringOrMorph [
	"Answer a new label morph with the given label text."

	^GLMTabLabelBrick new
		roundedCorners: #(1 4);
		cornerStyle: self cornerStyle;
		label: aStringOrMorph;
		font: self font;
		on: #mouseDown send: #tabClicked:with: to: self;
		tabSelector: self
]

{ #category : #'instance creation' }
GLMTabSelectorBrick >> newLabelMorph: aStringOrMorph selected: selectedStringOrMorph [
	"Answer a new label morph with the given label text or morph and
	alternate when selected."

	^GLMTabLabelBrick new
		roundedCorners: #(1 4);
		cornerStyle: self cornerStyle;
		label: aStringOrMorph selected: selectedStringOrMorph;
		font: self font;
		on: #mouseDown send: #tabClicked:with: to: self;
		tabSelector: self
]

{ #category : #'as yet unclassified' }
GLMTabSelectorBrick >> relabelTab: aTab with: aStringOrMorph [
	"Relabel the tab update tab layout."

	aTab label: aStringOrMorph.
	aTab owner ifNotNil: [
		self updateTabs ]
]

{ #category : #'as yet unclassified' }
GLMTabSelectorBrick >> removeTabIndex: anInteger [
	"Remove the tab at the given index and
	adjust any selected (next or first if was last)."
	
	self tabs removeAt: anInteger.
	self selectedIndex: 0.
	self tabs ifNotEmpty: [
		self selectedIndex: self selectedIndex - 1 \\ self tabs size + 1]
		
]

{ #category : #'as yet unclassified' }
GLMTabSelectorBrick >> selectNextTab [
	"Select the next tab, or the first if none selected."
	
	self selectedIndex: self selectedIndex \\ self tabs size + 1
]

{ #category : #'as yet unclassified' }
GLMTabSelectorBrick >> selectPreviousTab [
	"Select the previous tab, or the last if none selected."
	
	self selectedIndex: (self selectedIndex < 2
		ifTrue: [self tabs size]
		ifFalse: [self selectedIndex - 1])
]

{ #category : #accessing }
GLMTabSelectorBrick >> selectedIndex [
	"Answer the value of selectedIndex"

	^ selectedIndex
]

{ #category : #accessing }
GLMTabSelectorBrick >> selectedIndex: index [
	"Set the value of selectedIndex"

	|oldIndex|
	selectedIndex == index ifTrue: [^self].
	oldIndex := selectedIndex.
	selectedIndex := (index min: self tabs size).
	self updateTabs.
	self changed: #selectedIndex with: oldIndex
]

{ #category : #accessing }
GLMTabSelectorBrick >> selectedTab [
	"Answer the selected tab."
	
	^self selectedIndex = 0
		ifFalse: [self tabs at: self selectedIndex ifAbsent: [nil]]
]

{ #category : #'as yet unclassified' }
GLMTabSelectorBrick >> tabClicked: evt with: aMorph [ 
	"A tab has been clicked."
	
	self selectedIndex: (self tabs indexOf: aMorph)
]

{ #category : #accessing }
GLMTabSelectorBrick >> tabs [

	^ tabs
]

{ #category : #accessing }
GLMTabSelectorBrick >> tabs: anObject [

	tabs := anObject
]

{ #category : #private }
GLMTabSelectorBrick >> updateFont [
	"Update the label font."

	self tabs do: [:t | t font: self font].
	self updateTabs
]

{ #category : #'as yet unclassified' }
GLMTabSelectorBrick >> updateTabs [
	"Update the submorphs based on visible tabs."

	|selectedTab|
	self removeAllBricks.
	self tabs ifEmpty: [^self].
	selectedTab := self selectedTab.
	self tabs do: [:t |
		t selected: (t == selectedTab).
		t layoutProperties horizontalPercent: 100 / self tabs size ].
	self
		addAllBricks: self tabs;
		adoptPaneColor.
	
	self doLayout.
]
