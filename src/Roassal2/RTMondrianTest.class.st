Class {
	#name : #RTMondrianTest,
	#superclass : #RTTest,
	#instVars : [
		'b'
	],
	#category : #'Roassal2-Builder-NewMondrian'
}

{ #category : #tests }
RTMondrianTest >> setUp [
	super setUp.
	b := RTMondrian new.
]

{ #category : #tests }
RTMondrianTest >> testBasic [
	| pos someNodes |
	someNodes := b nodes: (1 to: 5).
	b applyLayout.
	
	pos := b view canvas shapes collect: #position.
	self assert: pos asArray equals: ((Array new: 5) at: 1 put: ((2.5@2.5)); at: 2 put: ((17.5@2.5)); at: 3 put: ((32.5@2.5)); at: 4 put: ((47.5@2.5)); at: 5 put: ((62.5@2.5)); yourself).
	
	self assert: someNodes equals: b view elements
]

{ #category : #tests }
RTMondrianTest >> testBasicWithNesting [
	| result pos |
	b nodes: (1 to: 2) forEach: [ :nb | 
		b shape rectangle color: Color red.
		b nodes: (1 to: 3) ].

	b applyLayout.
	
	result := ((Array new: 8) at: 1 put: ((22.5@7.5)); at: 2 put: ((77.5@7.5)); at: 3 put: ((8.0@8.0)); at: 4 put: ((23.0@8.0)); at: 5 put: ((38.0@8.0)); at: 6 put: ((63.0@8.0)); at: 7 put: ((78.0@8.0)); at: 8 put: ((93.0@8.0)); yourself).
	
	pos := b view canvas shapes collect: #position.
	self assert: pos asArray equals: result
]

{ #category : #tests }
RTMondrianTest >> testBasicWithNestingAndDifferentSizeOfInner [
	| result pos |
	b nodes: (1 to: 2) forEach: [ :nb | 
		b shape rectangle 
			size: [ :aValue | aValue * 5 ];
			color: Color red.
		b nodes: (1 to: 3).
		b layout grid ].

	b applyLayout.
		
	result := ((Array new: 8) at: 1 put: ((15.0@20.0)); at: 2 put: ((50.0@20.0)); at: 3 put: ((7.5@7.5)); at: 4 put: ((20.0@10.0)); at: 5 put: ((12.5@27.5)); at: 6 put: ((42.5@7.5)); at: 7 put: ((55.0@10.0)); at: 8 put: ((47.5@27.5)); yourself).
	
	pos := b view canvas shapes collect: #position.
	self assert: pos asArray equals: result
]

{ #category : #tests }
RTMondrianTest >> testBasicWithNestingAndGridLayout [
	| result pos |
	b nodes: (1 to: 2) forEach: [ :nb | 
		b shape rectangle color: Color red.
		b nodes: (1 to: 3).
		b layout grid ].

	b applyLayout.
	
	result := ((Array new: 8) at: 1 put: ((12.5@12.5)); at: 2 put: ((42.5@12.5)); at: 3 put: ((8.0@8.0)); at: 4 put: ((18.0@8.0)); at: 5 put: ((8.0@18.0)); at: 6 put: ((38.0@8.0)); at: 7 put: ((48.0@8.0)); at: 8 put: ((38.0@18.0)); yourself).
	
	pos := b view canvas shapes collect: #position.
	self assert: pos asArray equals: result
]

{ #category : #tests }
RTMondrianTest >> testBasicWithNestingAndNesting [
	| result pos |
	b nodes: (1 to: 2) forEach: [ :nb | 
		b shape rectangle color: Color red.
		b nodes: (1 to: 3) forEach: [ :nb2 |
			b shape rectangle color: Color blue.
		b nodes: (1 to: 3) 
		].
		b layout grid ].

	b applyLayout.

	result := ((Array new: 26) at: 1 put: ((52.5@22.5)); at: 2 put: ((142.5@32.5)); at: 3 put: ((28.0@13.0)); at: 4 put: ((78.0@13.0)); at: 5 put: ((28.0@33.0)); at: 6 put: ((13.5@13.5)); at: 7 put: ((28.5@13.5)); at: 8 put: ((43.5@13.5)); at: 9 put: ((63.5@13.5)); at: 10 put: ((78.5@13.5)); at: 11 put: ((93.5@13.5)); at: 12 put: ((13.5@33.5)); at: 13 put: ((28.5@33.5)); at: 14 put: ((43.5@33.5)); at: 15 put: ((128.0@18.0)); at: 16 put: ((158.0@18.0)); at: 17 put: ((128.0@48.0)); at: 18 put: ((123.5@13.5)); at: 19 put: ((133.5@13.5)); at: 20 put: ((123.5@23.5)); at: 21 put: ((153.5@13.5)); at: 22 put: ((163.5@13.5)); at: 23 put: ((153.5@23.5)); at: 24 put: ((123.5@43.5)); at: 25 put: ((133.5@43.5)); at: 26 put: ((123.5@53.5)); yourself).
	
	pos := b view canvas shapes collect: #position.
	self assert: pos asArray equals: result
]
