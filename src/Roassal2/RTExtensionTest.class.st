Class {
	#name : #RTExtensionTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Tests'
}

{ #category : #tests }
RTExtensionTest >> testIsReferencedBy [

	self deny: (Halt superclass isReferencedBy: self class).
	self assert: (Halt isReferencedBy: Object)
]
