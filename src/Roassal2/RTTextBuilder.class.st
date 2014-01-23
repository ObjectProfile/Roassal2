Class {
	#name : #RTTextBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'wordHook'
	],
	#category : #'Roassal2-Builder-TextBuilder'
}

{ #category : #protocol }
RTTextBuilder >> addText: aText [
	| el |
	el := self buildText: aText.
	view add: el.
	^ el
]

{ #category : #protocol }
RTTextBuilder >> buildText: aText [
	| el |
	el := RTElement new.
	shapeBuilder elementOn: el.
	self buildText: aText in: el.
	^ el
]

{ #category : #protocol }
RTTextBuilder >> buildText: aString in: element [
	| lines |
	lines := RTGroup new.
	aString lineIndicesDo: [ :startLine :endLine :endLineWithEOL | 
		| line lineString |
		lineString := aString copyFrom: startLine to: endLine.
		line := RTGroup new.
		lineString substringsDo: [ :startWord :endWord :endWordWithSpaces | 
			| wordString wordElement |
			wordString := lineString copyFrom: startWord to: endWordWithSpaces.
			wordElement := RTElement on: wordString. 
			wordElement + RTLabel new. "TODO: use shape builder"
			wordHook value: wordElement value: ((startLine + startWord) to: (startLine + endWord)).
			interactionBuilder setUpElements: wordElement.
			line add: wordElement.
			view add: wordElement.
		].
		RTHorizontalLineLayout new gapSize: 0; on: line.
		lines add: line.
	].
	RTVerticalLineLayout new gapSize: 0; on: lines.
	RTNest new on: element nest: lines.
]

{ #category : #examples }
RTTextBuilder >> example01Highlighting [
	"
	self new exampleHighlighting
	"

	| builder |
	builder := RTTextBuilder new.
	builder interaction highlightColored: Color blue.
	builder addText: 'hello world'.
	builder open
]

{ #category : #examples }
RTTextBuilder >> example02ClickableWord [
	"
	self new example02ClickableWord
	"

	| builder |
	builder := RTTextBuilder new.
	builder interaction  
					highlightColored: Color blue;
					when: TRMouseClick do: [ :event | event element model inspect ].
	builder addText: 'hello world', String cr, 'hola mundo'.
	builder open
]

{ #category : #examples }
RTTextBuilder >> example03ShowCode [
	"
	self new example03ShowCode
	"

	| builder |
	builder := RTTextBuilder new.
	builder interaction  
					highlight;
					when: TRMouseClick do: [ :event | event element model inspect ].
	builder addText: (RTTextBuilder>>#example03ShowCode) getSource.
	builder open
]

{ #category : #initialization }
RTTextBuilder >> initialize [

	super initialize.
	wordHook := [ :anElement :anInterval | nil ].
]

{ #category : #hooks }
RTTextBuilder >> renderIn: aView [
	
]

{ #category : #accessing }
RTTextBuilder >> wordHook: aTwoArgBlock [

	wordHook := aTwoArgBlock
]
