Extension { #name : #RTObject }

{ #category : #'*Roassal2GT-Examples' }
RTObject class >> gtExamplesFactory [
	^ RTExampleFactory new
		source: self;
		yourself
]
