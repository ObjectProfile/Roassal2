Class {
	#name : #RTResize,
	#superclass : #RTAbstractElementHandling,
	#category : #'Roassal2-Core'
}

{ #category : #'accessing - computed' }
RTResize >> biggestExtent [
	fixedElement ifNotNil: [ ^ fixedElement extent ].
	^ elements inject: 0 @ 0 into: [ :maxExtent :e | 
			maxExtent max: e extent ] 
]

{ #category : #public }
RTResize >> sameHeight [
	elements do: [ :e | e height: self fixedElement height ]
]

{ #category : #public }
RTResize >> sameSize [
	elements do: [ :e | e extent: self fixedElement extent ]
]

{ #category : #public }
RTResize >> sameWidth [
	elements do: [ :e | e width: self fixedElement width ]
]
