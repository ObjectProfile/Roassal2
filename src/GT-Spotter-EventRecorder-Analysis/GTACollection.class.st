Class {
	#name : #GTACollection,
	#superclass : #OrderedCollection,
	#traits : 'TGTSpotterCategoryView',
	#classTraits : 'TGTSpotterCategoryView classTrait',
	#instVars : [
		'options'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #accessing }
GTACollection >> categoryLabel [
	^ self optionAt: #categoryLabel
]

{ #category : #accessing }
GTACollection >> categoryLabel: aString [ 
	^ self optionAt: #categoryLabel put: aString
]

{ #category : #accessing }
GTACollection >> duration [
	^ self end - self start
]

{ #category : #accessing }
GTACollection >> end [
	^ (self detectMax: #end) ifNil: [ 0 ] ifNotNil: [ :obj | obj end ]
]

{ #category : #accessing }
GTACollection >> optionAt: key [
	^ self optionAt: key ifAbsent: [ nil ]
]

{ #category : #accessing }
GTACollection >> optionAt: key ifAbsent: absentBlock [
	options ifNil: [ ^ absentBlock value ].
	^ options at: key ifAbsent: absentBlock
]

{ #category : #accessing }
GTACollection >> optionAt: key ifAbsentPut: absentBlock [
	options ifNil: [ options := Dictionary new ].
	^ options at: key ifAbsentPut: absentBlock
]

{ #category : #accessing }
GTACollection >> optionAt: key put: value [
	options ifNil: [ options := Dictionary new ].
	^ options at: key put: value
]

{ #category : #removing }
GTACollection >> removeOptionKey: key [ 
	^ self removeOptionKey: key ifAbsent: [ "ignore" ]
]

{ #category : #removing }
GTACollection >> removeOptionKey: key ifAbsent: absentBlock [
	options ifNil: [ ^ absentBlock value].
	^ options removeKey: key ifAbsent: absentBlock
]

{ #category : #accessing }
GTACollection >> start [
	^ (self detectMin: #start) ifNil: [ 0 ] ifNotNil: [ :obj | obj start ]
]
