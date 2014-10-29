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
		edges: ((1 to: 76) collect: [:n | (n //10) -> n]);
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
		edges: ((1 to: 76) collect: [:n | (n //10) -> n]);
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
		edges: ((1 to: 76) collect: [:n | (n //10) -> n]);
		weight: [:n | n].
	b shape 
		if: [:n | n even ] fillColor: Color lightGray;
		if: [ :n | n odd ] fillColor: Color purple.
		
	b open.
]
