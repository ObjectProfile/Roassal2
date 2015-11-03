Extension { #name : #CompiledMethod }

{ #category : #'*roassal2' }
CompiledMethod >> ageInDays [

	^ (DateAndTime now - self date) asDays
]

{ #category : #'*roassal2' }
CompiledMethod >> ageInDaysAsInteger [

	^ self ageInDays asInteger
]

{ #category : #'*roassal2' }
CompiledMethod >> ageInDaysRounded [
	^ self ageInDays rounded
]

{ #category : #'*roassal2' }
CompiledMethod >> computeDate [
	"Return the DateAndTime associated to this method"
	| s nbOfSpaces |
	s := self timeStamp.
	nbOfSpaces := s select: [ :c | c = $  ].
	nbOfSpaces size = 1
		ifTrue: [ ^ DateAndTime fromString: s ].

	nbOfSpaces size = 2
		ifTrue: [ ^ DateAndTime fromString: (s copyAfter: $ ) ].
]

{ #category : #'*roassal2' }
CompiledMethod >> date [
	"Return the DateAndTime associated to me"
	^ (self properties includesKey: #date)
		ifTrue: [ self properties at: #date ]
		ifFalse: [ 
			| m |
			m := self computeDate.
			self properties at: #date put: m.
			m ]
]

{ #category : #'*roassal2' }
CompiledMethod >> dateSinceEpoch [
	^ self date - DateAndTime dosEpoch
]

{ #category : #'*roassal2' }
CompiledMethod >> dependentClasses [
	"Return the list of classes used myself. The result contains my superclass."
	
	"(Morph>>#drawOn:) dependentClasses"
	| cll | 
	cll := Set new.
	
	"We unify a class and its metaclass"
	self literalsDo: [ :l | 
					"We also check if the method is not an extension"
					((l isVariableBinding 
					and: [ l value notNil ]) 
					and: [ l value isBehavior ])  ifTrue: [ cll add: l value ] ].
	^ cll asArray
]

{ #category : #'*roassal2' }
CompiledMethod >> dependentMethods [
	"Return the list of methods defined in my class for which I may invoke"
	"(self >> #dependentMethods) dependentMethods"
	^ self messages
		select: [ :k | self methodClass methodDict includesKey: k ]
		thenCollect: [ :k | self methodClass >> k ]
]

{ #category : #'*roassal2' }
CompiledMethod >> livingInDays [

	^ (DateAndTime now - self date) asDays
]

{ #category : #'*roassal2' }
CompiledMethod >> numberOfLinesOfCode [
	(self propertyValueAt: #numberOfLinesOfCode)
			ifNil: [ self propertyValueAt: #numberOfLinesOfCode put: self getSource lineCount ].

	^ self propertyValueAt: #numberOfLinesOfCode 
]
