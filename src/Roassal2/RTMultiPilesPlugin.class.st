Class {
	#name : #RTMultiPilesPlugin,
	#superclass : #RTAbstractPlugin,
	#category : #'Roassal2-PluginsAndScripts'
}

{ #category : #hooks }
RTMultiPilesPlugin >> description [
	^ 'MultiPile support'
]

{ #category : #hooks }
RTMultiPilesPlugin >> execute [

	Metacello new
    configuration: 'OSSubprocess';
    repository: 'github://marianopeck/OSSubprocess:master/repository';
    version: #stable;
    load.

	Gofer new 
		smalltalkhubUser: 'abergel' project: 'GitLogExtractor';
		package: 'GitLogExtractor'; 
		load.


	Gofer new 
		smalltalkhubUser: 'AlisonFernandez' project: 'MultiPiles';
		package: 'MultiPiles'; 
		load.

]

{ #category : #hooks }
RTMultiPilesPlugin >> label [
	^ 'Load Small MultiPiles'
]
