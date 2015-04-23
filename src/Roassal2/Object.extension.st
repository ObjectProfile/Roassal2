Extension { #name : #Object }

{ #category : #'*Roassal2' }
Object >> rtValue: anArgument [ 
	^ self
]

{ #category : #'*roassal2-core' }
Object class >> visualworksName [
	(#('WA' 'SU' 'CT') includes: (self name copyFrom: 1 to: 2))
		ifTrue: [^'Seaside.', self name].
	^ self == Object ifTrue: ['Core.Object'] ifFalse: [self name]
]
