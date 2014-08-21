Class {
	#name : #RTGlobalBuilderTest,
	#superclass : #RTTest,
	#category : 'Roassal2-Builder-Common'
}

{ #category : #tests }
RTGlobalBuilderTest >> testBasic [

	| v b |
	v := RTView new.
	v addAll: ((RTEllipse new size: 5) elementsOn: (1 to: 10)).
	self assert: v numberOfElements equals: 10.
	
	self assert: v elements first trachelShape extent equals: 5 @ 5.
	
	b := RTGlobalBuilder view: v.
	b minSize: 15.
	b execute.
	
	self assert: v elements first trachelShape extent equals: 15 @ 15.
]

{ #category : #tests }
RTGlobalBuilderTest >> testBuilder [

	self assert: RTBuilder new global class == RTGlobalBuilder 
]

{ #category : #tests }
RTGlobalBuilderTest >> testMinMaxSize [

	| v b |
	v := RTView new.
	v addAll: ((RTEllipse new size: #yourself) elementsOn: (1 to: 10)).
	
	b := RTGlobalBuilder view: v.
	b normalizeSizeMin: 10 max: 100.
	b execute.
	
	self assert: v elements first trachelShape extent equals: 10 @ 10.
	self assert: v elements second trachelShape extent equals: 19 @ 19.
	self assert: v elements last trachelShape extent equals: 91 @ 91.
]
