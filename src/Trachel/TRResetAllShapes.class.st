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

{ #category : #'as yet unclassified' }
TRResetAllShapes >> hasCompleted [
	^ false
]

{ #category : #'as yet unclassified' }
TRResetAllShapes >> refresh [
	self resetShapes
]

{ #category : #'as yet unclassified' }
TRResetAllShapes >> resetShapes [
	trCanvas shapes do: #resetPath
]

{ #category : #'as yet unclassified' }
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
