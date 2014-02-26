Extension { #name : #Color }

{ #category : #'*roassal2-Core' }
Color class >> gray256: intensity [
	"between 0 and 256"
	| i |
	i := intensity asFloat / 256.
	^ self r:  i g: i b: i 
]

{ #category : #'*roassal2-Core' }
Color class >> wheel: s alpha: a [
	^ (Color wheel: 6) collect: [:c | c alpha: a ].
]
