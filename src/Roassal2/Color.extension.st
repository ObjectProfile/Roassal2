Extension { #name : #Color }

{ #category : #'*Roassal2' }
Color class >> colorWheel: s alpha: a [
	^ (Color wheel: 6) collect: [:c | c alpha: a ].
]

{ #category : #'*Roassal2' }
Color class >> grayScale256: intensity [
	"between 0 and 256"
	| i |
	i := intensity asFloat / 256.
	^ self r:  i g: i b: i 
]
