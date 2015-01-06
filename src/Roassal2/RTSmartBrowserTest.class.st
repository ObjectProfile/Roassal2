Class {
	#name : #RTSmartBrowserTest,
	#superclass : #RTTest,
	#category : #'Roassal2-DataStudio'
}

{ #category : #tests }
RTSmartBrowserTest >> testBasic [
	| b win |
	b := RTSmartBrowser new.
	win := b open. 
	b addClassesMatching: '*Layout*'.
	win delete
]
