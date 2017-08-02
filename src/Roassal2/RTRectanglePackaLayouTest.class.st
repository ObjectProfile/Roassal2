Class {
	#name : #RTRectanglePackaLayouTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Layouts-Tests'
}

{ #category : #tests }
RTRectanglePackaLayouTest >> testBasic [

	| v es |
	v := RTView new.
	es := RTBox new size: 5; elementsOn: (1 to: 3).
	RTRectanglePackLayout on: es.
	v addAll: es.
	self assert: (es collect: #position) asArray equals:  ((Array new: 3) at: 1 put: ((9.0@3.0)); at: 2 put: ((3.0@3.0)); at: 3 put: ((3.0@9.0)); yourself)
]

{ #category : #tests }
RTRectanglePackaLayouTest >> testBasic02 [

	| v es |
	v := RTView new.
	es := RTBox new size: [ :n | n * 10 ]; elementsOn: (1 to: 3).
	RTRectanglePackLayout on: es.
	v addAll: es.
	self assert: (es collect: #position) asArray equals: ((Array new: 3) at: 1 put: ((31.0@41.0)); at: 2 put: ((12.0@46.0)); at: 3 put: ((17.0@17.0)); yourself)
]

{ #category : #tests }
RTRectanglePackaLayouTest >> testBasic03WithOnlyTwoElements [

	| v es |
	v := RTView new.
	es := RTBox new size: [ :n | n * 10 ]; elementsOn: (1 to: 2).
	RTRectanglePackLayout on: es.
	v addAll: es.
	self assert: (es collect: #position) asArray equals: ((Array new: 2) at: 1 put: ((35@5)); at: 2 put: ((10@10)); yourself)
]

{ #category : #tests }
RTRectanglePackaLayouTest >> testBasic04WithOnlyOneElement [

	| v es |
	v := RTView new.
	es := RTBox new size: [ :n | n * 10 ]; elementsOn: (1 to: 1).
	RTRectanglePackLayout on: es.
	v addAll: es.
	self assert: (es collect: #position) asArray equals: ((Array new: 1) at: 1 put: ((5@5)); yourself)
]
