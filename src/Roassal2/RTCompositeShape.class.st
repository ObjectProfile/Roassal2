"
A RTCompositeShape describes a composite shape. 

The bounds of the element depends therefore on the composition. Consider the following example:
-=-=-=-=-=-=-=-=-=-=-=-=
| v shape es methodElements |
	v := RTView new.
	v @ RTDraggableView.

	shape := RTCompositeShape new.
	shape add: RTLabel new.
	shape add: (RTBox new color: (Color blue alpha: 0.3)).
	shape vertical.
	
	es := shape elementsOn: RTShape withAllSubclasses.
	v addAll: es.

	es do: [ :e | 
		methodElements := RTBox new elementsOn: e model rtmethods.
		RTGridLayout on: methodElements.
		v addAll: methodElements.
		RTNest new
			on: e 
			inShape: #second 
			nest: methodElements.
	].

	RTFlowLayout on: es.
	es @ RTDraggable.
^ v
-=-=-=-=-=-=-=-=-=-=-=-=

Doing a layout does not produce overlap of names.

Shapes composed in a RTCompositeShape may be relayouted after one of them has changed its size. Consider the following example:
-=-=-=-=-=-=-=-=-=-=-=-=
	s := RTCompositeShape new.
	b1 := RTBox new color: Color green.
	b2 := RTBox new color: Color blue; size: 20.
	b3 := RTLabel new.
	s add: b1.
	s add: b2.
	s add: b3.
	s horizontal.
	s setAutomaticRelayout.
	
	e := s elementOn: 'click to expand'.
	view := RTView new.
	view add: e.
	
	e @ RTDraggable.
	e @ RTPopup.
	
	e when: TRMouseClick do: [ :ev |
		e trachelShape shapes second extent: 45 @ 45.
		e trachelShape shapes third text: 'hello'.
		view signalUpdate.
	].
	
	view open
-=-=-=-=-=-=-=-=-=-=-=-=
 
"
Class {
	#name : #RTCompositeShape,
	#superclass : #RTShape,
	#instVars : [
		'shapes',
		'layout',
		'automaticallyUpdateLayout'
	],
	#category : #'Roassal2-Shapes'
}

{ #category : #'instance creation' }
RTCompositeShape class >> with: shape1 with: shape2 [
	^ self new 
		add: shape1;
		add: shape2;
		yourself
]

{ #category : #adding }
RTCompositeShape >> add: aRTShape [
	self add: aRTShape translateBy: 0 @ 0
]

{ #category : #adding }
RTCompositeShape >> add: aRTShape translateBy: aPoint [
	shapes add: (Array with: aRTShape with: aPoint)
]

{ #category : #'public - layout' }
RTCompositeShape >> alignRight [
	layout := #alignRight
]

{ #category : #'public - layout' }
RTCompositeShape >> allOfSameSize [
	layout := #allOfSameSize
]

{ #category : #'public - layout' }
RTCompositeShape >> allOfSameSizeWithPadding [
	layout := #allOfSameSizeWithPadding
]

{ #category : #accessing }
RTCompositeShape >> allShapes [
	"Return all the shapes contained in me."
	^ shapes collect: #first as: Array
]

{ #category : #'attach point' }
RTCompositeShape >> attachPoint: anAttachPoint [
	self allShapes do: [ :s | 
		((s isKindOf: RTAbstractLine) or: [ s isKindOf: RTLineDecoration ]) 
			ifTrue: [ s attachPoint: anAttachPoint ] ]
]

{ #category : #public }
RTCompositeShape >> borderColor: aBlockOrColor [
	self allShapes do: [ :s | s borderColor: aBlockOrColor ]
]

{ #category : #public }
RTCompositeShape >> borderWidth: aBlockOrColor [
	self allShapes do: [ :s | s borderWidth: aBlockOrColor ]
]

{ #category : #accessing }
RTCompositeShape >> color: aOneArgBlockOrColorOrSymbol [
	self allShapes do: [ :s | s color: aOneArgBlockOrColorOrSymbol ]
]

{ #category : #accessing }
RTCompositeShape >> colorElement: aOneArgBlock [
	shapes ifEmpty: [ self error: 'You first need to add shape before setting the color' ].
	self allShapes do: [ :s | s colorElement: aOneArgBlock ]
]

{ #category : #public }
RTCompositeShape >> edgeFrom: el1 to: el2 [
	^ (RTEdge from: el1 to: el2) addShape: self
]

{ #category : #accessing }
RTCompositeShape >> fillColor: aOneArgBlockOrColorOrSymbol [
	shapes ifEmpty: [ self error: 'You first need to add shape before setting the color' ].
	self allShapes do: [ :s | (s isKindOf: RTAbstractElementShape) ifTrue: [ s fillColor: aOneArgBlockOrColorOrSymbol ] ]
]

{ #category : #'public - layout' }
RTCompositeShape >> horizontal [
	layout := #horizontal
]

{ #category : #initialization }
RTCompositeShape >> initialize [
	super initialize.
	shapes := OrderedCollection new.
	layout := #noLayout.
	
	"If one of the shape changes its size, should we relayout. By default no"
	automaticallyUpdateLayout := false
]

{ #category : #public }
RTCompositeShape >> setAutomaticRelayout [
	"If one of the shape changes its size, should we relayout."
	automaticallyUpdateLayout := true
]

{ #category : #hooks }
RTCompositeShape >> setAutomaticUpdateLayoutIfNecessaryFor: ss and: trachelShape [
	automaticallyUpdateLayout
		ifTrue: [ 
			| b |
			b := TRExtentCallback new
				block: [ :aShape :ratio | 
					trachelShape resetInnerShapes.
					trachelShape perform: layout.
					trachelShape relayout ].
			ss do: [ :tupple | tupple first addCallback: b ] ]
]

{ #category : #accessing }
RTCompositeShape >> textColor: aOneArgBlockOrColorOrSymbol [
	self allShapes do: [ :s | (s isKindOf: RTLabel) ifTrue: [ s color: aOneArgBlockOrColorOrSymbol ] ]
]

{ #category : #public }
RTCompositeShape >> trachelShapeFor: anElement [
"	^ self updateFor: anElement trachelShape: TRMultiCompositeShape new"
	
	| ss trachelShape |
	trachelShape := TRCompositeShape new.
	ss := shapes
		collectWithIndex: [ :tupple :shapeIndex | 
			| s |
			s := tupple first trachelShapeFor: anElement.
			Array with: s with: tupple second ].
	trachelShape setShapes: ss.
	trachelShape perform: layout.
	self setAutomaticUpdateLayoutIfNecessaryFor: ss and: trachelShape.
	^ trachelShape
	

]

{ #category : #hooks }
RTCompositeShape >> updateFor: anElement trachelShape: trachelShape [
	| ss |
	ss := shapes
		collectWithIndex: [ :tupple :shapeIndex | 
			| s |
			tupple first updateFor: anElement trachelShape: (anElement trachelShape shapes at: shapeIndex).
			s := anElement trachelShape shapes at: shapeIndex.
			Array with: s with: tupple second ].
	trachelShape setShapes: ss.
	trachelShape perform: layout.
	self setAutomaticUpdateLayoutIfNecessaryFor: ss and: trachelShape.
	^ trachelShape
	

]

{ #category : #'public - layout' }
RTCompositeShape >> vertical [
	layout := #vertical
]
