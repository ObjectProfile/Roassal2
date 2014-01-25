Class {
	#name : #RTTextBuilderTest,
	#superclass : #RTTest,
	#instVars : [
		'builder'
	],
	#category : #'Roassal2-Builder-TextBuilder'
}

{ #category : #tests }
RTTextBuilderTest >> fixme_testWordHighlight [
	| element text |
	builder := RTTextBuilder new.
	text := 'hello'.
	builder interaction highlightColored: Color blue.
	builder addText: text.
	element := builder view elementFromModel: text.
	self assert: element shape color = element shape defaultColor.
	element announce: (TRMouseEnter new shape: element trachelShape).
	self assert: element shape color = Color blue.
	element announce: (TRMouseLeave new shape: element trachelShape).
	self assert: element shape color = element shape defaultColor.
]

{ #category : #running }
RTTextBuilderTest >> setUp [
	builder := RTTextBuilder new
]

{ #category : #tests }
RTTextBuilderTest >> testAdditionalInformation [
	| text trigger elHello elWorld |
	text := 'hello world'.
	trigger := false.
	builder wordHook: [ :anElement :anInterval | 
								anElement model = 'hello ' 
									ifTrue: [ anElement attributeAt: #myValue put: 'value' ] ]. 
	builder interaction 
				when: TRMouseClick 
				do: [ :event | (event element hasAttribute: #myValue) 
										ifTrue: [ trigger := true ] ].
	builder addText: text.

	elHello := builder view elementFromModel: 'hello '.
	elWorld := builder view elementFromModel: 'world'.
	
	self assert: (elHello hasAttribute: #myValue).
	self deny: (elWorld hasAttribute: #myValue).
	self assert: (elHello attributeAt: #myValue) = 'value'.

	self deny: trigger.
	elHello announce: (TRMouseClick new shape: elHello trachelShape).
	self assert: trigger.
	
	trigger := false.
	self deny: trigger.
	elWorld announce: (TRMouseClick new shape: elWorld trachelShape).
	self deny: trigger.
	
]

{ #category : #tests }
RTTextBuilderTest >> testClickableWord [
	| t element |
	t := false.
	 
	builder interaction 
					when: TRMouseClick do: [ :event | t := true ].
	builder addText: 'hello'.
	self deny: t.
	
	element := builder view elementFromModel: 'hello'.
	element announce: TRMouseClick.
	self assert: t
]

{ #category : #tests }
RTTextBuilderTest >> testOpening [

	builder open close
]

{ #category : #tests }
RTTextBuilderTest >> testOpeningOnEmpty [
	self assert: builder view numberOfElements = 0
]

{ #category : #tests }
RTTextBuilderTest >> testOpeningOnMultilineText [
	| elements text |
	text := 'hello
world'.
	builder addText: text.
	elements := builder view elements.
	self assert: elements size = 3.
	self assert: (elements anySatisfy: [ :el | el model isNil ]).
	self assert: (elements anySatisfy: [ :el | el model = 'hello' ]).
	self assert: (elements anySatisfy: [ :el | el model = 'world' ]).
]

{ #category : #tests }
RTTextBuilderTest >> testOpeningOnMultilineText2 [
	| elements text |
	text := 'hello world
hola mundo'.
	builder addText: text.
	elements := builder view elements.
	self assert: elements size = 5.
	self assert: (elements anySatisfy: [ :el | el model isNil ]).
	self assert: (elements anySatisfy: [ :el | el model = 'hello ' ]).
	self assert: (elements anySatisfy: [ :el | el model = 'world' ]).
	self assert: (elements anySatisfy: [ :el | el model = 'hola ' ]).
	self assert: (elements anySatisfy: [ :el | el model = 'mundo' ]).
]

{ #category : #tests }
RTTextBuilderTest >> testOpeningOnMultilineText3 [
	| text |
	text := (RTTextBuilderTest >> #testOpeningOnMultilineText3) getSource.
	builder addText: text.
	builder open close.
]

{ #category : #tests }
RTTextBuilderTest >> testOpeningOnText [
	builder addText: 'hello world'.
	self assert: builder view numberOfElements = 3.
	
	builder addText: 'hello world'.
	self assert: builder view numberOfElements = 6.
]

{ #category : #tests }
RTTextBuilderTest >> testOpeningOnText2 [
	| elements text |
	text := 'hello world'.
	builder addText: text.
	elements := builder view elements.
	self assert: elements size = 3.
	self assert: (elements anySatisfy: [ :el | el model isNil ]).
	self assert: (elements anySatisfy: [ :el | el model = 'hello ' ]).
	self assert: (elements anySatisfy: [ :el | el model = 'world' ]).
]

{ #category : #tests }
RTTextBuilderTest >> testWordHighlight [
	| element text |
	builder := RTTextBuilder new.
	text := 'hello'.
	builder interaction highlightColored: Color blue.
	builder addText: text.
	element := builder view elementFromModel: text.
	self assert: element trachelShape color = element shape defaultColor.
	element announce: (TRMouseEnter new shape: element trachelShape).
	self assert: element trachelShape color = Color blue.
	element announce: (TRMouseLeave new shape: element trachelShape).
	self assert: element trachelShape color = element shape defaultColor.
]
