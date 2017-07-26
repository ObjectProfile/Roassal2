Class {
	#name : #RTSoftwareHeritagePlugin,
	#superclass : #RTAbstractPlugin,
	#category : #'Roassal2-Plugins'
}

{ #category : #hooks }
RTSoftwareHeritagePlugin >> description [
	^ 'Load a script for roassal helps you to explore data from SoftwareHeriatage'
]

{ #category : #hooks }
RTSoftwareHeritagePlugin >> execute [
	Gofer new 
		smalltalkhubUser: 'azazael' project: 'BeyondRoassal';
		package: 'softwareheritage'; 
		load.
]

{ #category : #hooks }
RTSoftwareHeritagePlugin >> isLoaded [
	^ RPackageOrganizer default includesPackageNamed: 'softwareheritage'
]

{ #category : #hooks }
RTSoftwareHeritagePlugin >> label [
	^ 'Software Heritage'
]
