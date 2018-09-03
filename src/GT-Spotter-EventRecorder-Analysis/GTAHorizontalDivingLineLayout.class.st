Class {
	#name : #GTAHorizontalDivingLineLayout,
	#superclass : #RTHorizontalLineLayout,
	#instVars : [
		'diveInLevel'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Activity'
}

{ #category : #accessing }
GTAHorizontalDivingLineLayout >> diveElement: eachElement [
	^ (self diveInLevel cull: eachElement cull: self)
 			* self diveStep
]

{ #category : #hook }
GTAHorizontalDivingLineLayout >> diveElements: elements [
	elements do: [ :eachElement | eachElement translateBy: 0 @ (self diveElement: eachElement) ]
]

{ #category : #accessing }
GTAHorizontalDivingLineLayout >> diveInLevel [
	^ diveInLevel ifNil: [ diveInLevel := self newDiveInLevel ]
]

{ #category : #accessing }
GTAHorizontalDivingLineLayout >> diveStep [
	^ 5
]

{ #category : #hook }
GTAHorizontalDivingLineLayout >> doExecute: elements [
	super doExecute: elements.
	self diveElements: elements
]

{ #category : #'initialize-release' }
GTAHorizontalDivingLineLayout >> initialize [
	super initialize.
	horizontalGap := 2.
	self alignCenter.
]

{ #category : #'instance creation' }
GTAHorizontalDivingLineLayout >> newDiveInLevel [
	^ [ :element | #diveInLevel cull: element model ]
]
