Class {
	#name : #RTAnnounceableObject,
	#superclass : #RTObject,
	#instVars : [
		'announcer'
	],
	#category : #'Roassal2-Core'
}

{ #category : #adding }
RTAnnounceableObject >> @ anInteractionClassOrInstance [
	"Add an interaction to the node"
	
	self addInteraction: anInteractionClassOrInstance
]

{ #category : #adding }
RTAnnounceableObject >> addInteraction: anInteractionClassOrInstance [
 	anInteractionClassOrInstance initializeElement: self
]

{ #category : #announce }
RTAnnounceableObject >> announce: evt [
	| t |
	t := evt asAnnouncement.
	t shape: self trachelShape.
	self announcer announce: evt
]

{ #category : #accessing }
RTAnnounceableObject >> announcer [
	announcer ifNil: [ self announcer: Announcer new ].
	^ announcer
]

{ #category : #accessing }
RTAnnounceableObject >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #interaction }
RTAnnounceableObject >> when: evt do: aBlock [
	self announcer when: evt do: aBlock
]
