Class {
	#name : #RTTimeLineEntry,
	#superclass : #RTObject,
	#instVars : [
		'identifier',
		'start',
		'end'
	],
	#category : #'Roassal2-Builder-TimeLine'
}

{ #category : #'accessing-computed' }
RTTimeLineEntry >> duration [
	^ end - start
]

{ #category : #accessing }
RTTimeLineEntry >> end [
	^ end
]

{ #category : #accessing }
RTTimeLineEntry >> end: anInteger [
	end := anInteger
]

{ #category : #accessing }
RTTimeLineEntry >> identifier [
	^ identifier
]

{ #category : #accessing }
RTTimeLineEntry >> identifier: anObject [
	"Could be any object here"
	identifier := anObject
]

{ #category : #initialization }
RTTimeLineEntry >> initialize [
	super initialize.
	start := 0.
	end := 0.
]

{ #category : #'accessing-computed' }
RTTimeLineEntry >> middlePeriod [
	^ start + end / 2
]

{ #category : #accessing }
RTTimeLineEntry >> start [
	^ start
]

{ #category : #accessing }
RTTimeLineEntry >> start: anInteger [
	start := anInteger
]
