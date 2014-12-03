Class {
	#name : #RTLayoutBuilder,
	#superclass : #RTObject,
	#instVars : [
		'layout',
		'actionOnEdges'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #'public - layout' }
RTLayoutBuilder >> cell [
	layout := RTCellLayout new.
	^ layout
]

{ #category : #'public - layout' }
RTLayoutBuilder >> cluster [

	layout := RTClusterLayout new.
	^ layout
]

{ #category : #'public - layout' }
RTLayoutBuilder >> flow [
	layout := RTFlowLayout new.
	^ layout
]

{ #category : #'public - layout' }
RTLayoutBuilder >> force [
	layout := RTForceBasedLayout new.
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
	actionOnEdges := OrderedCollection new.
]

{ #category : #accessing }
RTLayoutBuilder >> layout [
	^ layout
]

{ #category : #building }
RTLayoutBuilder >> setUpElements: elements [
	| allEdges |
	allEdges := OrderedCollection new.
	elements do: [ :e | allEdges addAll: e connectedEdges ].
	actionOnEdges do: [ :act | allEdges do: [ :e | act rtValue: e ] ].
	
	layout on: elements
]

{ #category : #'public - layout' }
RTLayoutBuilder >> tree [
	actionOnEdges add: [ :edge | edge shape withVerticallAttachPoint ].

	layout := RTTreeLayout new.
	^ layout
]
