"
A RTTextBuilderExamples has examples of RTTextBuilder class.

"
Class {
	#name : #RTTextBuilderExamples,
	#superclass : #RTObject,
	#category : #'Roassal2-Builder-TextBuilder'
}

{ #category : #examples }
RTTextBuilderExamples >> example01Highlighting [
	"
	self new example01Highlighting
	"

	| builder |
	builder := RTTextBuilder new.
	builder wordInteraction highlightColored: Color blue.
	builder addText: 'hello world'.
	^ builder open
]

{ #category : #examples }
RTTextBuilderExamples >> example02ClickableWord [
	"
	self new example02ClickableWord
	"

	| builder |
	builder := RTTextBuilder new.
	builder wordInteraction  
					highlightColored: Color blue;
					when: TRMouseClick do: [ :event | event element model inspect ].
	builder addText: 'hello world', String cr, 'hola mundo'.
	^ builder open
]

{ #category : #examples }
RTTextBuilderExamples >> example03ShowCode [
	"
	self new example03ShowCode
	"

	| builder |
	builder := RTTextBuilder new.
	builder shape rectangle withBorder; color: (Color gray alpha: 0.2).
	builder wordShape color: Color brown.
	builder wordInteraction  
					highlight;
					when: TRMouseClick do: [ :event | event element model inspect ].
	builder addText: (RTTextBuilderExamples >> #example03ShowCode) getSource.
	^ builder open
]

{ #category : #examples }
RTTextBuilderExamples >> example04ShowCodeAsBoxes [
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
	builder addText: (RTTextBuilderExamples>>#example04ShowCodeAsBoxes) getSource.
	^ builder open
]
