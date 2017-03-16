Class {
	#name : #RTVerticalMultipleData,
	#superclass : #RTAbstractMultipleData,
	#category : #'Roassal2-Builder-Grapher-Core'
}

{ #category : #adding }
RTVerticalMultipleData >> addedInBuilder: aBuilder [
	super addedInBuilder: aBuilder.
	"aBuilder axisX noLabel; noTick."
	
	elements := RTGroup new.
	points do: [ :p | 
		| values es |
		values := metrics collect: [ :m | m rtValue: p ].
		es := barBuilder elementsOn: values.
		es doWithIndex: [ :e :index | e trachelShape color: (self colorPalette at: index) ].
		groupedElements add: es.
		RTVerticalLineLayout on: es.
		elements addAll: es
		 ] separatedBy: [ elements add: ((RTBox new size: 0) elementOn: 0) ].
self halt.
	self addAll: elements
]
