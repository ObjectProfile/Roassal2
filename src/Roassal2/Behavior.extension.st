Extension { #name : #Behavior }

{ #category : #'*Roassal2-Core' }
Behavior >> numberOfLinesOfCode [ 
	"Return the amount of lines of code"
	
	^ 5 + (self methods inject: 0 into: [:sum :el | sum + el numberOfLinesOfCode ])
]
