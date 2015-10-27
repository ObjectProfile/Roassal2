Class {
	#name : #RTExampleEventCollectorPlugin,
	#superclass : #RTAbstractPlugin,
	#category : #'Roassal2-Plugins'
}

{ #category : #'as yet unclassified' }
RTExampleEventCollectorPlugin >> description [
	^ 
'Knowing which examples users are browsing is important for us, the developpers.
This plugin loads an event collector.'
]

{ #category : #'as yet unclassified' }
RTExampleEventCollectorPlugin >> execute [
	(Smalltalk globals includesKey: #GTEventCollector) ifFalse: [ 
		UIManager default abort: 'Plugin cannot be loaded. GTEventCollector not found'.
		^ self ].
	Gofer new 
		smalltalkhubUser: 'ObjectProfile' project: 'Roassal2';
		package: 'Roassal2EventCollector'; load.
]
