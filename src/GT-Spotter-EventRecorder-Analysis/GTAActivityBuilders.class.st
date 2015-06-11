Class {
	#name : #GTAActivityBuilders,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Activity'
}

{ #category : #adding }
GTAActivityBuilders >> addEdges [
	self do: #addEdges
]

{ #category : #building }
GTAActivityBuilders >> build [
	self do: #build.
	self layoutSessions
]

{ #category : #testing }
GTAActivityBuilders >> isWithEdges [
	^ self anyOne isWithEdges
]

{ #category : #accessing }
GTAActivityBuilders >> layout [
	^ self anyOne layout
]

{ #category : #layout }
GTAActivityBuilders >> layoutElements [
	self do: #layoutElements.
	self layoutSessions
]

{ #category : #layout }
GTAActivityBuilders >> layoutSessions [
	| previousBuilder |
	self
		withIndexDo: [ :builder :index | 
			builder layoutElements.
			index > 1
				ifTrue: [ TRConstraint move: builder elements belowAlignFromLeft: previousBuilder elements gap: 20 ].
			previousBuilder := builder ]
]

{ #category : #configuration }
GTAActivityBuilders >> logicalLayout [
	self do: #logicalLayout
]

{ #category : #configuration }
GTAActivityBuilders >> realLayout [
	self do: #realLayout
]

{ #category : #'as yet unclassified' }
GTAActivityBuilders >> removeAllElementsAndEdges [
	self do: #removeAllElementsAndEdges
]

{ #category : #'event handling' }
GTAActivityBuilders >> removeEdges [
	self do: #removeEdges
]

{ #category : #accessing }
GTAActivityBuilders >> shape [
	^ self collect: #shape as: GTAShapeBuilders
]

{ #category : #signalling }
GTAActivityBuilders >> signalUpdate [
	self ifEmpty: [ ^ self ].
	self view signalUpdate
]

{ #category : #accessing }
GTAActivityBuilders >> view [
	^ self anyOne view
]

{ #category : #configuration }
GTAActivityBuilders >> withEdges [
	self do: #withEdges
]

{ #category : #configuration }
GTAActivityBuilders >> withoutEdges [
	self do: #withoutEdges
]
