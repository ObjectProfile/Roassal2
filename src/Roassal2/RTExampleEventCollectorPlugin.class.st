Class {
	#name : #RTExampleEventCollectorPlugin,
	#superclass : #RTAbstractPlugin,
	#category : #'Roassal2-Plugins'
}

{ #category : #hooks }
RTExampleEventCollectorPlugin >> description [
	^ 
'Knowing which examples users are browsing is important for us, the developpers.
This plugin loads an event collector.'
]

{ #category : #hooks }
RTExampleEventCollectorPlugin >> execute [
	(Smalltalk globals includesKey: #GTEventCollector) ifFalse: [ 
		UIManager default abort: 'Plugin cannot be loaded. GTEventCollector not found'.
		^ self ].
	Gofer new 
		smalltalkhubUser: 'ObjectProfile' project: 'Roassal2';
		package: 'Roassal2EventCollector'; load.
]

{ #category : #hooks }
RTExampleEventCollectorPlugin >> label [
	^ 'Example event collector'
]
