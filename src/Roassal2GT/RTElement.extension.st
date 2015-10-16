Extension { #name : #RTElement }

{ #category : #'*Roassal2GT-Spotter' }
RTElement >> spotterActDefault [
	self view canvas camera translateTo: self position.
	RTBlink on: self.
]
