Class {
	#name : #RTFilterInViewTest,
	#superclass : #RTTest,
	#instVars : [
		'elements',
		'view',
		'filter'
	],
	#category : #'Roassal2-Tests-Interactions'
}

{ #category : #tests }
RTFilterInViewTest >> setUp [
	super setUp.
	
	view := RTView new.
	elements := RTBox elementsOn: (1 to: 9).
	view addAll: elements.
	RTGridLayout on: view elements.
	filter := RTFilterInView new.
	view @ filter
]

{ #category : #tests }
RTFilterInViewTest >> testBasic [

	| s |
	s := elements first trachelShape.
	self assert: s isMarkedAsVisible.
	self deny: s isHidden.
	s hide.
	self deny: s isMarkedAsVisible.
	self assert: s isHidden.
	
	filter reset.
	self assert: s isMarkedAsVisible.
	self deny: s isHidden.

]

{ #category : #tests }
RTFilterInViewTest >> testFiltering [
	| s s2 |
	s := (elements elementFromModel: 5) trachelShape.
	s2 := (elements elementFromModel: 4) trachelShape.
	self assert: s isVisible.
	self assert: s2 isVisible.
	filter filterOutUsing: '*5*'.
	self assert: s isHidden.
	self deny: s isMarkedAsVisible.
	self assert: s2 isVisible.
	
	
]

{ #category : #tests }
RTFilterInViewTest >> testKeepOnly [
	| s s2 |
	s := (elements elementFromModel: 5) trachelShape.
	s2 := (elements elementFromModel: 4) trachelShape.
	self assert: s2 isVisible.
	self assert: s isVisible.
	filter keepOnlyUsing: '*5*'.
	self assert: s2 isHidden.
	self deny: s2 isMarkedAsVisible.
	self assert: s isVisible.
	
	
]

{ #category : #tests }
RTFilterInViewTest >> testWithFixedShape [
	| fixedElement |
	fixedElement := (RTLabel new elementOn: 'hello') setAsFixed; yourself.
	view add: fixedElement.	
	self deny: (filter elementsToBeInspected includes: fixedElement).
	
	
]
