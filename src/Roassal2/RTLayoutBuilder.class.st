Class {
	#name : #RTLayoutBuilder,
	#superclass : #RTObject,
	#instVars : [
		'layout'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #'public - layout' }
RTLayoutBuilder >> cell [
	layout := RTCellLayout new.
	^ layout
]

{ #category : #'public - layout' }
RTLayoutBuilder >> flow [
	layout := RTFlowLayout new.
	^ layout
]

{ #category : #configuring }
RTLayoutBuilder >> gapSize: aValue [
	layout gapSize: aValue
]

{ #category : #'public - layout' }
RTLayoutBuilder >> grid [
	layout := RTGridLayout new.
	^ layout
]

{ #category : #'public - layout' }
RTLayoutBuilder >> horizontalLine [
	layout := RTHorizontalLineLayout new.
	^ layout
]

{ #category : #initialization }
RTLayoutBuilder >> initialize [
	super initialize.
	layout := RTFlowLayout new.
]

{ #category : #accessing }
RTLayoutBuilder >> layout [
	^ layout
]

{ #category : #building }
RTLayoutBuilder >> setUpElements: elements [
	layout on: elements
]
