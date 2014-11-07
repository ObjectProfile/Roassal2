"
A RTAnnounceableObject is the root of the class hierarchy to have an announcer, useful to define event callbacks.

Instance Variables
	announcer:		<Object>

announcer
	- xxxxx

"
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
	"Announce the event. If a callback for the event evt is defined, then it is executed, with myself as argument."
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
RTAnnounceableObject >> when: evt do: aOneArgBlock [
	"Define a callback for the event evt (which could be a class event or an instance of a class event. aOneArgBlock is evaluated whenever the event is received."
	self announcer when: evt do: aOneArgBlock
]
