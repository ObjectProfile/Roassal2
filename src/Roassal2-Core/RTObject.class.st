"
Root of most of the Roassal classes.
"
Class {
	#name : #RTObject,
	#superclass : #Object,
	#category : #'Roassal2-Core-Base'
}

{ #category : #'as yet unclassified' }
RTObject class >> basicNew [
	^ super basicNew
]

{ #category : #converting }
RTObject >> asGroup [

	self
		deprecated: 'Use #asRTGroup for Roassal3/Pharo9+ compatibility'
		on: '2022-03-18'
		in: #Pharo9
		transformWith: '`@receiver asGroup' -> '`@receiver asRTGroup'.
	^ self asRTGroup
]

{ #category : #converting }
RTObject >> asRTGroup [
	^ RTGroup with: self

]
