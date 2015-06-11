Class {
	#name : #GTAAnnouncements,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #'instance creation' }
GTAAnnouncements class >> fromByteArray: aByteArray [
	^ self with: (GTSpotterEventRecorder materialize: aByteArray)
]

{ #category : #'instance creation' }
GTAAnnouncements class >> fromDirectory: aFileReference [
	"self fromDirectory: './gt/events/' asFileReference"
	^ self 
		withAll: (GTSpotterEventRecorder materializeObjectsFromDirectory: aFileReference)
]

{ #category : #'instance creation' }
GTAAnnouncements class >> fromLocalDirectory [
	GTATool ensureLocalDirectory.
	^ self fromDirectory: './gt/events/' asFileReference
]

{ #category : #helpers }
GTAAnnouncements class >> spotterDevelopers [
	"self spotterDevelopers"
	^ self fromLocalDirectory 
			withoutEmptyComputerUUID
				developers
					sessionsPerComputer
						sessionsWithNumberOfInputsGreaterThenOne
]

{ #category : #helpers }
GTAAnnouncements class >> spotterUsers [
	"self spotterUsers"
	^ self fromLocalDirectory 
			withoutEmptyComputerUUID
				users
					sessionsPerComputer
						sessionsWithNumberOfInputsGreaterThenOne
]

{ #category : #helpers }
GTAAnnouncements class >> spotterUsersAndDevelopers [
	"self spotterUsersAndDevelopers"
	^ self fromLocalDirectory 
			withoutEmptyComputerUUID
				withoutEventsBeforePharo4Release
					sessionsPerComputer
						"sessionsWithNumberOfInputsGreaterThenOne"
]

{ #category : #helpers }
GTAAnnouncements class >> spotterUsersAndDevelopersFrom: aByteArray [
	^ (self fromByteArray: aByteArray) sessionsPerComputer

]

{ #category : #'instance creation' }
GTAAnnouncements class >> spotterUsersAndDevelopersFromAllByteArrays: aCollection [ 
	^ (self withAll: (aCollection collect: [ :eachByteArray | 
				GTSpotterEventRecorder materialize: eachByteArray ])) sessionsPerComputer
]

{ #category : #accessing }
GTAAnnouncements >> developerUUIDs [
	^ GTAConfiguration developerUUIDs
]

{ #category : #enumerating }
GTAAnnouncements >> developers [
	^ self select: [ :each | self developerUUIDs includes: each computerUUID asString ]
]

{ #category : #accessing }
GTAAnnouncements >> numberOfComputers [
	^ self perComputer size
]

{ #category : #enumerating }
GTAAnnouncements >> perComputer [
	^ (self groupedBy: [ :each | each computerUUID asString]) as: GTAAnnouncements
]

{ #category : #enumerating }
GTAAnnouncements >> sessions [
	^ GTASessionBuilder fromEvents: (
			self flatCollect: #events as: OrderedCollection)
]

{ #category : #enumerating }
GTAAnnouncements >> sessionsPerComputer [
	| group computers |
	group := self perComputer.
	computers := group collect: [ :eachComputer |
		eachComputer sortByTimestamp.
		eachComputer sessions.
	] as: GTAComputers.
	computers := computers removeAllSuchThat: #isEmpty.
	computers do: [ :eachComputer | 
		eachComputer computers: computers.
		eachComputer sortByDateAndTime ].
	computers sortByDevelopersAndNumberOfSessions.
	computers updateEvents.
	^ computers
]

{ #category : #sorting }
GTAAnnouncements >> sortByTimestamp [
	^ self sort: [ :a :b | a timestamp < b timestamp ]
]

{ #category : #enumerating }
GTAAnnouncements >> users [
	^ self select: [ :each | (self developerUUIDs includes: each computerUUID asString) not ]
]

{ #category : #enumerating }
GTAAnnouncements >> withoutEmptyComputerUUID [
	^ self select: [ :each | each computerUUID notNil and: [ (each computerUUID = 'nil') not ] ]
]

{ #category : #enumerating }
GTAAnnouncements >> withoutEventsBeforePharo4Release [
	^ self select: [ :eachAnnouncement |
			eachAnnouncement latestUpdate >= GTAConfiguration pharo4HighestUpdate ]
]
