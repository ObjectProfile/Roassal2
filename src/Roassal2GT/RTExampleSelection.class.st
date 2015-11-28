Class {
	#name : #RTExampleSelection,
	#superclass : #GTExample,
	#category : #'Roassal2GT-Inspector'
}

{ #category : #examples }
RTExampleSelection class >> gtExampleAtRandom [
	<gtExample>
	<label: 'Random example'>
	
	^ RTAbstractExample subclasses atRandom new gtExamples atRandom
]

{ #category : #examples }
RTExampleSelection class >> gtExampleFlags1 [
	<gtExample>
	<label: 'Example flags 1'>
	
	^ RTComposedShapeExample gtExamples
		detect: [ :example | example method selector = #exampleFlags ]
		ifNone: [ nil ]
]

{ #category : #examples }
RTExampleSelection class >> gtExampleFlags2 [
	<gtExample>
	<label: 'Example flags 2'>
	
	^ (RTComposedShapeExample >> #exampleFlags) gtExamples first
]

{ #category : #examples }
RTExampleSelection class >> gtExampleFlags3 [
	<gtExample>
	<label: 'Example flags 3'>
	
	^ (RTComposedShapeExample >> #exampleFlags) gtExample
]

{ #category : #ui }
RTExampleSelection >> gtDisplayPlaygroundIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite pharoScript
		title: 'Playground';
		format: [ self playgroundSourceCode ];
		act: [ :text :page |
				text selectionInterval: (1 to: text text size).
				text evaluateSelectionAndDo: [ :anObject | text selection: anObject ] ]
			icon: GLMUIThemeExtraIcons glamorousGo
			on: $g
			entitled: 'Do it all and go (g)'
		
]

{ #category : #ui }
RTExampleSelection >> gtInspectorRoassalViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	| returnValue |
	returnValue := self returnValue. " rt examples are no longer cached - we make a speed bump here "
	((Array with: RTView with: RTBuilder) noneSatisfy: [ :c | returnValue class includesBehavior: c ])
		ifTrue: [ ^ self ].
	composite roassal2
		title: 'Canvas';
		initializeView: [ returnValue ]
		
]

{ #category : #ui }
RTExampleSelection >> gtInspectorViewIn: composite [
	self deprecated: 'Please use #gtInspectorRoassalViewIn: instead'.
	^ self gtInspectorRoassalViewIn: composite
]

{ #category : #'*Roassal2GT-Spotter' }
RTExampleSelection >> gtSpotterPreviewIconIn: aComposite [
	<spotterPreview: 10>
	(self icon notNil or: [ self provider class canPerform: (self selector, 'Icon') asSymbol ])
		ifTrue: [ 
			aComposite addBrickBack: (self icon asAlphaImageMorph
				layout: #center;
				scale: 2.0) asBrick ]

	
]

{ #category : #accessing }
RTExampleSelection >> icon [
	form ifNil: [ self initializeIcon ].
	^ form
]

{ #category : #public }
RTExampleSelection >> iconForm [
	self deprecated: 'Please use #icon'.
	^ self icon
]

{ #category : #testing }
RTExampleSelection >> ignoreCache [
	^ true
]

{ #category : #public }
RTExampleSelection >> initializeIcon [
	| icon64Mime iconSelector |
	form ifNotNil: [ ^ self ].
	iconSelector := (self method selector, 'Icon') asSymbol.
	(self provider canPerform: iconSelector) ifFalse: [ ^ self ].
	icon64Mime := [ self provider perform: iconSelector ]
		on: Error
		do: [ ^ self ].
	form := [ TRPlatform current formClass fromBinaryStream: 
			(TRPlatform current mimeDecodeToBytes: icon64Mime readStream) ]
		on: Error
		do: [ ^ self ].
]

{ #category : #'*Roassal2GT-Spotter' }
RTExampleSelection >> matchesQuery: aSetOfNames [
	| sourceCode |
	
	sourceCode := self method sourceCode asLowercase.
	^ aSetOfNames allSatisfy: [ :each | sourceCode includesSubstring: each ]

]

{ #category : #public }
RTExampleSelection >> playgroundSourceCode [ 
	" this is really ugly - we would like to perfectly preserve the original format including comments BUT with pragmas stripped - is there a better way ? original code below "
	^ self method parseTree body formattedCodeWithMaxLineLength: 999
	"
	| sourceCode firstLine sourceCodeWithoutFirstLine |
	sourceCode := self method sourceCode.
	firstLine := sourceCode lines first.
	sourceCodeWithoutFirstLine := sourceCode copyFrom: firstLine size + 1 to: sourceCode size.
	^ sourceCodeWithoutFirstLine 
	"
]

{ #category : #'*Roassal2GT-Spotter' }
RTExampleSelection >> spotterPreviewExampleIn: aComposite [
	self deprecated: 'Please use #gtSpotterPreviewIconIn: instead'>
	self gtSpotterPreviewIconIn: aComposite
	
]
