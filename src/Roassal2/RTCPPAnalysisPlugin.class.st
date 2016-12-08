Class {
	#name : #RTCPPAnalysisPlugin,
	#superclass : #RTAbstractPlugin,
	#category : #'Roassal2-PluginsAndScripts'
}

{ #category : #hooks }
RTCPPAnalysisPlugin >> description [
	^ 'Load a simple model for analyzing C and CPP source code application'
]

{ #category : #hooks }
RTCPPAnalysisPlugin >> execute [
	Gofer new 
		smalltalkhubUser: 'ObjectProfile' project: 'Roassal2';
		package: 'Roassal2-Plugins-CProjectVisualizer'; 
		load.
]

{ #category : #hooks }
RTCPPAnalysisPlugin >> label [
	^ 'Load a simple C and C++ analyzer'
]
