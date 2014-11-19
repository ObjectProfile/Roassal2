Class {
	#name : #RTMultiCompositeShape,
	#superclass : #RTShape,
	#instVars : [
		'shapes',
		'layout'
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

{ #category : #'public - layout' }
RTMultiCompositeShape >> horizontal [
	layout := #horizontal
]

{ #category : #initialization }
RTMultiCompositeShape >> initialize [
	super initialize.
	shapes := OrderedCollection new.
	layout := #noLayout
]

{ #category : #public }
RTMultiCompositeShape >> trachelShapeFor: anElement [
	^ self updateFor: anElement trachelShape: TRMultiCompositeShape new
]

{ #category : #hooks }
RTMultiCompositeShape >> updateFor: anElement trachelShape: trachelShape [
	| ss |
	ss := shapes collect: [ :tupple | 
		| s |
		s := tupple first trachelShapeFor: anElement.
		Array with: s with: tupple second ].

	trachelShape setShapes: ss.
	trachelShape perform: layout.
	^ trachelShape
]

{ #category : #'public - layout' }
RTMultiCompositeShape >> vertical [
	layout := #vertical
]
