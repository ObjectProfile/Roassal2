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

"
Class {
	#name : #RTFilterInView,
	#superclass : #RTAbstractHighlightElementsInView,
	#instVars : [
		'shouldFilterChildren'
	],
	#category : #'Roassal2-Interactions'
}

{ #category : #hooks }
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

	| elements |
self halt.
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
	self filterChildren
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
		callback: [ self reset ]
]

{ #category : #hooks }
RTFilterInView >> keepOnlyUsing: aString [

	| elements |
	elements := self getRelevantElementsFor: aString.
	shouldFilterChildren ifTrue: [ elements := elements flatCollect: #withAllParentElements ].
	(view elements copyWithoutAll: elements) do: [ :el | el trachelShape hide ].
	view signalUpdate.
]

{ #category : #hooks }
RTFilterInView >> reset [
	view elements do: [ :el | el trachelShape show ].
	view signalUpdate
]
