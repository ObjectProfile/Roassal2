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

{ #category : #'as yet unclassified' }
RTShape >> element [

	^ RTElement new addShape: self; yourself
]

{ #category : #'as yet unclassified' }
RTShape >> elementOn: aModel [

	^ RTElement new model: aModel; addShape: self; yourself
]

{ #category : #'as yet unclassified' }
RTShape >> initialize [
	super initialize.
	color := self defaultColor
]

{ #category : #'as yet unclassified' }
RTShape >> instance [
	^ self
]

{ #category : #'as yet unclassified' }
RTShape >> renderOn: trachelCanvas for: aShapedObject [
	self subclassResponsibility
]
