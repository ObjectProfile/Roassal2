Class {
	#name : #TRResetAllShapes,
	#superclass : #Object,
	#instVars : [
		'trCanvas'
	],
	#category : #'Trachel-Core'
}

{ #category : #accessing }
TRResetAllShapes >> addedIn: aTRCanvas [
	self trCanvas: aTRCanvas
]

{ #category : #testing }
TRResetAllShapes >> hasCompleted [
	^ false
]

{ #category : #refreshing }
TRResetAllShapes >> refresh [
	self resetShapes
]

{ #category : #action }
TRResetAllShapes >> resetShapes [
	trCanvas shapes do: #resetPath
]

{ #category : #accessing }
TRResetAllShapes >> start [
	self resetShapes
]

{ #category : #accessing }
TRResetAllShapes >> trCanvas [
	^ trCanvas
]

{ #category : #accessing }
TRResetAllShapes >> trCanvas: anObject [
	trCanvas := anObject
]
