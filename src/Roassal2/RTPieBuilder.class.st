Class {
	#name : #RTPieBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'objects',
		'values',
		'sum'
	],
	#category : 'Roassal2-Builder-PieChart'
}

{ #category : #public }
RTPieBuilder >> emphasize: object by: anIntegerOrASymbolOrABlock [
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

{ #category : #public }
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

{ #category : #utility }
RTPieBuilder >> innerAngleOf: object [
	^ (self ratioOf: object) * 360
]

{ #category : #public }
RTPieBuilder >> label: object [
	| element trachelShape labelPosition lbl |
	element := view elementFromModel: object.
	trachelShape := element trachelShape.
	labelPosition := (trachelShape position + ((trachelShape externalRadius + 30)@ 0)) 
						rotateBy: ((trachelShape betaAngle - trachelShape alphaAngle) / 2 + trachelShape alphaAngle) * 3.1415 / 180
						about: trachelShape position.

	lbl := TRLabelShape new text: object asString.
	view canvas addShape: lbl.
	lbl translateTo: labelPosition
]

{ #category : #shapes }
RTPieBuilder >> labelled [
	self labelledIf: true
]

{ #category : #public }
RTPieBuilder >> labelledIf: aBlock [
	objects do: [ :object |
		(aBlock rtValue: object) ifTrue: [ self label: object ] ]
]

{ #category : #public }
RTPieBuilder >> objects: aSetOfObjects [
	objects := aSetOfObjects
]

{ #category : #utility }
RTPieBuilder >> outerAngleOf: object [
	^ ((values copyFrom: 1 to: (objects indexOf: object) - 1), (Array with: 0)) sum * 360.0 / sum
]

{ #category : #utility }
RTPieBuilder >> ratioOf: anObject [
	| i |
	i := objects indexOf: anObject.
	i isZero ifTrue: [ ^ 0 ].
	^ (values at: i) / sum

]

{ #category : #public }
RTPieBuilder >> slice: aBlockOrASymbol [
	| es |
	values := objects collect: aBlockOrASymbol.
	sum := values sum.
	es := self elementsOn: objects.
	view addAll: es.
	^ es
]
