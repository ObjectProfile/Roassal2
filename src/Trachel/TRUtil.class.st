Class {
	#name : #TRUtil,
	#superclass : #Object,
	#classInstVars : [
		'instance'
	],
	#category : #'Trachel-Core'
}

{ #category : #accessing }
TRUtil class >> instance [
	^ instance ifNil: [ instance := self new ]
]

{ #category : #'as yet unclassified' }
TRUtil >> widgetFactory [
	^ TRMorphWidgetFactory
]
