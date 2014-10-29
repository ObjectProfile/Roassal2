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
	b
		extent: 600@350;
		nodes: (1 to: 76);
		edgesFromAssociations: ((1 to: 76) collect: [:n | (n //10) -> n]);
		weight: [:el | el].
	
	b open.
]

{ #category : #examples }
RTTreeMapExample >> example02 [
	"
	self new example02
	"
	| b |
	b := RTTreeMapBuilder new.
	b
		extent: 400@400;
		nodes: (1 to: 76);
		edgesFromAssociations: ((1 to: 76) collect: [:n | (n //10) -> n]);
		weight: [:el | el].
	
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
		nodes: (1 to: 76);
		edgesFromAssociations: ((1 to: 76) collect: [:n | (n //10) -> n]);
		weight: [:n | n].
	b shape 
		if: [:n | n even ] fillColor: Color lightGray;
		if: [ :n | n odd ] fillColor: Color purple.
		
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
		nodes: (RTShape withAllSubclasses);
		edgesFrom: #superclass toAll: #yourself;
		weight: [:el | el numberOfMethods ].
	
	b open.
]

{ #category : #examples }
RTTreeMapExample >> example05 [
	"
	self new example05
	"
	| b |
	b := RTTreeMapBuilder new.
	b
		extent: 400@400;
		nodes: (RTShape withAllSubclasses);
		edgesFrom: #superclass toAll: #yourself;
		weight: [:el | el numberOfMethods ].
		
	b shape 
		if: [ :cls| Smalltalk includesKey: (cls name,'Test') asSymbol ] fillColor: Color lightGreen;
		if: [ :cls | cls name endsWith: 'Line' ] fillColor: Color purple;
		if: [ :cls | cls hasAbstractMethods ] fillColor: Color red.
	b popup text: [ :cls | cls name, ' number of methods: ', cls numberOfMethods asString ].
		
	b open.
]

{ #category : #examples }
RTTreeMapExample >> example06 [
	"
	self new example06
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
