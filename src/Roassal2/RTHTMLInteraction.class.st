Class {
	#name : #RTHTMLInteraction,
	#superclass : #RTObject,
	#instVars : [
		'type',
		'target',
		'contained',
		'external'
	],
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #'as yet unclassified' }
RTHTMLInteraction class >> on: anHTMLExporter targets: aRTShape [
	| generator |
	generator := [ :e |  self new target: e;  yourself ].
	self on: anHTMLExporter targets: aRTShape generator: generator
]

{ #category : #'as yet unclassified' }
RTHTMLInteraction class >> on: anHTMLExporter targets: aRTShape generator: generator [
	| interaction |
	anHTMLExporter view elements
		do: [ :e | 
			e trachelShape class = aRTShape
				ifTrue: [ 
					interaction := generator value: e.
					anHTMLExporter interactions at: e ifAbsent: [ anHTMLExporter interactions at: e put: OrderedCollection new ].
					(anHTMLExporter interactions at: e) add: interaction ] ]
]

{ #category : #adding }
RTHTMLInteraction >> addEventHandlers: aStream id: aString element: aRTElement center: aPoint [
	self subclassResponsibility 
]

{ #category : #adding }
RTHTMLInteraction >> addFunctions: aStream [
	self subclassResponsibility
]

{ #category : #accessing }
RTHTMLInteraction >> contained [
	^contained
]

{ #category : #accessing }
RTHTMLInteraction >> external [
	^external
]

{ #category : #'as yet unclassified' }
RTHTMLInteraction >> initialize [
	super initialize.
	self type: 'interaction'
]

{ #category : #accessing }
RTHTMLInteraction >> target [
	^ target
]

{ #category : #accessing }
RTHTMLInteraction >> target: anObject [
	target := anObject
]

{ #category : #accessing }
RTHTMLInteraction >> type [
	^ type
]

{ #category : #accessing }
RTHTMLInteraction >> type: anObject [
	type := anObject
]
