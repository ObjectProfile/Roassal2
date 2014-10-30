"
Examples of RTTreeMap
"
Class {
	#name : #RTTreeMapExample,
	#superclass : #Object,
	#category : #'Roassal2-Builder-TreeMap'
}

{ #category : #examples }
RTTreeMapExample >> example01 [
	"
	self new example01
	"
	| b |
	b := RTTreeMapBuilder new.
	b shape 
		if: [:n | n even ] fillColor: Color lightGray;
		if: [ :n | n odd ] fillColor: Color purple.
	b
		extent: 400@400;
		explore: 1
		using: [ :n | n< 8 ifTrue: [{ n+1. n+2}] ifFalse: [ {  } ] ];
		weight: [:n | n].
	
	b open.
]

{ #category : #examples }
RTTreeMapExample >> example02 [
	"
	self new example02
	"
	| b |
	b := RTTreeMapBuilder new.
	b shape 
		if: [ :cls| Smalltalk includesKey: (cls name,'Test') asSymbol ] fillColor: Color lightGreen;
		if: [ :cls | cls name endsWith: 'Line' ] fillColor: Color purple;
		if: [ :cls | cls hasAbstractMethods ] fillColor: Color red.
	b popup text: [ :cls | cls name, ' number of methods: ', cls numberOfMethods asString ].
	
	b
		extent: 400@400;
		explore: RTShape using: #subclasses;
		weight: [:el | el numberOfMethods ].
	b open.
]

{ #category : #examples }
RTTreeMapExample >> example03 [
	"
	self new example03
	"
	| b |
	b := RTTreeMapBuilder new.
	b
		extent: 400@400;
		weight: [:m | m tally ].
	b explore: (MessageTally new
		spyEvery: 1
		on: [Nautilus open]; yourself)
		using: #children.
		
	b open.
]
