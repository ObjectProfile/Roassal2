Class {
	#name : #RTShapeTest,
	#superclass : #RTTest,
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTShapeTest >> testElementCreation [

	| s |
	s := RTBox new.
	self assert: s element shape == s
]

{ #category : #'as yet unclassified' }
RTShapeTest >> testInstance [

	| s |
	self assert: RTBox instance class == RTBox.
	self assert: RTBox instance ~~ RTBox instance.
	
	s := RTBox instance.
	self assert: s instance == s.
]

{ #category : #'as yet unclassified' }
RTShapeTest >> testShapeCreation [

	self assert: RTBox element shape class == RTBox
]
