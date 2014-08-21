Class {
	#name : #RTMultiCompositeShape,
	#superclass : #RTShape,
	#instVars : [
		'shapes',
		'layout'
	],
	#category : 'Roassal2-Core'
}

{ #category : #adding }
RTMultiCompositeShape >> add: aRTShape [
	self add: aRTShape translateBy: 0 @ 0
]

{ #category : #adding }
RTMultiCompositeShape >> add: aRTShape translateBy: aPoint [
	shapes add: (Array with: aRTShape with: aPoint)
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
	| ss ts |
"self halt."
	ss := shapes collect: [ :tupple | 
		| s |
		s := tupple first trachelShapeFor: anElement.
		Array with: s with: tupple second ].

	ts := TRMultiCompositeShape new setShapes: ss; yourself.
	ts perform: layout.
	^ ts
]

{ #category : #'public - layout' }
RTMultiCompositeShape >> vertical [
	layout := #vertical
]
