Class {
	#name : #RTLayoutBuilder,
	#superclass : #RTObject,
	#instVars : [
		'layout',
		'actionOnEdges',
		'partitions'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #'public - layout' }
RTLayoutBuilder >> cell [
	layout := RTCellLayout new.
	^ layout
]

{ #category : #'public - layout' }
RTLayoutBuilder >> circle [
	layout := RTCircleLayout new.
	^ layout
]

{ #category : #'public - layout' }
RTLayoutBuilder >> circleWithRadius: aRadiusInPixels [
	layout := RTCircleLayout new.
	layout radius: aRadiusInPixels.
	^ layout
]

{ #category : #'public - layout' }
RTLayoutBuilder >> cluster [

	layout := RTClusterLayout new.
	^ layout
]

{ #category : #building }
RTLayoutBuilder >> doActionsOnEdgesFor: elements [
	| allEdges asSet |
	actionOnEdges ifEmpty: [ ^ self ].
	allEdges := OrderedCollection new.
	elements do: [ :e | allEdges addAll: e connectedEdges ].
	asSet := allEdges asSet.
	actionOnEdges
		do: [ :act | 
			asSet
				do: [ :e | 
					e isUsedInLayout
						ifTrue: [ act rtValue: e ] ] ]
]

{ #category : #'public - layout' }
RTLayoutBuilder >> flow [
	layout := RTFlowLayout new.
	^ layout
]

{ #category : #'public - partition' }
RTLayoutBuilder >> for: aBlockCondition use: aLayout [

	partitions add: (Array with: aBlockCondition with: aLayout)
]

{ #category : #'public - layout' }
RTLayoutBuilder >> force [
	layout := RTForceBasedLayout new.
	^ layout
]

{ #category : #'public - layout' }
RTLayoutBuilder >> forceWithCharge: aBlockOrANumber [
	"E.g -300"
	layout := RTForceBasedLayout new.
	layout charge: aBlockOrANumber.
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

{ #category : #'public - partition' }
RTLayoutBuilder >> hasPartition [
	^ partitions notEmpty
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
	partitions := OrderedCollection new
]

{ #category : #accessing }
RTLayoutBuilder >> layout [
	^ layout
]

{ #category : #'public - partition' }
RTLayoutBuilder >> processPartitions: elements [

	| groupOfElements els |
	groupOfElements := OrderedCollection new.
	partitions do: [ :tupple |
		"tupple = { conditionblock . layout }"
		els := elements select: [ :el | tupple first rtValue: el model ].
		tupple second on: els.
		groupOfElements add: els asGroup.
		 ].
	
	layout on: groupOfElements
]

{ #category : #'public - layout' }
RTLayoutBuilder >> radialTree [
	layout := RTRadialTreeLayout new.
	^ layout
]

{ #category : #building }
RTLayoutBuilder >> setUpElements: elements [

	self doActionsOnEdgesFor: elements.
	
	elements do: #updateEdgesOFF.
	self hasPartition
		ifTrue: [ self processPartitions: elements ]
		ifFalse: [ layout on: elements ].
	elements do: #updateEdgesON.
	elements do: #updateConnectedEdges.

]

{ #category : #'public - layout' }
RTLayoutBuilder >> tree [
	actionOnEdges add: [ :edge | edge shape withVerticallAttachPoint ].

	layout := RTTreeLayout new.
	^ layout
]

{ #category : #'public - layout' }
RTLayoutBuilder >> verticalLine [
	layout := RTVerticalLineLayout new.
	^ layout
]
