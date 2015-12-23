"
RTDSM build a Dependency Structural Matrix for a collection of objects and an arbitrary dependency function.

For example, inspect the following:
[[[ 
	dsm := RTDSM new.
	dsm objects: RTShape withAllSubclasses.
	dsm dependency: #dependentClasses.
	^ dsm
]]]
"
Class {
	#name : #RTDSM,
	#superclass : #RTAbstractDSM,
	#instVars : [
		'dependency',
		'colorForDependency',
		'colorForNonDependency'
	],
	#category : #'Roassal2-Builder-DSM'
}

{ #category : #UI }
RTDSM >> colorForDependency [
	^ colorForDependency
]

{ #category : #UI }
RTDSM >> colorForNonDependency [
	^ colorForNonDependency
]

{ #category : #UI }
RTDSM >> defaultCellShape [
	^ RTBox new
		size: self cellSize;
		color:
				[ :assoc | 
					(self isAssocDependent: assoc)
						ifTrue: [ self colorForDependency ]
						ifFalse: [ self colorForNonDependency ] ]
]

{ #category : #configuration }
RTDSM >> defaultColorForDependency [
	^ Color red alpha: self transparency
]

{ #category : #configuration }
RTDSM >> defaultColorForNonDependency [
	^ Color veryVeryLightGray alpha: self transparency
]

{ #category : #accessing }
RTDSM >> dependency [
	^ dependency
]

{ #category : #accessing }
RTDSM >> dependency: aOneArgBlock [
	dependency := aOneArgBlock
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
	"
	:: Void -> RTDSM
	"
	super initialize.
	dependency := #yourself.
	colorForDependency := self defaultColorForDependency.
	colorForNonDependency := self defaultColorForNonDependency.
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
