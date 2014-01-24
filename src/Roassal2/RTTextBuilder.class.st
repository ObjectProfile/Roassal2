Class {
	#name : #RTTextBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'wordHook',
		'wordInteractionBuilder',
		'wordShapeBuilder'
	],
	#category : #'Roassal2-Builder-TextBuilder'
}

{ #category : #protocol }
RTTextBuilder >> addText: aText [
	^ self buildText: aText.
]

{ #category : #protocol }
RTTextBuilder >> buildText: aText [
	| el |
	el := shapeBuilder elementOn: nil.
	view add: el.
	self buildText: aText in: el.
	^ el
]

{ #category : #protocol }
RTTextBuilder >> buildText: aString in: element [
	| elements lines normalizedString |
	normalizedString := self normalizeString: aString.
	lines := RTGroup new.
	elements := OrderedCollection new.
	normalizedString lineIndicesDo: [ :startLine :endLine :endLineWithEOL | 
		| line lineString |
		lineString := normalizedString copyFrom: startLine to: endLine.
		line := RTGroup new.
		lineString substringsDo: [ :startWord :endWord :endWordWithSpaces | 
			| wordString wordElement |
			wordString := lineString copyFrom: startWord to: endWordWithSpaces.
			wordElement := wordShapeBuilder elementOn: wordString.
			wordHook value: wordElement value: ((startLine + startWord) to: (startLine + endWord)).
			wordInteractionBuilder setUpElements: wordElement.
			line add: wordElement.
			elements add: wordElement.
			view add: wordElement.
		].
		RTHorizontalLineLayout new gapSize: 0; on: line.
		lines add: line.
	].
	RTVerticalLineLayout new gapSize: 0; on: lines.
	RTNest new on: element nest: elements.
]

{ #category : #examples }
RTTextBuilder >> example01Highlighting [
	"
	self new example01Highlighting
	"

	| builder |
	builder := RTTextBuilder new.
	builder wordInteraction highlightColored: Color blue.
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
	builder wordInteraction  
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
	builder shape rectangle withBorder; color: (Color purple alpha: 0.2).
	builder wordShape color: Color yellow.
	builder wordInteraction  
					highlight;
					when: TRMouseClick do: [ :event | event element model inspect ].
	builder addText: (RTTextBuilder>>#example03ShowCode) getSource.
	builder open
]

{ #category : #examples }
RTTextBuilder >> example04ShowCodeAsBoxes [
	"
	self new example04ShowCodeAsBoxes
	"

	| builder |
	builder := RTTextBuilder new.
	builder shape rectangle withBorder color: (Color white alpha: 0.2).		
	builder wordShape rectangle 
								height: 3; 
								width: [ :model | model size + 3 ];
								color: Color yellow.
	builder wordInteraction  
					highlight;
					popup;
					when: TRMouseClick do: [ :event | event element model inspect ].
	builder addText: (RTTextBuilder>>#example03ShowCode) getSource.
	builder open
]

{ #category : #initialization }
RTTextBuilder >> initialize [

	super initialize.
	wordShapeBuilder := RTShapeBuilder new.
	wordShapeBuilder text.
	wordInteractionBuilder := RTInteractionBuilder new.
	wordHook := [ :anElement :anInterval | nil ].
]

{ #category : #protected }
RTTextBuilder >> normalizeString: aString [

	^ String streamContents: [ :aStream |
		aString do: [ :eachChar |
			eachChar = Character tab
				ifTrue: [ aStream nextPutAll: '       ' ]
				ifFalse: [ aStream nextPut: eachChar ]
			 ]		
	]
]

{ #category : #hooks }
RTTextBuilder >> renderIn: aView [
	
]

{ #category : #accessing }
RTTextBuilder >> wordHook: aTwoArgBlock [

	wordHook := aTwoArgBlock
]

{ #category : #accessing }
RTTextBuilder >> wordInteraction [
	^ wordInteractionBuilder
]

{ #category : #accessing }
RTTextBuilder >> wordShape [
	^ wordShapeBuilder
]
