Class {
	#name : #RTDependencyAnalyzerBuilderExample,
	#superclass : #RTObject,
	#category : #'Roassal2-Builder-DependencyAnalyzer'
}

{ #category : #examples }
RTDependencyAnalyzerBuilderExample >> collections [
	"
	self new collections
	"

	| b |
	b := RTDependencyAnalyzerBuilder new. 
	b shape circle
				size: 10;
				fillColor: (Color red alpha: 0.3);
				if: [ :cls | ('*Array*' match: cls name)  ] fillColor: (Color purple alpha: 0.3).
	b addClasses: Collection withAllSubclasses.			
	b open
]

{ #category : #examples }
RTDependencyAnalyzerBuilderExample >> collections2 [
	"
	self new collections2
	"

	| b |
	b := RTDependencyAnalyzerBuilder new. 
	b shape circle
				size: 10;
				fillColor: (Color red alpha: 0.3);
				if: [ :cls | ('*Array*' match: cls name)  ] fillColor: (Color purple alpha: 0.3).
	b addClasses: Collection withAllSubclasses.
	b 
		dependencyFromAllClassesMatching: [ :cls | ('*Array*' match: cls name) ] 
		toAllClassesMatching: [ :cls | ('*Array*' match: cls name) ].
	b open
]

{ #category : #examples }
RTDependencyAnalyzerBuilderExample >> roassalAndTrachel [
	"
	self new roassalAndTrachel
	"

	| b |
	b := RTDependencyAnalyzerBuilder new. 
	b shape circle
				size: 10;
				fillColor: (Color red alpha: 0.3);
				if: [ :cls | ('TR*' match: cls name)  ] fillColor: (Color purple alpha: 0.3).
	b addClasses: RTObject withAllSubclasses.
	b addClasses: TRObject withAllSubclasses.
	b 
		dependencyFromAllClassesMatching: [ :cls | ('RT*' match: cls name) ] 
		toAllClassesMatching: [ :cls | ('TR*' match: cls name) ].

	b open.
]

{ #category : #examples }
RTDependencyAnalyzerBuilderExample >> roassalAndTrachel2 [
	"
	self new roassalAndTrachel2
	"

	| b |
	b := RTDependencyAnalyzerBuilder new. 
	b shape circle
				size: 10;
				fillColor: (Color red alpha: 0.3);
				if: [ :cls | ('TR*' match: cls name)  ] fillColor: (Color purple alpha: 0.3).
	b addClasses: RTObject withAllSubclasses.
	b addClasses: TRObject withAllSubclasses.

	b open
]
