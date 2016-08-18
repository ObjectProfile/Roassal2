Extension { #name : #RTObject }

{ #category : #'*Roassal2GT-Examples' }
RTObject class >> gtExamplesFactory [
	^ RTExampleFactory new
		source: self;
		yourself
]

{ #category : #'*Roassal2GT-Inspector' }
RTObject class >> gtExamplesFinder [
	^ RTExampleFinder new
		source: self gtExamplesSource;
		provider: self gtExamplesProvider;
		subjects: self gtExamplesSubjects;
		yourself
]
