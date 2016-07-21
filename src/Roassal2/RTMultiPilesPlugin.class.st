Class {
	#name : #RTMultiPilesPlugin,
	#superclass : #RTAbstractPlugin,
	#category : #'Roassal2-Plugins'
}

{ #category : #hooks }
RTMultiPilesPlugin >> description [
	^ 'MultiPile support'
]

{ #category : #hooks }
RTMultiPilesPlugin >> execute [
	Gofer new 
		smalltalkhubUser: 'AlisonFernandez' project: 'MultiPiles';
		package: 'MultiPiles'; 
		load.

]

{ #category : #hooks }
RTMultiPilesPlugin >> label [
	^ 'Load Small MultiPiles'
]
