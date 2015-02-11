Extension { #name : #Behavior }

{ #category : #'*Roassal2-Core' }
Behavior >> numberOfLinesOfCode [ 
	"Return the amount of lines of code"
	
	^ 5 + (self rtmethods inject: 0 into: [:sum :el | sum + el numberOfLinesOfCode ])
]

{ #category : #'*roassal2-exportervw' }
Behavior >> visualworksName [
	^ (#('WA' 'SU' 'CT') includes: (self name copyFrom: 1 to: 2))
		ifTrue: ['Seaside.', self name]
		ifFalse: [self name]
]
