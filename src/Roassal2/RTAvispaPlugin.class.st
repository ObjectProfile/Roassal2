Class {
	#name : #RTAvispaPlugin,
	#superclass : #RTAbstractPlugin,
	#category : #'Roassal2-Plugins'
}

{ #category : #hooks }
RTAvispaPlugin >> description [
	^ 'Avispa is a tool to analyze Software Process Models, written with EPF Composer. 
You need run the Moose platform in order to use this pluggin.'
]

{ #category : #hooks }
RTAvispaPlugin >> execute [
	Gofer new
		smalltalkhubUser: 'abergel' project: 'Avispa';
		package: 'ProcessModel';
		load.

]

{ #category : #hooks }
RTAvispaPlugin >> label [
	^ 'Load Avispa'
]
