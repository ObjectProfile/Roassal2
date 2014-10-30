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
		explore: TRShape using: #subclasses;
		weight: [:el | el numberOfMethods == 0 ifTrue: [ 1 ] ifFalse: [ el numberOfMethods ]  ].
	b open.
]

{ #category : #examples }
RTTreeMapExample >> example03 [
	"
	self new example03
	"
	| b |
	b := RTTreeMapBuilder new.
	b shape 
		if: [ :m| Smalltalk includesKey: (m theClass name,'Test') asSymbol ] fillColor: Color lightGreen;
		if: [ :m| m theClass hasAbstractMethods ] fillColor: Color red.
	
	b
		extent: 400@400;
		weight: [:m | m tally ].
	b explore: (MessageTally new
		spyEvery: 1
		on: [Nautilus open]; yourself)
		using: #children.
	b elements do: [ :e | e when: TRMouseClick do: [ :evt | e model inspect ] ].
	b open.
]

{ #category : #examples }
RTTreeMapExample >> example04 [
	"
	self new example04
	"
	| b |
	b := RTTreeMapBuilder new.
	b
		extent: 400@400;
		weight: [:n | n ].
	b shape if: [ :n | n even ] fillColor: Color blue;
		if: [ :n | n odd ] fillColor: Color lightGray.
		
	b from: (1 to: 10)
		using: [:n | n < 5 ifTrue: [ { n+1. n+2 } ] ifFalse: [ {  } ] ].
	b open.
]
