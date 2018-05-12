Class {
	#name : #RTCollision,
	#superclass : #RTInteraction,
	#instVars : [
		'elementToCheckForCollision'
	],
	#category : #'Roassal2-Interactions'
}

{ #category : #initialization }
RTCollision >> checkCollistionFor: aTrachelShape [
	^ elementToCheckForCollision anySatisfy: [ :e | e encompassingRectangle intersects: aTrachelShape encompassingRectangle ]
]

{ #category : #initialization }
RTCollision >> initializeElement: element [
	element trachelShape addCallback: (TRTranslationCallback new block: [ :aShape :step | (self checkCollistionFor: aShape) ifTrue: [ aShape translateBy: step negated ] ])
]
