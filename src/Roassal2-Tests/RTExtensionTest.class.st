Class {
	#name : #RTExtensionTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Tests-ShapesAndBuilder'
}

{ #category : #tests }
RTExtensionTest >> testIsReferencedBy [

	self deny: (String superclass isReferencedBy: self class).
	self assert: (String isReferencedBy: Object)
]
