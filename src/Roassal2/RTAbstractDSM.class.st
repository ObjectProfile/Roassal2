Class {
	#name : #RTAbstractDSM,
	#superclass : #RTBuilder,
	#instVars : [
		'elements',
		'objects',
		'wantsLabel',
		'text',
		'rotation'
	],
	#category : #'Roassal2-Builder-DSM'
}

{ #category : #UI }
RTAbstractDSM >> addLabels [
	self addLabelsLeft.
	self addLabelsTop.
]

{ #category : #UI }
RTAbstractDSM >> addLabelsIfNecessary [
	self wantsLabel ifFalse: [ ^ self ].
	self addLabels
]

{ #category : #UI }
RTAbstractDSM >> addLabelsLeft [
	| es lblShape theModel lbl |
	es := self columnAt: 1.
	lblShape := self labelShape.
	es
		do:
			[ :e | 
			theModel := e model key.
			lbl := lblShape elementOn: theModel.
			view add: lbl.
			RTConstraint new
				fix: e;
				movable: lbl;
				outer;
				left;
				move ]
]

{ #category : #UI }
RTAbstractDSM >> addLabelsTop [
	| es lblShape theModel lbl |
	es := self rowAt: 1.
	lblShape := self labelShape.
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
RTAbstractDSM >> cellSize [
	^ 10
]

{ #category : #accessing }
RTAbstractDSM >> columnAt: aNumber [

	^ (1 to: self numberOfObjects) collect: [ :i | self elementAt: aNumber @ i ]
]

{ #category : #UI }
RTAbstractDSM >> createElements [
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
	| e |
	elements := RTGroup new.
	objects copy
		doWithIndex:
			[ :anObject1 :index1 | 
			objects copy
				doWithIndex:
					[ :anObject2 :index2 | 
					e := self elementOn: anObject1 -> anObject2.
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

{ #category : #hooks }
RTAbstractDSM >> createShapeBuilder [
	| sb |
	sb := super createShapeBuilder.
	sb shape: self defaultCellShape.
	^ sb
]

{ #category : #UI }
RTAbstractDSM >> defaultTopLabelRotation [
	^ -55
]

{ #category : #configuration }
RTAbstractDSM >> doNotShowLabels [
	wantsLabel := false
]

{ #category : #accessing }
RTAbstractDSM >> elementAt: aPoint [
	"Return the element at position aPoint"
	^ elements at: (self numberOfObjects) * (aPoint y - 1) + aPoint x
]

{ #category : #accessing }
RTAbstractDSM >> elements [
	^ elements copy
]

{ #category : #UI }
RTAbstractDSM >> highlightColumn: aNumber [
	^ self highlightElements: (self columnAt: aNumber)
]

{ #category : #UI }
RTAbstractDSM >> highlightElements: someElements [
	someElements do: [ :e | e trachelShape color: (e trachelShape color alpha: 0.8) ]
]

{ #category : #UI }
RTAbstractDSM >> highlightRow: aNumber [
	^ self highlightElements: (self rowAt: aNumber)
]

{ #category : #initialization }
RTAbstractDSM >> initialize [
	"
	:: Void -> RTDSM
	"
	super initialize.
	objects := #().
	rotation := self defaultTopLabelRotation.
	wantsLabel := true.
	text := #yourself.

]

{ #category : #UI }
RTAbstractDSM >> labelShape [
	^ RTLabel new
		height: self cellSize;
		text: text
]

{ #category : #UI }
RTAbstractDSM >> layoutElements: es [
	RTGridLayout new
		gapSize: 1;
		lineItemsCount: objects size;
		on: es
]

{ #category : #accessing }
RTAbstractDSM >> numberOfObjects [
	"Return the number of objects"
	^ objects size
]

{ #category : #accessing }
RTAbstractDSM >> objects [
	^ objects
]

{ #category : #accessing }
RTAbstractDSM >> objects: someObjects [
	objects := someObjects
]

{ #category : #hooks }
RTAbstractDSM >> renderIn: aView [
	self createElements.
	aView addAll: elements.
	self layoutElements: elements.
	self addLabelsIfNecessary.
	^ aView
]

{ #category : #accessing }
RTAbstractDSM >> rotation [
	"
	Return the rotation of the top labels
	:: Void -> Integer
	"
	^ rotation
]

{ #category : #accessing }
RTAbstractDSM >> rotation: anInteger [
	"Set the rotation of the top label
	:: Integer -> RTDSM
	"
	rotation := anInteger
]

{ #category : #accessing }
RTAbstractDSM >> rowAt: aNumber [
	"Return the elements located at a given row"
	^ (1 to: self numberOfObjects) collect: [ :i | self elementAt: i @ aNumber ]
]

{ #category : #accessing }
RTAbstractDSM >> text [
	"Return the text used for labelling"
	^ text
]

{ #category : #accessing }
RTAbstractDSM >> text: aOneArgBlockOrSymbol [
	"Set the text used for each label. Per default, text is #yourself"
	text := aOneArgBlockOrSymbol
]

{ #category : #configuration }
RTAbstractDSM >> transparency [
	"Alpha value for colors"
	^ 0.4
]

{ #category : #UI }
RTAbstractDSM >> unhighlightColumn: aNumber [
	^ self unhighlightElements: (self columnAt: aNumber)
]

{ #category : #UI }
RTAbstractDSM >> unhighlightElements: someElements [
	someElements do: [ :e | e trachelShape color: (e trachelShape color alpha: 0.4) ]
]

{ #category : #UI }
RTAbstractDSM >> unhighlightRow: aNumber [
	^ self unhighlightElements: (self rowAt: aNumber)
]

{ #category : #testing }
RTAbstractDSM >> wantsLabel [
	^ wantsLabel
]
