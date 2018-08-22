Class {
	#name : #CPPFolderTest,
	#superclass : #RTTest,
	#category : #'DataStudio-CProjectVisualizer-Tests'
}

{ #category : #tests }
CPPFolderTest >> testBasic [
	self assert: CPPFolder new numberOfFiles equals: 0
]
