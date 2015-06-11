Class {
	#name : #GTAFlexibleResultSymbolBuilder,
	#superclass : #GTAOrthogonalSymbolBuilder,
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Activity-Symbols'
}

{ #category : #visitor }
GTAFlexibleResultSymbolBuilder >> visitSearchFinishedEvent: aGTSpotterEvent [ 
	^ aGTSpotterEvent notEmptyCategories size < 2
		ifTrue: [ self newSearchFinishedForOneCategoryEvent: aGTSpotterEvent ]
		ifFalse: [ self newSearchFinishedForSeveralCategoriesEvent: aGTSpotterEvent ]
]
