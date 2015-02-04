Extension { #name : #GLMPhlowDestination }

{ #category : #'*Glamour-Morphic-Brick' }
GLMPhlowDestination >> phlowValue: anObject value: anotherObject [

	self port phlowValue: (self phlowObject phlowValue: anotherObject) value: anObject
	
]
