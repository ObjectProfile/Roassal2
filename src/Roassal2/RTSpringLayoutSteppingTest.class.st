Class {
	#name : #RTSpringLayoutSteppingTest,
	#superclass : #RTTest,
	#category : 'Roassal2-Core'
}

{ #category : #tests }
RTSpringLayoutSteppingTest >> testAfterBlock [
	| t s |
	t := 0.
	s := RTSpringLayoutStepping new.
	s afterBlock: [ t := t + 1 ].
	self assert: t equals: 0.
	s refresh; refresh.
	self assert: t equals: 2.
]

{ #category : #tests }
RTSpringLayoutSteppingTest >> testBasic [

	| l |
	l := RTSpringLayoutStepping new.
	self deny: l hasCompleted.
	
]

{ #category : #tests }
RTSpringLayoutSteppingTest >> testBasic2 [

	RTSpringLayoutStepping new refresh
	
]

{ #category : #tests }
RTSpringLayoutSteppingTest >> testBasic3 [

	| v l |
	l := RTSpringLayoutStepping new.
	self assert: l nodes isEmpty.

	v := RTView new.
	v addAll: (RTBox elementsOn: (1 to: 2)).	
		
	l view: v.
	l layout: RTForceBasedLayout new.
	self assert: l nodes size = 2
	
	
]
