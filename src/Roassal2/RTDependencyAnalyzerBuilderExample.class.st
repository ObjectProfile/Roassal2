Class {
	#name : #RTDependencyAnalyzerBuilderExample,
	#superclass : #RTObject,
	#category : #'Roassal2-Builder-DependencyAnalyzer'
}

{ #category : #'as yet unclassified' }
RTDependencyAnalyzerBuilderExample >> collections [
	"
	self new collections
	"

	| b |
	b := RTDependencyAnalyzerBuilder new. 
	b shape circle
				size: 10;
				color: [ :cls |  
								('*Array*' match: cls name) 
									ifTrue: [ (Color purple alpha: 0.3) ]
									ifFalse: [ (Color red alpha: 0.3) ] ].
	b addClasses: Collection withAllSubclasses.
	b open
]
