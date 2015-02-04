"
A GLMBrickAbstractAdaptor is an interface for all adaptors to be used with brick lazy widgets
"
Class {
	#name : #GLMBrickAbstractAdaptor,
	#superclass : #Object,
	#category : #'Glamour-Morphic-Brick-Model'
}

{ #category : #'adaptor api' }
GLMBrickAbstractAdaptor >> count [

	self subclassResponsibility
]

{ #category : #'adaptor api' }
GLMBrickAbstractAdaptor >> morphAt: anInteger convert: aMorph [

	self subclassResponsibility
]
