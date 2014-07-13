Class {
	#name : #RTMultiCompositeShape,
	#superclass : #RTShape,
	#instVars : [
		'shapes'
	],
	#category : #'Roassal2-Core'
}

{ #category : #adding }
RTMultiCompositeShape >> add: aRTShape [
	self add: aRTShape translateBy: 0 @ 0
]

{ #category : #adding }
RTMultiCompositeShape >> add: aRTShape translateBy: aPoint [
	shapes add: (Array with: aRTShape with: aPoint)
]

{ #category : #initialization }
RTMultiCompositeShape >> initialize [
	super initialize.
	shapes := OrderedCollection new
]

{ #category : #public }
RTMultiCompositeShape >> trachelShapeFor: anElement [
	| ss |
	ss := shapes collect: [ :tupple | 
		| s |
		s := tupple first trachelShapeFor: anElement.
		Array with: s with: tupple second ].
	^ TRMultiCompositeShape new setShapes: ss; yourself
]
