Class {
	#name : #RTPieBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'objects',
		'values',
		'sum'
	],
	#category : #'Roassal2-Builder-PieChart'
}

{ #category : #'public - pies' }
RTPieBuilder >> emphasize: object by: anIntegerOrASymbolOrABlock [
	"public method"
	"Move the pie to a given offset"
	"anIntegerOrASymbolOrABlock is the distance for which object has to be moved away"
	| element trachelShape delta v |
	element := view elementFromModel: object.
	trachelShape := element trachelShape.
	
	v := (anIntegerOrASymbolOrABlock rtValue: object).
	delta := (trachelShape position + (v @ 0)) 
						rotateBy: ((trachelShape betaAngle - trachelShape alphaAngle) / 2 + trachelShape alphaAngle) * 3.1415 / 180
						about: trachelShape position.
	trachelShape translateTo: delta.
	
]

{ #category : #'public - shapes' }
RTPieBuilder >> emphasizeBy: anIntegerOrASymbolOrABlock [
	"anIntegerOrASymbolOrABlock is the distance for which object has to be moved away"
	objects do: [ :object |
		self emphasize: object by: anIntegerOrASymbolOrABlock ]
]

{ #category : #initialization }
RTPieBuilder >> initialize [
	super initialize.
	objects := #().
	self initializeShapeBuilder
]

{ #category : #initialization }
RTPieBuilder >> initializeShapeBuilder [
	self shape arc  
		outerAngle: [ :object | self outerAngleOf: object ]
			innerAngle: [ :object | self innerAngleOf: object ];
		innerRadius: 0;
		externalRadius: 90;
		color: RTNIdentityNormalizer new
]

{ #category : #'private - utility' }
RTPieBuilder >> innerAngleOf: object [
	^ (self ratioOf: object) * 360
]

{ #category : #'private - utility' }
RTPieBuilder >> label: aBlock withObject: anObject [
	"Private method"
	| element trachelShape labelPosition lbl |
	element := view elementFromModel: anObject.
	trachelShape := element trachelShape.
	labelPosition := (trachelShape position + ((trachelShape externalRadius + 30)@ 0)) 
						rotateBy: ((trachelShape betaAngle - trachelShape alphaAngle) / 2 + trachelShape alphaAngle) * 3.1415 / 180
						about: trachelShape position.

	lbl := RTLabel elementOn: (aBlock rtValue: anObject) asString.
	view add: lbl.
	"view canvas addShape: lbl."
	lbl trachelShape translateTo: labelPosition
]

{ #category : #'public - shapes' }
RTPieBuilder >> labelled [
	"Make each pie having a label"
	self labelledIf: true
]

{ #category : #'public - shapes' }
RTPieBuilder >> labelled: aBlockLabel [
	"Make each pie having a label that respect the aBlockLabel"
	self labelledIf: true withBlock: aBlockLabel
]

{ #category : #'public - shapes' }
RTPieBuilder >> labelledIf: aBlock [
	self labelledIf: aBlock withBlock: [ :o | o ]
]

{ #category : #'public - shapes' }
RTPieBuilder >> labelledIf: aBlock withBlock: aBlockLabel [
	objects do: [ :object |
		(aBlock rtValue: object) ifTrue: [ self label: aBlockLabel withObject: object ] ]
]

{ #category : #'public - pies' }
RTPieBuilder >> objects: aSetOfObjects [
	objects := aSetOfObjects
]

{ #category : #'private - utility' }
RTPieBuilder >> outerAngleOf: object [
	^ ((values copyFrom: 1 to: (objects indexOf: object) - 1), (Array with: 0)) sum * 360.0 / sum
]

{ #category : #'private - utility' }
RTPieBuilder >> ratioOf: anObject [
	| i |
	i := objects indexOf: anObject.
	i isZero ifTrue: [ ^ 0 ].
	^ (values at: i) / sum

]

{ #category : #'public - pies' }
RTPieBuilder >> slice: aBlockOrASymbol [
	| es |
	values := objects collect: aBlockOrASymbol.
	sum := values sum.
	es := self elementsOn: objects.
	view addAll: es.
	^ es
]
