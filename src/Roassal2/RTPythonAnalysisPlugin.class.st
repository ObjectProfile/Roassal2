Class {
	#name : #RTPythonAnalysisPlugin,
	#superclass : #RTAbstractPlugin,
	#category : #'Roassal2-Plugins'
}

{ #category : #hooks }
RTPythonAnalysisPlugin >> description [
	^ 'Load a simple model for analyzing C and CPP source code application'
]

{ #category : #hooks }
RTPythonAnalysisPlugin >> execute [
	Gofer new 
		smalltalkhubUser: 'ObjectProfile' project: 'Roassal2';
		package: 'Roassal2-Plugins-PythonAnalyzer'; 
		load.
]

{ #category : #testing }
RTPythonAnalysisPlugin >> isLoaded [
	^ RPackageOrganizer default includesPackageNamed: 'Roassal2-Plugins-PythonAnalyzer'
]

{ #category : #hooks }
RTPythonAnalysisPlugin >> label [
	^ 'simple Python analyzer'
]
