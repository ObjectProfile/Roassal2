Class {
	#name : #RTShape,
	#superclass : #RTObject,
	#instVars : [
		'color'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTShape class >> element [

	^ self instance element
]

{ #category : #'as yet unclassified' }
RTShape class >> elementOn: aModel [

	^ self instance elementOn: aModel
]

{ #category : #'as yet unclassified' }
RTShape class >> elementsOn: models [

	^ models collect: [ :m | self instance elementOn: m ]
]

{ #category : #'as yet unclassified' }
RTShape class >> instance [
	^ self new
]

{ #category : #accessing }
RTShape >> color [
	^ color
]

{ #category : #accessing }
RTShape >> color: anObject [
	color := anObject
]

{ #category : #rendering }
RTShape >> colorFor: anElement [
	^ color rtValue: anElement
]

{ #category : #configuration }
RTShape >> defaultColor [

	^ Color veryVeryLightGray
]

{ #category : #public }
RTShape >> element [

	^ RTElement new addShape: self; yourself
]

{ #category : #public }
RTShape >> elementOn: aModel [

	^ RTElement new model: aModel; addShape: self; yourself
]

{ #category : #public }
RTShape >> elementsOn: models [

	^ models collect: [ :m | self elementOn: m ]
]

{ #category : #initialization }
RTShape >> initialize [
	super initialize.
	color := self defaultColor
]

{ #category : #accessing }
RTShape >> instance [
	^ self
]

{ #category : #hooks }
RTShape >> trachelShapeFor: element [
	self subclassResponsibility
]
