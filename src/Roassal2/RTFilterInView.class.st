"
This interaction adds a set of menu in the view to filter in and out some elements
Here is an example:
-=-=-=
| b |
b := RTMondrian new.
b shape box size: #numberOfMethods.
b nodes: (Collection withAllSubclasses).
b layout grid.
b normalizer normalizeColor: #numberOfMethods.
b view @ RTFilterInView.
b 
-=-=-=

With edges:
-=-=-=
| b |
b := RTMondrian new.
b shape box size: #numberOfMethods.
b nodes: (Collection withAllSubclasses).
b normalizer normalizeColor: #numberOfMethods.
b edges connectFrom: #superclass.
b layout tree.

b view @ RTFilterInView.

b 
-=-=-=

Example using the spawn block:
-=-=-=
| b |
b := RTMondrian new.
b shape box size: #numberOfMethods.
b nodes: (Collection withAllSubclasses).
b layout grid.
b normalizer normalizeColor: #numberOfMethods.

filter := RTFilterInView new.
filter spawnBlock: [ :el | RTView new addAll: el copy; yourself ].
b view @ filter.
b 
-=-=-=
"
Class {
	#name : #RTFilterInView,
	#superclass : #RTAbstractHighlightElementsInView,
	#instVars : [
		'shouldFilterChildren',
		'spawnBlock'
	],
	#category : #'Roassal2-Interactions'
}

{ #category : #'private - action' }
RTFilterInView >> askForPattern [
	^ TRPlatform current
		dialogRequest:
			'Enter a regular expression'
		initialAnswer: '*aPattern*'
]

{ #category : #'public - configuration' }
RTFilterInView >> doNotFilterChildren [
	"Children of a matched element should are not considered"
	shouldFilterChildren := false
]

{ #category : #'public - configuration' }
RTFilterInView >> filterChildren [
	"Children of a matched element should also be considered"
	shouldFilterChildren := true
]

{ #category : #hooks }
RTFilterInView >> filterOutUsing: aString [
	"Filter out all the elements whose printstring of the model matches aString"
	| elements |
	elements := self getRelevantElementsFor: aString.
	elements do: [ :el | el trachelShape hide ].
	view signalUpdate.
]

{ #category : #initialization }
RTFilterInView >> getRelevantElementsFor: string [
	"Return the list of elements found in the view that matches the string"
	| els |
	els := super getRelevantElementsFor: string.
	^ shouldFilterChildren ifTrue: [ els, (els flatCollect: #nestedElements) ] ifFalse: [ els ]
]

{ #category : #initialization }
RTFilterInView >> initialize [
	super initialize.
	self filterChildren.
	
	"But having this variable at nil, no spawn option is offered"
	spawnBlock := nil.
]

{ #category : #hooks }
RTFilterInView >> initializeElement: aView [
	| string |
	super initializeElement: aView.
	view
		addMenu: 'OnlyKeep'
		callback: [ string := self askForPattern.
			string ifNotNil:
				[ self keepOnlyUsing: string ] ].

	view
		addMenu: 'FilterOut'
		callback: [ string := self askForPattern.
			string ifNotNil:
				[ self filterOutUsing: string ] ].
		
	view
		addMenu: 'Reset'
		callback: [ self reset ].
		
	self shouldOfferSpawn ifTrue: [ 
		view addMenu: 'Inspect'
			callback: [ self inspectMarkedVisibleElements ]
	]
]

{ #category : #'private - action' }
RTFilterInView >> inspectMarkedVisibleElements [
	| elements |
	elements := view elements select: [ :e | e trachelShape isMarkedAsVisible ].
	(spawnBlock rtValue: elements) inspect
]

{ #category : #hooks }
RTFilterInView >> keepOnlyUsing: aString [
	"Keeo all the elements whose printstring of the model matches aString"
	| elements |
	elements := self getRelevantElementsFor: aString.
	shouldFilterChildren ifTrue: [ elements := elements flatCollect: #withAllParentElements ].
	(view elements copyWithoutAll: elements) do: [ :el | el trachelShape hide ].
	view signalUpdate.
]

{ #category : #'private - action' }
RTFilterInView >> reset [
	"Make all the elements visible again"
	view elements do: [ :el | el trachelShape show ].
	view signalUpdate
]

{ #category : #testing }
RTFilterInView >> shouldOfferSpawn [
	"Return true if the option should be offered"
	^ spawnBlock notNil
]

{ #category : #accessing }
RTFilterInView >> spawnBlock [
	"Return the block used for the spawning. Return nil if none is set"
	^ spawnBlock
]

{ #category : #accessing }
RTFilterInView >> spawnBlock: aOneArgBlock [
	"Set the block used to inspect the marked as visible elements.
	The argument of the block is the list of all the Roassal Elements whose trachel shape is marked as visible."
	spawnBlock := aOneArgBlock
]
