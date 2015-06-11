Class {
	#name : #GTAMissStepsCommand,
	#superclass : #GTACommand,
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #accessing }
GTAMissStepsCommand class >> analysisOrder [
	^ 50
]

{ #category : #execute }
GTAMissStepsCommand >> clean [
	self session do: [ :eachEvent |
		eachEvent
			removeIsMissStep ]
]

{ #category : #execute }
GTAMissStepsCommand >> execute [
	| divesIn |
	divesIn := self session select: #isDiveIn.
	divesIn withIndexDo: [ :aDiveIn :index |
		(index + 1) <= divesIn size ifTrue: [ 
			((aDiveIn hasQuery or: [ aDiveIn hasDiveIn ]) not and:
				[ aDiveIn duration < 3 seconds ]) ifTrue: [ 
				aDiveIn setMissStep.
			]
		]
	]
]
