Class {
	#name : #RTMultiCompositeShape,
	#superclass : #RTShape,
	#instVars : [
		'shapes',
		'layout',
		'automaticallyUpdateLayout'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'instance creation' }
RTMultiCompositeShape class >> with: shape1 with: shape2 [
	^ self new 
		add: shape1;
		add: shape2;
		yourself
]

{ #category : #adding }
RTMultiCompositeShape >> add: aRTShape [
	self add: aRTShape translateBy: 0 @ 0
]

{ #category : #adding }
RTMultiCompositeShape >> add: aRTShape translateBy: aPoint [
	shapes add: (Array with: aRTShape with: aPoint)
]

{ #category : #'public - layout' }
RTMultiCompositeShape >> alignRight [
	layout := #alignRight
]

{ #category : #accessing }
RTMultiCompositeShape >> allShapes [
	"Return all the shapes contained in me."
	^ shapes collect: #first as: Array
]

{ #category : #accessing }
RTMultiCompositeShape >> colorElement: aOneArgBlock [
	shapes ifEmpty: [ self error: 'You first need to add shape before setting the color' ].
	shapes do: [ :s | s first colorElement: aOneArgBlock ]
]

{ #category : #public }
RTMultiCompositeShape >> edgeFrom: el1 to: el2 [
	^ (RTEdge from: el1 to: el2) addShape: self
]

{ #category : #'public - layout' }
RTMultiCompositeShape >> horizontal [
	layout := #horizontal
]

{ #category : #initialization }
RTMultiCompositeShape >> initialize [
	super initialize.
	shapes := OrderedCollection new.
	layout := #noLayout.
	
	"If one of the shape changes its size, should we relayout. By default no"
	automaticallyUpdateLayout := false
]

{ #category : #public }
RTMultiCompositeShape >> setAutomaticRelayout [
	automaticallyUpdateLayout := true
]

{ #category : #hooks }
RTMultiCompositeShape >> setAutomaticUpdateLayoutIfNecessaryFor: ss and: trachelShape [
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

{ #category : #public }
RTMultiCompositeShape >> trachelShapeFor: anElement [
"	^ self updateFor: anElement trachelShape: TRMultiCompositeShape new"
	
	| ss trachelShape |
	trachelShape := TRMultiCompositeShape new.
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
RTMultiCompositeShape >> updateFor: anElement trachelShape: trachelShape [
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
RTMultiCompositeShape >> vertical [
	layout := #vertical
]
