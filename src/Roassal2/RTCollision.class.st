Class {
	#name : #RTCollision,
	#superclass : #RTInteraction,
	#instVars : [
		'elementToCheckForCollision'
	],
	#category : #'Roassal2-Interactions'
}

{ #category : #initialization }
RTCollision >> avoidOverlapWith: aShape step: step [
	"aShape is being moved by a translation of step pixels.
	This method avoids the translation"
	| delta tt side |
	^ (self checkCollistionFor: aShape)
		ifTrue: [ 
			| r en |
			en := aShape encompassingRectangle.
			r := (elementToCheckForCollision detect: [ :e | e encompassingRectangle intersects: en ]) encompassingRectangle.
Halt once. 
			"We need to determine which side is the most relevant"
			tt := 1000.
			((r bottom - en top) < 0) ifTrue: [ tt := (r bottom - en top). side := #bottom ].
			((r right - en left) < 0 and: [ tt > ((r right - en left) abs) ]) ifTrue: [ tt := r right - en left. side := #right ].
			((r top - en bottom) < 0 and: [ tt > ((r top - en bottom) abs) ]) ifTrue: [ tt := r top - en bottom. side := #top ].
			((r left - en right) < 0 and: [ tt > ((r left - en right) abs) ]) ifTrue: [ tt := r left - en right. side := #left ].
			
			side == #right ifTrue: [ delta := tt @ 0 ].
			side == #left ifTrue: [ delta := tt @ 0 ].
			side == #top ifTrue: [ delta := 0 @ tt ].
			side == #bottom ifTrue: [ delta := 0 @ tt ].
			
			aShape translateBy: delta ]
]

{ #category : #initialization }
RTCollision >> checkCollistionFor: aTrachelShape [
	^ elementToCheckForCollision anySatisfy: [ :e | e encompassingRectangle intersects: aTrachelShape encompassingRectangle ]
]

{ #category : #accessing }
RTCollision >> elementToCheckForCollision [
	^ elementToCheckForCollision
]

{ #category : #accessing }
RTCollision >> elementToCheckForCollision: someElements [
	elementToCheckForCollision := someElements
]

{ #category : #initialization }
RTCollision >> initializeElement: element [
	element trachelShape
		addCallback:
			(TRTranslationCallback new
				block:
					[ :aShape :step | self avoidOverlapWith: aShape step: step ])
]
