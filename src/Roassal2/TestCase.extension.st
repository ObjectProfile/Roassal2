Extension { #name : #TestCase }

{ #category : #'*roassal2-exportervw' }
TestCase class >> visualworksName [
	^ self == TestCase ifTrue: ['Smalltalk.SUnit.TestCase'] ifFalse: [self name]
]
