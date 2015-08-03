Class {
	#name : #RTNeoPlugin,
	#superclass : #RTAbstractPlugin,
	#category : #'Roassal2-Plugins'
}

{ #category : #'as yet unclassified' }
RTNeoPlugin >> description [
	^ 
'Neo offers a JSON and CSV parsers. Both parsers are highly stable, fast, and well supported.'
]

{ #category : #'as yet unclassified' }
RTNeoPlugin >> execute [
	Gofer new 
		smalltalkhubUser: 'SvenVanCaekenberghe' project: 'Neo';
		package: 'ConfigurationOfNeoJSON'; load.
	(Smalltalk at: #ConfigurationOfNeoJSON) loadBleedingEdge.
	
	Gofer new 
		smalltalkhubUser: 'SvenVanCaekenberghe' project: 'Neo';
		package: 'ConfigurationOfNeoCSV'; load.
	(Smalltalk at: #ConfigurationOfNeoCSV) loadBleedingEdge.
]

{ #category : #'as yet unclassified' }
RTNeoPlugin >> label [
	^ 'Neo JSON and CSV parser'
]
