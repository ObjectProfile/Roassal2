Class {
	#name : #GTAMultipleSelectionSendCommand,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Utilities'
}

{ #category : #api }
GTAMultipleSelectionSendCommand class >> selection: result in: aCollection [
	^ self new selection: result in: aCollection
]

{ #category : #api }
GTAMultipleSelectionSendCommand class >> selection: result in: aCollection as: aCollectionClass [
	^ self new selection: result in: aCollection as: aCollectionClass
]

{ #category : #accessing }
GTAMultipleSelectionSendCommand class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #api }
GTAMultipleSelectionSendCommand >> selection: result in: aCollection [
	^ self selection: result in: aCollection as: aCollection species
]

{ #category : #api }
GTAMultipleSelectionSendCommand >> selection: result in: aCollection as: aCollectionClass [
	^ result notNil 
		ifTrue: [ 
			(result size = 1)
				ifTrue: [result anyOne] 
				ifFalse: [ aCollectionClass withAll: result ] ]
		ifFalse: [ result ]
]
