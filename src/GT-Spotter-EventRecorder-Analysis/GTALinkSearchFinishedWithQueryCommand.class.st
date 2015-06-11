Class {
	#name : #GTALinkSearchFinishedWithQueryCommand,
	#superclass : #GTACommand,
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #execute }
GTALinkSearchFinishedWithQueryCommand >> clean [
	self session do: [ :eachEvent |
		eachEvent isSearchFinished ifTrue: [ eachEvent removeAssociatedContextChanged ] ]
]

{ #category : #execute }
GTALinkSearchFinishedWithQueryCommand >> execute [
	| queries |
	queries := OrderedCollection new.
	self session do: [ :eachEvent |
		eachEvent isContextChanged ifTrue: [ queries addLast: eachEvent ].
		eachEvent isSearchFinished ifTrue: [ | query |
			self assert: [ queries notEmpty ]. 
			query := queries 
							detect: [ :eachQuery | eachQuery currentTextInfo = eachEvent query ].
			eachEvent associatedContextChanged: query ] ]
]
