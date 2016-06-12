"
view1 := RTView new.
view1 addAll: ((RTEllipse new size: 20) elementsOn: (1 to: 25)).
RTEdgeBuilder new
	view: view1;
	connectFrom: [ :vv | vv // 2 ].
RTTreeLayout on: view1 elements.



view2 := RTView new.
view2 addAll: ((RTEllipse new size: 20) elementsOn: (1 to: 25)).
RTGridLayout on: view2 elements.
view2 addMenu: 'Morphing' callback: [ view2 @ (RTMorphingView new referenceView: view1; smoothTransition) ]

"
Class {
	#name : #RTMorphingView,
	#superclass : #RTInteraction,
	#instVars : [
		'referenceView',
		'translator',
		'referenceModels',
		'afterAllTranslationsBlocks'
	],
	#category : #'Roassal2-Utility'
}

{ #category : #utility }
RTMorphingView >> afterTranslationDoActionOn: aView [

	afterAllTranslationsBlock rtValue: aView.
	aView signalUpdate.
]

{ #category : #configuration }
RTMorphingView >> directTransition [
	translator := RTDirectLayoutTranslator new
]

{ #category : #configuration }
RTMorphingView >> focusOnCenterScaledAfterAllTranslations [
	afterAllTranslationsBlocks add: [ :view | view canvas camera focusOnCenterScaled ]
]

{ #category : #initialization }
RTMorphingView >> initialize [
	super initialize.
	self directTransition.
	afterAllTranslationsBlocks := OrderedCollection new
]

{ #category : #hooks }
RTMorphingView >> initializeElement: aView [
	| allModels referenceElements |
	allModels := (aView elements collect: #model) asArray.
	referenceElements := referenceView elementsFromModels: allModels.
	referenceModels := referenceElements collect: #model.
	(aView elementsFromModels: referenceModels) with: referenceElements do: [ :e1 :e2 | self translate: e1 toPositionOf: e2 ].
	self afterTranslationDoActionOn: aView

]

{ #category : #configuration }
RTMorphingView >> moveApartSingleElements [
	| rms singleElements notSingleElements |
	afterAllTranslationsBlocks add: [ :view | 
		rms := referenceModels elements collect: #model.
		singleElements := (view elements reject: [ :e | rms includes: e model ]).
		notSingleElements := (view elements select: [ :e | rms includes: e model ]).
		RTGridLayout on: singleElements.
		TRConstraint move: singleElements onTheRightOf: notSingleElements ]
]

{ #category : #accessing }
RTMorphingView >> referenceView [
	^ referenceView
]

{ #category : #accessing }
RTMorphingView >> referenceView: anObject [
	referenceView := anObject
]

{ #category : #configuration }
RTMorphingView >> smoothTransition [
	translator := RTSmoothLayoutTranslator new
]

{ #category : #utility }
RTMorphingView >> translate: e1 toPositionOf: e2 [
	translator translate: e1 to: e2 position
]
