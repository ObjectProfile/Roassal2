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

Another example:
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
	hb highlightColor: Color white.
	hb filter: [ :obj | obj isBehavior ].
	hb addEntry: [ :cls | '*Array*' match: cls name ] named: 'Hide Array'.
	hb build.

b view
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
"
Class {
	#name : #RTHighlighterBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'entries',
		'fontSize',
		'filterModel',
		'filterElement',
		'highlightColor'
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
	h color: highlightColor.
	h edgeColor: highlightColor.
	el := RTLabel new height: fontSize; elementOn: entry value.
	el @ h.
	el
		when: TRMouseEnter
		do: [ :evt | 
			(self selectElements: entry key in: aView)
				do: [ :anElementToHighlight | h doHighlightElement: anElementToHighlight ] ].
	el
		when: TRMouseLeave
		do: [ :evt | 
			(self selectElements: entry key in: aView)
				do:
					[ :anElementToHighlight | h doUnhighlightElement: anElementToHighlight ] ].
	^ el
]

{ #category : #accessing }
RTHighlighterBuilder >> filter [
	"Return the filter used to apply the entries for the models. Initialized to true per default"
	^ filterModel
]

{ #category : #accessing }
RTHighlighterBuilder >> filter: aOneArgBlock [
	"Set the filter of the highlighter for the models. Could be for example [ :obj | obj class == Color ].
	In that case, all the entries will be applied to the Color contained in the view"
	filterModel := aOneArgBlock
]

{ #category : #accessing }
RTHighlighterBuilder >> filterElement [
	"Return the filter of the highlighter for elements. Could be for example [ :roassalElement | roassalElement shape class == RTLabel ]."
	^ filterElement
]

{ #category : #accessing }
RTHighlighterBuilder >> filterElement: aOneArgBlock [
	"Set the filter of the highlighter for the elements. Could be for example [ :roassalElement | roassalElement shape class == RTLabel ]."
	filterElement := aOneArgBlock
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

{ #category : #accessing }
RTHighlighterBuilder >> highlightColor [
	"Return the color to use for the highlight"
	^ highlightColor
]

{ #category : #accessing }
RTHighlighterBuilder >> highlightColor: aValueOrOneArgBlock [
	"Set the color to use for the highlight"
	highlightColor := aValueOrOneArgBlock
]

{ #category : #initialization }
RTHighlighterBuilder >> initialize [
	super initialize.
	entries := OrderedCollection new.
	filterModel := true.
	filterElement := true.
	fontSize := RTLabel defaultFontSize.
	highlightColor := Color red.
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
RTHighlighterBuilder >> selectElements: condition in: aView [
	"Return a list of elements based on the entry"
	^ aView elements
		select:
			[ :ee | (filterModel rtValue: ee model) and: [ (filterElement rtValue: ee) and: [ condition rtValue: ee model ] ] ]
]
