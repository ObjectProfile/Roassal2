Extension { #name : #RTObject }

{ #category : #'*Roassal2GT-Inspector' }
RTObject class >> gtExamplesFinder [
	^ RTExampleFinder new
		source: self gtExamplesSource;
		provider: self gtExamplesProvider;
		subjects: self gtExamplesSubjects;
		yourself
]
