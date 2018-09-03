Class {
	#name : #RTSmartBrowserTest,
	#superclass : #RTTest,
	#category : #Roassal2DataStudioObsolete
}

{ #category : #tests }
RTSmartBrowserTest >> testBasic [
	| b win |
	b := RTSmartBrowser new.
	win := b open. 
	b addClassesMatching: '*Layout*'.
	win delete
]
