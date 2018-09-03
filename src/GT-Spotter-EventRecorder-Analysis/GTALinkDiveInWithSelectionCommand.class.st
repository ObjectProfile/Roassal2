Class {
	#name : #GTALinkDiveInWithSelectionCommand,
	#superclass : #GTACommand,
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #execute }
GTALinkDiveInWithSelectionCommand >> clean [
	self session do: [ :eachEvent |
		eachEvent isDiveIn ifTrue: [ eachEvent removeSelectedElementEvent ] ]
]

{ #category : #execute }
GTALinkDiveInWithSelectionCommand >> execute [
	| lastSelection |
	self session do: [ :eachEvent |
		eachEvent isUserSelectionClass ifTrue: [ lastSelection := eachEvent ].
		eachEvent isDiveIn ifTrue: [ 
			self assert: [ lastSelection notNil ]. 
			eachEvent selectedElementEvent: lastSelection ] ]
]
