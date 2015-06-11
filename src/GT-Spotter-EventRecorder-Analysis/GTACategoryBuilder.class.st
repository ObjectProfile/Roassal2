Class {
	#name : #GTACategoryBuilder,
	#superclass : #Object,
	#instVars : [
		'builder',
		'collection',
		'sessionsPerInterest'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Category'
}

{ #category : #building }
GTACategoryBuilder >> build [
	| ds points |
	points := self sessionsPerInterest.
	points ifEmpty: [ ^ builder view ].
	builder extent: (points size * 30 min: 800) @ 150.
	ds := RTStackedDataSet new.
	ds interaction highlight.
	ds interaction popup text: [ :obj | obj categoryLabel asString , ', ' , obj size asString , ' times' ].
	ds points: points.
	ds barShape
		color: (Color green alpha: 0.3);
		width: 10.
	ds histogramWithBarTitle: #categoryLabel.
	ds y: [ :obj | obj size ].
	builder add: ds.
	builder axisX
		noTick;
		noLabel.
	builder axisY.
	builder build.
	^ builder view
]

{ #category : #accessing }
GTACategoryBuilder >> collection [
	^ collection
]

{ #category : #accessing }
GTACategoryBuilder >> collection: anObject [
	collection := anObject
]

{ #category : #initialization }
GTACategoryBuilder >> initialize [
	super initialize.
	self initializeBuilder.
	self initiliazeSessionsPerSelectedCategories
]

{ #category : #initialization }
GTACategoryBuilder >> initializeBuilder [
	| view |
	builder ifNotNil: [ view := builder view ].
	builder := RTGrapher new.
	view ifNotNil: [ builder view: view ].
]

{ #category : #initialization }
GTACategoryBuilder >> initiliazeSessionsPerActOnOrCloseActionCategories [
	sessionsPerInterest := [ :aCollection | aCollection sessionsPerActOnOrCloseActionCategories ]
]

{ #category : #initialization }
GTACategoryBuilder >> initiliazeSessionsPerSelectedCategories [
	sessionsPerInterest := [ :aCollection | aCollection sessionsPerSelectedCategories ]
]

{ #category : #building }
GTACategoryBuilder >> rebuild [
	self view removeAllElements.
	self initializeBuilder.
	self build.
	self view signalUpdate.
]

{ #category : #enumerating }
GTACategoryBuilder >> sessionsPerActOnOrCloseActionCategories [
	^ self collection sessionsPerActOnOrCloseActionCategories
]

{ #category : #enumerating }
GTACategoryBuilder >> sessionsPerInterest [
	^ (sessionsPerInterest cull: self collection) sortedAs: [ :x :y | x size > y size ]
]

{ #category : #enumerating }
GTACategoryBuilder >> sessionsPerSelectedCategories [
	^ self collection sessionsPerSelectedCategories
]

{ #category : #accessing }
GTACategoryBuilder >> view [
	^ builder view
]
