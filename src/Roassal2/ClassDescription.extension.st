Extension { #name : #ClassDescription }

{ #category : #'*roassal2' }
ClassDescription >> ageInDays [
	"Return the number of days the class exists"
	self numberOfMethods isZero ifTrue: [ ^ 0 ].
	^ (DateAndTime now - self oldestMethod date) asDays
]

{ #category : #'*roassal2' }
ClassDescription >> ageInDaysRounded [
	"Return the number of days the class exists"

	^ self ageInDays rounded
]

{ #category : #'*roassal2' }
ClassDescription >> classReferences [
	| references |
	references := OrderedCollection new.
	self methodDict valuesDo: [ :compiledMethod |
			references addAll: compiledMethod classReferences ].
	^ references removeDuplicates
]

{ #category : #'*roassal2' }
ClassDescription >> commonSuperclassWith: aClass [
	"
	Metaclass commonSuperclassWith: Class
	Metaclass commonSuperclassWith: Point
	Metaclass commonSuperclassWith: Metaclass
	Object commonSuperclassWith: RTPopup class
	"
	| t1 t2 |
	self == aClass ifTrue: [ ^ self ].
	t1 := self withAllSuperclasses reverse.
	t2 := aClass withAllSuperclasses reverse.
	1 to: (t1 size min: t2 size) do: [ :i |
		(t1 at: i) ~~ (t2 at: i)
			ifTrue: [ ^ t1 at: (i - 1) ] ].
	
	^ t1 size < t2 size 
		ifTrue: [ t1 last ]
		ifFalse: [ t2 last ]
]

{ #category : #'*roassal2' }
ClassDescription >> computeOldestMethod [
	| d m |
	d := DateAndTime now.
	m := nil.
	self methods, self class methods do: [ :cm | cm date < d ifTrue: [ m := cm. d := cm date ] ].
	^ m
]

{ #category : #'*roassal2' }
ClassDescription >> computeYoungestMethod [
	| d m ms aMethod |
	ms := self methods, self class methods.
	aMethod := ms anyOne.
	d := aMethod date.
	m := aMethod.
	
	ms do: [ :cm | cm date > d ifTrue: [ m := cm. d := cm date ] ].
	^ m
]

{ #category : #'*roassal2' }
ClassDescription >> gotMethodOnDay: dayAsNumber [
	"Return true if a method has been defined on dayAsNumber.
	Always returns true for dayAsNumber = 0"
	| age |
	age := self ageInDaysRounded.
	^ self methods anySatisfy: [ :cm | (age - cm ageInDaysRounded) = dayAsNumber ]

]

{ #category : #'*roassal2' }
ClassDescription >> hasAnyMethodProducedAfterDay: aNumberOfDays [
	^ self methods anySatisfy: [ :cm | cm livingInDays = aNumberOfDays ]

]

{ #category : #'*roassal2' }
ClassDescription >> isReferencedBy: aClass [ 
	^ aClass classReferences includes: self 
]

{ #category : #'*roassal2' }
ClassDescription >> livingInDays [
	self numberOfMethods isZero ifTrue: [ ^ 0 ].
	^ (DateAndTime now - self oldestMethod date) asDays
]

{ #category : #'*roassal2' }
ClassDescription >> numberOfSubclasses [
	^ self allSubclasses size
]

{ #category : #'*roassal2' }
ClassDescription >> numberOfVariables [
	^ self instVarNames size
]

{ #category : #'*roassal2' }
ClassDescription >> oldestMethod [
	"We pick a method, and put the cache in it"
	| aMethod |
	aMethod := (self methods, self class methods) first.
	^ (aMethod properties includesKey: #oldestMethod)
		ifTrue: [ aMethod properties at: #oldestMethod ]
		ifFalse: [ | m |
			m := self computeOldestMethod.
			aMethod properties at: #oldestMethod put: m ]

]

{ #category : #'*roassal2' }
ClassDescription >> referencedByClasses: aCollectionOfClasses [
	| references |
	references := OrderedCollection new.
	aCollectionOfClasses do: [ :eachClass |
		(self isReferencedBy: eachClass) 
			ifTrue: [ references add: eachClass ] ].
	^ references
]

{ #category : #'*roassal2' }
ClassDescription >> rtmethods [
	"This method is useful to have examples working on VisualWorks"
	^ self methods
]

{ #category : #'*roassal2' }
ClassDescription >> youngestMethod [
	"We pick a method, and put the cache in it"
	| aMethod |
	aMethod := (self methods, self class methods) first.
	^ (aMethod properties includesKey: #youngestMethod)
		ifTrue: [ aMethod properties at: #youngestMethod ]
		ifFalse: [ | m |
			m := self computeYoungestMethod.
			aMethod properties at: #youngestMethod put: m ]

]
