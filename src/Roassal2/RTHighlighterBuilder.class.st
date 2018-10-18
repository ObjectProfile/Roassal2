"
I am a builder that add a widget to a view. The widget can be configured to give names and conditions. When the mouse goes above a name, elements contained in the view that match the condition are highlighted.

Here is an example:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
b := RTMondrian new.
b shape circle.
b nodes: Collection withAllSubclasses.
b edges connectFrom: #superclass.
b layout tree.
b normalizer normalizeSize: #numberOfMethods using: #sqrt.
b build.

	hb := RTHighlighterBuilder new.
	hb view: b view.
	hb filter: [ :obj | obj isBehavior ].
	hb addEntry: [ :cls | '*Array*' match: cls name ] named: 'Array'.
	hb addEntry: [ :cls | '*Set*' match: cls name ] named: 'Set'.	
	hb addEntry: [ :cls | '*Hash*' match: cls name ] named: 'Hash'.
	hb addEntry: [ :cls | '*Dictionary*' match: cls name ] named: 'Dictionary'.
	hb build.

b view
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
"
Class {
	#name : #RTHighlighterBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'entries',
		'filter',
		'fontSize'
	],
	#category : #'Roassal2-Builder-Highlighter'
}

{ #category : #public }
RTHighlighterBuilder >> addEntry: aOneArgBlock named: aName [
	"Add an entry to the highlihter. The first argument is a condition, applied on each element of a view (after been filtered). 
	aName is the name that appears in the widget"
	entries add: aOneArgBlock -> aName
]

{ #category : #private }
RTHighlighterBuilder >> createLabelFor: entry in: aView [
	"entry is aBlock->label and aView is the view where elements have to be searched"
	
	| h el |
	h := RTHighlightable new.
	h color: Color red.
	el := RTLabel new height: fontSize; elementOn: entry value.
	el @ (RTHighlightable new color: Color red).
	el
		when: TRMouseEnter
		do: [ :evt | 
			(self selectElements: entry in: aView)
				do: [ :anElementToHighlight | h doHighlightElement: anElementToHighlight ] ].
	el
		when: TRMouseLeave
		do: [ :evt | 
			(self selectElements: entry in: aView)
				do:
					[ :anElementToHighlight | h doUnhighlightElement: anElementToHighlight ] ].
	^ el
]

{ #category : #accessing }
RTHighlighterBuilder >> filter [
	"Return the filter used to apply the entries. Initialized to true per default"
	^ filter
]

{ #category : #accessing }
RTHighlighterBuilder >> filter: aOneArgBlock [
	"Set the filter of the highlighter. Could be for example [ :obj | obj class == Color ].
	In that case, all the entries will be applied to the Color contained in the view"
	filter := aOneArgBlock
]

{ #category : #accessing }
RTHighlighterBuilder >> fontSize [
	"Return the font size used in the builder to add labels"
	^ fontSize
]

{ #category : #accessing }
RTHighlighterBuilder >> fontSize: fontSizeAsInteger [
	"Set the font size used in the builder for the label"
	fontSize := fontSizeAsInteger
]

{ #category : #initialization }
RTHighlighterBuilder >> initialize [
	super initialize.
	entries := OrderedCollection new.
	filter := true.
	fontSize := RTLabel defaultFontSize
]

{ #category : #initialization }
RTHighlighterBuilder >> numberOfEntries [
	"Return the number of entries"
	^ entries size
]

{ #category : #hooks }
RTHighlighterBuilder >> renderIn: aView [
	| g el |
	g := RTGroup new.
	entries
		do: [ :entry | 
			"entry is aBlock->label"
			el := self createLabelFor: entry in: aView.
			g add: el ].
	RTHorizontalLineLayout new
		alignCenter;
		on: g.
	TRConstraint move: g below: aView elements.
	aView addAll: g.
	^ g
]

{ #category : #private }
RTHighlighterBuilder >> selectElements: entry in: aView [
	^ aView elements
		select:
			[ :ee | (filter rtValue: ee model) and: [ entry key rtValue: ee model ] ]
]
