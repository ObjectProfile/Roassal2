Class {
	#name : #RTKendrickPlugin,
	#superclass : #RTAbstractPlugin,
	#category : #'Roassal2-Plugins'
}

{ #category : #hooks }
RTKendrickPlugin >> description [
	^ 
'Kendrick is a modeling language and simulation platform, with an emphasis
on Epidemiological models. Kendrick has been used to model propagation of 
diseases, and in particular Ebola.'
]

{ #category : #hooks }
RTKendrickPlugin >> execute [
	Gofer new
	     url: 'http://smalltalkhub.com/mc/UMMISCO/Kendrick/main';
	     package: 'ConfigurationOfKendrick';
	     load.
	((Smalltalk at: #ConfigurationOfKendrick) project version: '0.14') load.
]

{ #category : #hooks }
RTKendrickPlugin >> label [
	^ 'Load Kendrick'
]
