Class {
	#name : #CPPFolderTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Plugins-CProjectVisualizer'
}

{ #category : #tests }
CPPFolderTest >> testBasic [
	self assert: CPPFolder new numberOfFiles equals: 0
]
