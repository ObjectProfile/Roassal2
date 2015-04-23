Extension { #name : #TestCase }

{ #category : #'*roassal2-core' }
TestCase class >> visualworksName [
	^ self == TestCase ifTrue: ['XProgramming.SUnit.TestCase'] ifFalse: [self name]
]
