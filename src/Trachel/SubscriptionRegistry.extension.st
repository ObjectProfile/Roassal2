Extension { #name : #SubscriptionRegistry }

{ #category : #'*Trachel' }
SubscriptionRegistry >> getInteractionForClass: eventClass [
	"Return true if the receiver has a callback subscripbed for the event class"
	subscriptions do: [ :sub | 
		((sub subscriber class == eventClass) or: 
			[ sub subscriber class inheritsFrom: eventClass ]) ifTrue: [ ^ sub subscriber ] ].

	self error: 'Please, use handleEventClass: before getting the interaction'	

]

{ #category : #'*Trachel' }
SubscriptionRegistry >> handleEventClass: eventClass [
	"Return true if the receiver has a callback subscripbed for the event class"
	^ subscriptions anySatisfy: [ :sub | 
		(sub announcementClass == eventClass) or: 
			[ sub announcementClass inheritsFrom: eventClass ] ]
]

{ #category : #'*Trachel' }
SubscriptionRegistry >> handleSubscriberClass: eventClass [
	"Return true if the receiver has a callback subscripbed for the event class"
	^ subscriptions anySatisfy: [ :sub | 
		(sub subscriber class == eventClass) or: 
			[ sub subscriber class inheritsFrom: eventClass ] ]
]

{ #category : #'*Trachel' }
SubscriptionRegistry >> trSubscriptions [
	^ subscriptions 
]
