Class {
	#name : #RTGDLayoutB,
	#superclass : #RTGDElement,
	#instVars : [
		'layout'
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

{ #category : #execute }
RTGDLayoutB >> execute [
	layout 
		on: (self view elements select: [ :e | condition rtValue: e model ]) 
		edges: graphBuilder edgesUsedForLayout

]

{ #category : #public }
RTGDLayoutB >> flow [
	^ self use: RTFlowLayout new
]

{ #category : #public }
RTGDLayoutB >> force [
	^ self use: RTForceBasedLayout new
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
	self if: true
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
