"
Able to partition a set of elements into groups, and apply a layout within a group and for all the group.
Here is an example:

-=-=-=-=-=-=-=-=-=
classes := (RPackageOrganizer default packageNamed: 'Roassal2') definedClasses.
classes := classes copyWithout: RTObject.

b := RTMondrian new.
b nodes: classes.
b edges connectFrom: #superclass.
b layout partition
	withinGroup: RTTreeLayout;
	forGroups: (RTFlowLayout).
b
-=-=-=-=-=-=-=-=-=


Another example:
-=-=-=-=-=-=-=-=-=
classes := (RPackageOrganizer default packageNamed: 'Roassal2') definedClasses.
classes := classes copyWithout: RTObject.

b := RTMondrian new.
b nodes: classes.
b edges connectFrom: #superclass.
b layout partition
	withinGroup: RTTreeLayout;
	forNotConnected: RTGridLayout;
	forGroups: RTFlowLayout.
b
-=-=-=-=-=-=-=-=-=
"
Class {
	#name : #RTPartitionLayout,
	#superclass : #RTLayout,
	#instVars : [
		'withinGroup',
		'forGroups',
		'forNotConnected'
	],
	#category : #'Roassal2-Layouts'
}

{ #category : #hook }
RTPartitionLayout >> doExecute: someElements [
	"Performs the layout"
	^ forNotConnected 
		ifNil: [ self doExecuteWithoutTreatmentForIsolated: someElements ]
		ifNotNil: [ self doExecuteWithTreatmentForIsolated: someElements ]
]

{ #category : #hook }
RTPartitionLayout >> doExecuteWithTreatmentForIsolated: someElements [
	"Performs the layout"

	| groups isolatedElements nonIsolatedElements |
	"All groups, including isolated elements"
	groups := someElements asGroup groupsOfConnectedElements.
	isolatedElements := groups select: [ :g | g size = 1 ].
	nonIsolatedElements := groups reject: [ :g | g size = 1 ].
	
	nonIsolatedElements do: [ :g | withinGroup on: g ].
	forNotConnected on: isolatedElements.
	
	"We make the group of isolated elements as a group to be layouted"
	nonIsolatedElements add: isolatedElements.
	forGroups on: nonIsolatedElements.
]

{ #category : #hook }
RTPartitionLayout >> doExecuteWithoutTreatmentForIsolated: someElements [
	"Performs the layout"

	| groups |
	groups := someElements asGroup groupsOfConnectedElements.
	groups do: [ :g | withinGroup on: g ].
	forGroups on: groups.
]

{ #category : #accessing }
RTPartitionLayout >> forGroups [
	^ forGroups
]

{ #category : #accessing }
RTPartitionLayout >> forGroups: aLayout [
	forGroups := aLayout
]

{ #category : #accessing }
RTPartitionLayout >> forNotConnected [
	^ forNotConnected
]

{ #category : #accessing }
RTPartitionLayout >> forNotConnected: aLayout [
	forNotConnected := aLayout
]

{ #category : #initialization }
RTPartitionLayout >> initialize [
	super initialize.
	
	withinGroup := RTGridLayout.
	forGroups := RTGridLayout.
	
	"We leave it to nil for now."
 	forNotConnected := nil
]

{ #category : #accessing }
RTPartitionLayout >> withinGroup [
	^ withinGroup
]

{ #category : #accessing }
RTPartitionLayout >> withinGroup: aLayout [
	withinGroup := aLayout
]
