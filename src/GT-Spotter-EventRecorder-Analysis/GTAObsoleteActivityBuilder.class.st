Class {
	#name : #GTAObsoleteActivityBuilder,
	#superclass : #Object,
	#instVars : [
		'data',
		'view'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Obsolete'
}

{ #category : #api }
GTAObsoleteActivityBuilder class >> viewOn: objects [
	^ self new
			data: objects;
			build;
			view
]

{ #category : #building }
GTAObsoleteActivityBuilder >> build [
	| shape elements visibleData levels |
	view := RTView new.
	view @ RTDraggableView.
	shape := RTBitmap new.
	shape form: #analysisIcon.
	visibleData := self visibleData.
	levels := visibleData deepestDiveIn.
	elements := shape elementsOn: visibleData.
	elements @ RTDraggable @ (RTPopup text: #asEventAnalysisString).
	view addAll: elements.
	"RTGridLayout on: elements."
	RTMetricNormalizer new
		elements: elements;
		normalizeX: [ :eachEvent | self xFor: eachEvent ] min: 0 max: 500;
		normalizeY: [ :eachEvent | self yFor: eachEvent ] min: 0 max: (levels * 4).

]

{ #category : #accessing }
GTAObsoleteActivityBuilder >> data [
	^ data
]

{ #category : #accessing }
GTAObsoleteActivityBuilder >> data: anObject [
	data := anObject
]

{ #category : #accessing }
GTAObsoleteActivityBuilder >> view [
	^ view
]

{ #category : #accessing }
GTAObsoleteActivityBuilder >> view: anObject [
	view := anObject
]

{ #category : #enumerating }
GTAObsoleteActivityBuilder >> visibleData [
	^ self data select: #isForTimelineView
]

{ #category : #accessing }
GTAObsoleteActivityBuilder >> xFor: aSpotterEvent [
	| currentTimeStamp index events nextTimestamp duration relIndex relDuration xPosition |
	aSpotterEvent relativeXPosition ifNotNil: [ :value | ^ value ].
	currentTimeStamp := aSpotterEvent dateAndTimeWithFixedTimeZone.
	index := aSpotterEvent myPositionAmongSameTimeEvents - 1.
	events := aSpotterEvent sameTimeEvents size.
	events < 2 ifTrue: [ 
		aSpotterEvent relativeXPosition: currentTimeStamp. 
		^ currentTimeStamp ].
	relIndex := index / events.
	nextTimestamp := aSpotterEvent followingDifferentTime.
	duration := nextTimestamp - currentTimeStamp / 2.
	relDuration := duration * relIndex.
	xPosition := currentTimeStamp + relDuration.
	aSpotterEvent relativeXPosition: xPosition.
	^ xPosition
]

{ #category : #accessing }
GTAObsoleteActivityBuilder >> yFor: aSpotterEvent [
	^ aSpotterEvent diveInLevel
]
