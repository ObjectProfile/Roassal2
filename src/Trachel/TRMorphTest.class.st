Class {
	#name : #TRMorphTest,
	#superclass : #TRTest,
	#category : #'Trachel-MorphSpecific'
}

{ #category : #forwarding }
TRMorphTest >> testForward [

	| s1 s2 c morph |
	s1 := TRBoxShape new size: 10.	
	s2 := TREllipseShape new size: 10.
	c := TRCanvas new.
	
	c addShape: s1. 
	c addShape: s2.
	
	morph := TRMorph new
		canvas: c;
		extent: c extent.
	
	self assert: (c shapeForPosition: (0 @ 0)) == s2.
	
]

{ #category : #forwarding }
TRMorphTest >> testForward2 [

	| s1 s2 c morph |
	s1 := TRBoxShape new size: 10.	
	s2 := TREllipseShape new size: 10.
	c := TRCanvas new.
	
	c addShape: s1. 
	c addShape: s2.
	
	s1 when: TRMouseClick do: [ :e | ].
	
	morph := TRMorph new
		canvas: c;
		extent: c extent.
	
	self assert: (c shapeWithActionForPosition: (0 @ 0)) == s1.
	
]

{ #category : #forwarding }
TRMorphTest >> testForward3 [

	| s1 s2 c morph |
	s1 := TRBoxShape new size: 10.	
	s2 := TREllipseShape new size: 10.
	c := TRCanvas new.
	
	c addShape: s1. 
	c addShape: s2.
	
	morph := TRMorph new
		canvas: c;
		extent: c extent.
	
	self assert: (c shapeWithActionForPosition: (0 @ 0)) == c.
	
]

{ #category : #forwarding }
TRMorphTest >> testForward4 [

	| s c morph |
	s := TRBoxShape new size: 10.	
	c := TRCanvas new.
	c when: TRMouseMove do: [ :e | ].
	c addShape: s. 
	
	morph := TRMorph new
		canvas: c;
		extent: c extent.
	
	self assert: (c shapeWithActionForPosition: (0 @ 0)) == c.
	
]

{ #category : #event }
TRMorphTest >> testHandleEventClass [

	| t |
	t := TRBoxShape new.
	self deny: (t announcer handleEventClass: TRMouseClick).
	t when: TRMouseClick do: [ :evt | ].
	self assert: (t announcer handleEventClass: TRMouseClick).
	self deny: (t announcer handleEventClass: TRMouseClick new).
]

{ #category : #event }
TRMorphTest >> testHandleEventClass02 [

	| t |
	t := TRBoxShape new.
	self deny: (t announcer handleEventClass: TRMouseClick).
	t when: TRMouseClick do: [ :evt | ].
	self assert: (t announcer handleEventClass: TRMouseClick superclass).
	self deny: (t announcer handleEventClass: TRMouseClick new).
]

{ #category : #theme }
TRMorphTest >> testTheme01 [

	| m c |
	c := TRCanvas new.
	m := TRMorph new.
	m canvas: c.
	m setTheme.
	self assert: c theme notNil.
	
]

{ #category : #theme }
TRMorphTest >> testTheme02Failure [
	self should: [ TRMorph new setTheme ] raise: AssertionFailure.
	
]
