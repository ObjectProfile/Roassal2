Class {
	#name : #GTAPreviousSelectionCommand,
	#superclass : #GTACommand,
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #accessing }
GTAPreviousSelectionCommand class >> analysisOrder [
	^ (GTAElementWithCategoryCommand analysisOrder max:
			GTADiveInLevelCommand analysisOrder) + 1
]

{ #category : #execute }
GTAPreviousSelectionCommand >> clean [
	self session do: [ :each | 
		each isUserSelectionClass ifTrue: [ each removePreviousSelection ] ]
]

{ #category : #execute }
GTAPreviousSelectionCommand >> execute [
	| selections diveInLevels |
	selections := self session select: #isUserSelectionClass.
	selections size < 2 ifTrue: [ ^ self ].
	diveInLevels := Dictionary new.
	selections withIndexDo: [ :selection :index | | lastSelection |
		lastSelection := diveInLevels at: selection diveInLevel ifAbsent: [ nil ].
		lastSelection ifNotNil: [ selection previousSelection: lastSelection ].
		diveInLevels at: selection diveInLevel put: selection ]
]
