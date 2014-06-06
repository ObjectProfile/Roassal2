Class {
	#name : #RTGDLayoutB,
	#superclass : #RTGDElement,
	#instVars : [
		'layout',
		'partitions',
		'partionnedGroups'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #public }
RTGDLayoutB >> circle [
	^ self use: RTCenteredCircleLayout new
]

{ #category : #public }
RTGDLayoutB >> circle: aRadius [
	^ self use: (RTCenteredCircleLayout new radius: aRadius)
]

{ #category : #public }
RTGDLayoutB >> cluster [
	^ self use: RTClusterLayout new
]

{ #category : #partitioning }
RTGDLayoutB >> computePartionnedGroups [
	"Return a collection of RTGroup, each being a partition"
	| els result t |
	result := OrderedCollection new.
	els := self elementsToConsider.
	
	"This is a bit ugly. Probably something better will have to come up"
	partitions ifEmpty: [ ^ RTGroup withAll: els ].
	
	partitions do: [ :p |
		t := els select: [ :el | p rtValue: el model ].
		els := els copyWithoutAll: t.
		result add: (RTGroup withAll: t)
		].
	^ result
]

{ #category : #utility }
RTGDLayoutB >> elementsToConsider [
	"Return the list of elements that has to be considered by the layout"
	^ self view elements select: [ :e | condition rtValue: e model ]
]

{ #category : #execute }
RTGDLayoutB >> execute [
	"Apply the layout"
	"We have the following strategy. If no partition had been defined on myself, then I do the layout on the partitionned group. If at least one partition has been made, then I do the layout on the partitions"
	
	self numberOfPartitions isZero
		ifTrue: [ layout on: (self partionnedGroups select: [ :e | condition rtValue: e model ]) edges: graphBuilder edgesUsedForLayout ]
		ifFalse: 
			[ self partionnedGroups do: [ :group |
				layout on: group edges: graphBuilder edgesUsedForLayout ] ]
]

{ #category : #public }
RTGDLayoutB >> flow [
	^ self use: (RTFlowLayout new maxWidth: 800)
]

{ #category : #public }
RTGDLayoutB >> force [
	^ self use: RTForceBasedLayout new
]

{ #category : #public }
RTGDLayoutB >> forceCharge: v [
	self force charge: v
]

{ #category : #public }
RTGDLayoutB >> grid [
	^ self use: RTGridLayout new
]

{ #category : #public }
RTGDLayoutB >> horizontal [
	^ self use: RTHorizontalLineLayout new
]

{ #category : #initialization }
RTGDLayoutB >> initialize [
	super initialize.
	self if: true.
	partitions := OrderedCollection new.
]

{ #category : #accessing }
RTGDLayoutB >> numberOfPartitions [
	^ partitions size
]

{ #category : #accessing }
RTGDLayoutB >> partionnedGroups [
	"Return the list of partioned groups. If none is set, then compute them"
	partionnedGroups ifNil: [ partionnedGroups := self computePartionnedGroups ].
	^ partionnedGroups 
]

{ #category : #accessing }
RTGDLayoutB >> partionnedGroups: groups [
	"set the partionned group."
	partionnedGroups := groups
]

{ #category : #partitioning }
RTGDLayoutB >> partition: aBlock [
	"Main methods to partition the elements given to the graph builder"
	"aBlock takes as argument an element, and return true or false"
	partitions add: aBlock 
]

{ #category : #public }
RTGDLayoutB >> radial [
	^ self use: RTRadialTreeLayout new
]

{ #category : #public }
RTGDLayoutB >> translateBy: aPoint [

	self use: (RTTranslationLayout new step: aPoint)
]

{ #category : #public }
RTGDLayoutB >> tree [
	^ self use: RTTreeLayout new
]

{ #category : #public }
RTGDLayoutB >> use: aLayout [
	layout := aLayout.
	^ aLayout
]
