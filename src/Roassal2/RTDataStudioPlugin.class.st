Class {
	#name : #RTDataStudioPlugin,
	#superclass : #RTAbstractPlugin,
	#category : #'Roassal2-PluginsAndScripts'
}

{ #category : #hooks }
RTDataStudioPlugin >> description [
	^ 
'Load extension of GT to support a flexible way to manipulate data.
Currently it is still very early work'
]

{ #category : #hooks }
RTDataStudioPlugin >> execute [
	Gofer new 
		smalltalkhubUser: 'ObjectProfile' project: 'DataStudio';
		package: 'DataStudio'; load.
]

{ #category : #hooks }
RTDataStudioPlugin >> label [
	^ 'Data Studio'
]
