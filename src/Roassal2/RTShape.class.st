Class {
	#name : #RTShape,
	#superclass : #RTObject,
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

{ #category : #'as yet unclassified' }
RTShape >> element [

	^ RTElement new addShape: self; yourself
]

{ #category : #'as yet unclassified' }
RTShape >> elementOn: aModel [

	^ RTElement new model: aModel; addShape: self; yourself
]

{ #category : #'as yet unclassified' }
RTShape >> instance [
	^ self
]

{ #category : #'as yet unclassified' }
RTShape >> renderOn: trachelCanvas for: aShapedObject [

	self subclassResponsibility
]
