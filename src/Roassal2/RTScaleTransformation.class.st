Class {
	#name : #RTScaleTransformation,
	#superclass : #RTObject,
	#classInstVars : [
		'instance'
	],
	#category : #'Roassal2-Scaling'
}

{ #category : #accessing }
RTScaleTransformation class >> instance [
	instance ifNil: [ instance := self new ].
	^ instance
]

{ #category : #hooks }
RTScaleTransformation >> invTrans: value [
	self subclassResponsibility
]

{ #category : #accessing }
RTScaleTransformation >> rtValue: aValue [
	^ self trans: aValue
]

{ #category : #hooks }
RTScaleTransformation >> trans: value [
	self subclassResponsibility
]
