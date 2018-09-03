Class {
	#name : #GTAShapeBuilders,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Activity'
}

{ #category : #shapes }
GTAShapeBuilders >> flexibleResultShapes [
	self do: #flexibleResultShapes
]

{ #category : #shapes }
GTAShapeBuilders >> oblique [
	self do: #oblique
]

{ #category : #shapes }
GTAShapeBuilders >> orthogonal [
	self do: #orthogonal
]

{ #category : #accessing }
GTAShapeBuilders >> shape [
	self ifEmpty: [ ^ nil ].
	^ self anyOne shape
]
