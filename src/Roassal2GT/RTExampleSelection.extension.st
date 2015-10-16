Extension { #name : #RTExampleSelection }

{ #category : #'*Roassal2GT-Spotter' }
RTExampleSelection >> gtSpotterPreviewIconIn: aComposite [
	<spotterPreview: 10>
	(self provider class canPerform: (self selector, 'Icon') asSymbol)
		ifTrue: [ 
			aComposite addBrickBack: (self iconForm asAlphaImageMorph
				layout: #center;
				scale: 2.0) asBrick ]

	
]

{ #category : #'*Roassal2GT-Spotter' }
RTExampleSelection >> matchesQuery: aSetOfNames [
	| sourceCode |
	
	sourceCode := self method sourceCode asLowercase.
	^ aSetOfNames allSatisfy: [ :each | sourceCode includesSubstring: each ]

]

{ #category : #'*Roassal2GT-Spotter' }
RTExampleSelection >> spotterPreviewExampleIn: aComposite [
	self deprecated: 'Please use #gtSpotterPreviewIconIn: instead'>
	self gtSpotterPreviewIconIn: aComposite
	
]
