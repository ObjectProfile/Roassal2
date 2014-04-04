Class {
	#name : #RTSVGInteraction,
	#superclass : #RTObject,
	#instVars : [
		'type',
		'target',
		'contained',
		'external'
	],
	#category : #'Roassal2-Exporter-SVG'
}

{ #category : #'as yet unclassified' }
RTSVGInteraction class >> on: anHTMLExporter targets: aRTShape [
	| generator |
	generator := [ :e |  self new target: e;  yourself ].
	self on: anHTMLExporter targets: aRTShape generator: generator
]

{ #category : #'as yet unclassified' }
RTSVGInteraction class >> on: anHTMLExporter targets: aRTShape generator: generator [
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
RTSVGInteraction >> addEventHandlers: aStream id: aString element: aRTElement center: aPoint [
	self subclassResponsibility 
]

{ #category : #adding }
RTSVGInteraction >> addFunctions: aStream [
	self subclassResponsibility
]

{ #category : #adding }
RTSVGInteraction >> addGlobalHandlers: aStream [
	self subclassResponsibility
]

{ #category : #accessing }
RTSVGInteraction >> contained [
	^contained
]

{ #category : #accessing }
RTSVGInteraction >> external [
	^external
]

{ #category : #'as yet unclassified' }
RTSVGInteraction >> initialize [
	super initialize.
	self type: 'interaction'
]

{ #category : #accessing }
RTSVGInteraction >> target [
	^ target
]

{ #category : #accessing }
RTSVGInteraction >> target: anObject [
	target := anObject
]

{ #category : #accessing }
RTSVGInteraction >> type [
	^ type
]

{ #category : #accessing }
RTSVGInteraction >> type: anObject [
	type := anObject
]
