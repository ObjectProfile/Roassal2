"
Test the class RTHighlitherBuilder
"
Class {
	#name : #RTHighlighterBuilderTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Builder-Highlighter'
}

{ #category : #tests }
RTHighlighterBuilderTest >> testBasic [ 
	| b hb highlighterElement el originalColor |
	b := RTMondrian new.
	b shape circle.
	b nodes: Collection withAllSubclasses.
	b edges connectFrom: #superclass.
	b layout tree.
	b normalizer normalizeSize: #numberOfMethods using: #sqrt.
	b build.

	hb := RTHighlighterBuilder new.
	hb filter: [ :obj | obj isBehavior ].
	hb view: b view.
	hb addEntry: [ :cls | '*Array*' match: cls name ] named: 'Array'.
	hb addEntry: [ :cls | '*Set*' match: cls name ] named: 'Set'.	
	hb addEntry: [ :cls | '*Hash*' match: cls name ] named: 'Hash'.
	hb addEntry: [ :cls | '*Dictionary*' match: cls name ] named: 'Dictionary'.
	hb build.

	"Check the number of entries"
	self assert: hb numberOfEntries equals: 4.

	"Check whether the highlight works properly"
	highlighterElement := b view elementFromModel: 'Array'.
	el := b view elementFromModel: Array.
	originalColor := el trachelShape color.
	highlighterElement announce: TRMouseEnter.
	self assert: originalColor ~= el trachelShape color.
	highlighterElement announce: TRMouseLeave.
	self assert: originalColor equals: el trachelShape color.
	
]

{ #category : #tests }
RTHighlighterBuilderTest >> testBasic2 [

	| hb |
	hb := RTHighlighterBuilder new.
	self assert: hb view notNil.
	self assert: hb numberOfEntries equals: 0.
	self assert: hb filter equals: true
]
