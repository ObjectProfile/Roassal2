Extension { #name : #RTElement }

{ #category : #'*RoassalSpotterIntegration' }
RTElement >> spotterActDefault [
	RTBlink on: self.
	self view canvas camera translateTo: self position.
	self view signalUpdate
]
