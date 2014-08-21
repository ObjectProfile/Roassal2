Class {
	#name : #RTTextBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'hook',
		'wordHook',
		'wordInteractionBuilder',
		'wordShapeBuilder',
		'padding'
	],
	#category : 'Roassal2-Builder-TextBuilder'
}

{ #category : #protocol }
RTTextBuilder >> addText: aText [
	^ self buildText: aText.
]

{ #category : #protocol }
RTTextBuilder >> addText: aText model: anObject [
	^ self buildText: aText model: anObject.
]

{ #category : #protocol }
RTTextBuilder >> buildText: aText [
	^ self buildText: aText model: aText.
]

{ #category : #protocol }
RTTextBuilder >> buildText: aString in: element [
	| elements lines |
	lines := RTGroup new.
	elements := RTGroup new.
	aString lineIndicesDo: [ :startLine :endLine :endLineWithEOL | 
		| line lineString wordStrings startWord endWord |
		lineString := aString copyFrom: startLine to: endLine.
		line := RTGroup new.
		wordStrings := lineString findTokens: Character separators keep: Character separators. 
		startWord := 0.
		wordStrings do: [ :wordString | |  wordElement |
			endWord := startWord + wordString size.
			wordElement := RTElement on: (self normalizeString: wordString).
			wordHook value: wordElement value: ((startLine + startWord) to: (startLine + endWord - 1)).
			wordShapeBuilder setUpElements: wordElement.
			wordInteractionBuilder setUpElements: wordElement.
			line add: wordElement.
			elements add: wordElement.
			view add: wordElement.
			startWord := endWord.
		].
		RTHorizontalLineLayout new gapSize: 0; on: line.
		lines add: line.
	].
	RTVerticalLineLayout new gapSize: 0; on: lines.
	RTNest new padding: padding; on: element nest: elements.
	element attributeAt: self nestedElementsAttribute put: elements.
	^ elements
]

{ #category : #protocol }
RTTextBuilder >> buildText: aText model: anObject [
	| el |
	el := RTElement on: anObject.
	hook value: el.
	shapeBuilder setUpElements: el.
	interactionBuilder setUpElements: el.
	view add: el.
	self buildText: aText in: el.
	^ el
]

{ #category : #accessing }
RTTextBuilder >> hook: aOneArgBlock [
	hook := aOneArgBlock
]

{ #category : #initialization }
RTTextBuilder >> initialize [

	super initialize.
	wordShapeBuilder := RTShapeBuilder new.
	wordShapeBuilder text.
	wordInteractionBuilder := RTInteractionBuilder new.
	wordHook := [ :anElement :anInterval | nil ].
	hook := [ :anElement | nil ].
	padding := 5.
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

{ #category : #accessing }
RTTextBuilder >> padding [
	^ padding
]

{ #category : #accessing }
RTTextBuilder >> padding: aNumber [
	padding := aNumber
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
