"
I'm a session builder, I receive collected announcements and split events per computer and per session. Session starts with opening Spotter and finishs on closing Spotter.
"
Class {
	#name : #GTASessionBuilder,
	#superclass : #Object,
	#instVars : [
		'events'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #api }
GTASessionBuilder class >> fromEvents: aCollection [ 
	^ self new events: aCollection; sessions
]

{ #category : #accessing }
GTASessionBuilder >> events: aCollection [ 
	events := aCollection
]

{ #category : #enumerating }
GTASessionBuilder >> sessions [ 
	| borders pairs openOrExit previousAssociation computer |
	events ifEmpty: [ ^ GTAComputer new ].
	borders := events withIndexCollect: [ :event :index |
		event isOpenOrCloseSpotter 
				ifTrue: [ index -> event ]
				ifFalse: [ nil ]
		 ].
	borders := borders select: [ :each | each notNil ].
	pairs := OrderedCollection new.
	openOrExit := #open.
	previousAssociation := borders first.
	borders do: [ :eachAssociation |
		(openOrExit = #open) 
			ifTrue: [ 
				eachAssociation value isOpenSpotter ifTrue: [ 
					pairs addLast: eachAssociation. 
					openOrExit := #exit ] ]
			ifFalse: [ 
				eachAssociation value isCloseSpotter ifTrue: [ 
					pairs at: (pairs size) put: (pairs last) -> eachAssociation. 
					openOrExit := #open ].
				eachAssociation value isOpenSpotter ifTrue: [ 
					pairs at: (pairs size) put: (pairs last) -> previousAssociation.
					pairs addLast: eachAssociation.
					openOrExit := #exit ] ].
		previousAssociation := eachAssociation.
	].
	openOrExit = #exit ifTrue: [ pairs removeLast ].
	computer := pairs collect: [ :eachPair | | open exit |
		open := eachPair key.
		exit := eachPair value.
		GTASession withAll: (events copyFrom: open key to: exit key).
		 ] as: GTAComputer.
	computer do: [ :eachSession | eachSession computer: computer ].
	^ computer
]
