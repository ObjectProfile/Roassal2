Class {
	#name : #GTAElementWithCategoryCommand,
	#superclass : #GTACommand,
	#instVars : [
		'selection',
		'category'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #accessing }
GTAElementWithCategoryCommand class >> analysisOrder [
	^ 1
]

{ #category : #execute }
GTAElementWithCategoryCommand >> clean [
	self session do: [ :eachEvent |
		eachEvent
			removeStrange;
			removeSelectedCategoryEvent;
			removeSelectedElementEvents ]
]

{ #category : #execute }
GTAElementWithCategoryCommand >> execute [
	self session do: [ :eachEvent |
		eachEvent isUserSelectionClass ifTrue: [ self updateSelection: eachEvent ].
		eachEvent isCategorySelection ifTrue: [ self updateCategory: eachEvent ].
	].
	self updateSelection: nil.
]

{ #category : #update }
GTAElementWithCategoryCommand >> updateCategory: anEvent [
	selection ifNil: [ ^ anEvent markAsStrange: 'Category selection before element selection.' ].
	selection selectedCategoryEvent: anEvent.
	anEvent selectedElementEvent: selection.
	selection := nil.
	category := anEvent.
]

{ #category : #update }
GTAElementWithCategoryCommand >> updateSelection: anEvent [
	selection ifNotNil: [ 
		category 
			ifNil: [ selection markAsStrange: 'There is no category selection before.' ]
			ifNotNil: [ :aCategory | 
				selection selectedCategoryEvent: aCategory.
				aCategory selectedElementEvent: selection.  ]
		 ].
	selection := anEvent.
]
