Class {
	#name : #RTDSM,
	#superclass : #RTBuilder,
	#instVars : [
		'objects',
		'dependency',
		'elements'
	],
	#category : #'Roassal2-Builder-DSM'
}

{ #category : #'as yet unclassified' }
RTDSM >> cellshape [
	^ RTBox new
		size: 10;
		color:
				[ :assoc | 
			(self isAssocDependent: assoc)
				ifTrue: [ Color lightRed ]
				ifFalse: [ Color lightGray ] ]
]

{ #category : #UI }
RTDSM >> createElements [
	| shape e |
	elements := RTGroup new.
	shape := self cellshape.
	objects copy
		doWithIndex:
			[ :anObject1 :index1 | 
			objects copy
				doWithIndex:
					[ :anObject2 :index2 | 
					e := shape elementOn: anObject1 -> anObject2.
					e @ RTPopup.
					e attributeAt: #matrixIndex put: index1 @ index2.
					elements add: e ] ].

]

{ #category : #accessing }
RTDSM >> dependency [
	^ dependency
]

{ #category : #accessing }
RTDSM >> dependency: aOneArgBlock [
	dependency := aOneArgBlock
]

{ #category : #accessing }
RTDSM >> elementAt: aPoint [
	"Return the element at position aPoint"
	^ elements at: (self numberOfObjects) * (aPoint y - 1) + aPoint x
]

{ #category : #accessing }
RTDSM >> elements [
	^ elements copy
]

{ #category : #examples }
RTDSM >> example01 [
	"
	self new example01
	"
	
	| dsm |
	dsm := RTDSM new.
	dsm objects: RTShape withAllSubclasses.
	dsm dependency: #dependentClasses.
	^ dsm
]

{ #category : #examples }
RTDSM >> example02 [
	"
	self new example02
	"
	
	| dsm |
	dsm := RTDSM new.
	dsm objects: (1 to: 10).
	dsm dependency: [ :aValue | aValue // 2 ].
	^ dsm
]

{ #category : #initialization }
RTDSM >> initialize [
	super initialize.
	objects := #().
	dependency := #yourself
]

{ #category : #testing }
RTDSM >> isAssocDependent: assoc [
	| v |
	v := dependency rtValue: assoc key.
	v = assoc value ifTrue: [ ^ true ].
	^ v isCollection
		ifTrue: [ v includes: assoc value ]
		ifFalse: [ false ]
]

{ #category : #'as yet unclassified' }
RTDSM >> layoutElements: es [
	RTGridLayout new
		gapSize: 1;
		lineItemsCount: objects size;
		on: es
]

{ #category : #accessing }
RTDSM >> numberOfObjects [
	"Return the number of objects"
	^ objects size
]

{ #category : #accessing }
RTDSM >> objects [
	^ objects
]

{ #category : #accessing }
RTDSM >> objects: someObjects [
	objects := someObjects
]

{ #category : #hooks }
RTDSM >> renderIn: aView [
	self createElements.
	aView addAll: elements.
	self layoutElements: elements.
	^ aView
]
