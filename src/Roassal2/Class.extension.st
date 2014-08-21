Extension { #name : #Class }

{ #category : #'*roassal2' }
Class >> classReferences [
	| references |
	references := OrderedCollection new.
	self methodDict valuesDo: [ :compiledMethod |
			references addAll: compiledMethod classReferences ].
	^ references removeDuplicates
]

{ #category : #'*Roassal2' }
Class >> isReferencedBy: aClass [ 
	^ aClass classReferences includes: self 
]

{ #category : #'*Roassal2' }
Class >> referencedByClasses: aCollectionOfClasses [
	| references |
	references := OrderedCollection new.
	aCollectionOfClasses do: [ :eachClass |
		(self isReferencedBy: eachClass) 
			ifTrue: [ references add: eachClass ] ].
	^ references
]
