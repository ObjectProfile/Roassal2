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
	#superclass : #RTBuilder,
	#instVars : [
		'objects',
		'dependency',
		'elements',
		'rotation'
	],
	#category : #'Roassal2-Builder-DSM'
}

{ #category : #UI }
RTDSM >> addLabels [
	self addLabelsLeft.
	self addLabelsTop.
]

{ #category : #UI }
RTDSM >> addLabelsLeft [
	| es lblShape theModel lbl |
	es := self columnAt: 1.
	lblShape := RTLabel new height: self cellSize.
	es do: [ :e |
		theModel := e model key.
		lbl := lblShape elementOn: theModel.
		view add: lbl.
		RTConstraint new
			fix: e;
			movable: lbl;
			outer;
			left;
			move
	]
]

{ #category : #UI }
RTDSM >> addLabelsTop [
	| es lblShape theModel lbl |
	es := self rowAt: 1.
	lblShape := RTLabel new height: self cellSize.
	es
		do:
			[ :e | 
			theModel := e model value.
			lbl := lblShape elementOn: theModel.
			view add: lbl.
			lbl rotateByDegrees: rotation.
			RTConstraint new
				fix: e;
				movable: lbl;
				outer;
				right;
				top;
				move.
			lbl translateBy: self cellSize negated @ 0 ]
]

{ #category : #UI }
RTDSM >> cellSize [
	^ 10
]

{ #category : #UI }
RTDSM >> cellshape [
	^ RTBox new
		size: self cellSize;
		color:
				[ :assoc | 
			(self isAssocDependent: assoc)
				ifTrue: [ self colorForDependency ]
				ifFalse: [ self colorForNonDependency ] ]
]

{ #category : #UI }
RTDSM >> colorForDependency [
	^ Color red alpha: 0.4
]

{ #category : #UI }
RTDSM >> colorForNonDependency [
	^ Color veryVeryLightGray alpha: 0.4
]

{ #category : #accessing }
RTDSM >> columnAt: aNumber [

	^ (1 to: self numberOfObjects) collect: [ :i | self elementAt: aNumber @ i ]
]

{ #category : #UI }
RTDSM >> createElements [
	"
	:: Void -> RTDSM
	var shape : RTShape
	var e : RTElement
	var anObject1 : Object
	var index1 : Number
	var anObject2 : Object
	var index2 : Number
	var evt : TREvent
	var elements : Collection
	var objects : Collection
	"
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
					e when: TRMouseEnter do: [ :evt | 
						self highlightColumn: (evt element attributeAt: #matrixIndex) x.
						self highlightRow: (evt element attributeAt: #matrixIndex) y.
						 ].
					e when: TRMouseLeave do: [ :evt | 
						self unhighlightColumn: (evt element attributeAt: #matrixIndex) x.
						self unhighlightRow: (evt element attributeAt: #matrixIndex) y.
						 ].
					
					e attributeAt: #matrixIndex put: index2 @ index1.
					elements add: e ] ].

]

{ #category : #UI }
RTDSM >> defaultTopLabelRotation [
	^ -55
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

{ #category : #UI }
RTDSM >> highlightColumn: aNumber [
	^ self highlightElements: (self columnAt: aNumber)
]

{ #category : #UI }
RTDSM >> highlightElements: someElements [
	someElements do: [ :e | e trachelShape color: (e trachelShape color alpha: 0.8) ]
]

{ #category : #UI }
RTDSM >> highlightRow: aNumber [
	^ self highlightElements: (self rowAt: aNumber)
]

{ #category : #initialization }
RTDSM >> initialize [
	"
	:: Void -> RTDSM
	"
	super initialize.
	objects := #().
	dependency := #yourself.
	rotation := self defaultTopLabelRotation.
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

{ #category : #UI }
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
	self addLabels.
	^ aView
]

{ #category : #accessing }
RTDSM >> rotation [
	"
	Return the rotation of the top labels
	:: Void -> Integer
	"
	^ rotation
]

{ #category : #accessing }
RTDSM >> rotation: anInteger [
	"Set the rotation of the top label
	:: Integer -> RTDSM
	"
	rotation := anInteger
]

{ #category : #accessing }
RTDSM >> rowAt: aNumber [

	^ (1 to: self numberOfObjects) collect: [ :i | self elementAt: i @ aNumber ]
]

{ #category : #UI }
RTDSM >> unhighlightColumn: aNumber [
	^ self unhighlightElements: (self columnAt: aNumber)
]

{ #category : #UI }
RTDSM >> unhighlightElements: someElements [
	someElements do: [ :e | e trachelShape color: (e trachelShape color alpha: 0.4) ]
]

{ #category : #UI }
RTDSM >> unhighlightRow: aNumber [
	^ self unhighlightElements: (self rowAt: aNumber)
]
