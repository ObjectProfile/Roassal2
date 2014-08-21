Class {
	#name : #RTAbstractFlowLayout,
	#superclass : #RTLayout,
	#instVars : [
		'maxWidth',
		'gapSize'
	],
	#category : #'Roassal2-Layouts'
}

{ #category : #public }
RTAbstractFlowLayout class >> isAbstract [
	^ self name = #RTAbstractFlowLayout
]

{ #category : #'instance creation' }
RTAbstractFlowLayout class >> withMaxWidth: anInteger [
	
	^(self new)
		maxWidth: anInteger;
		yourself
]

{ #category : #'instance creation' }
RTAbstractFlowLayout class >> withMaxWidth: anInteger withGap: anotherInteger [
	
	^(self new)
		maxWidth: anInteger;
		gapSize: anotherInteger;
		yourself
]

{ #category : #accessing }
RTAbstractFlowLayout >> gapSize [
	
	^gapSize
]

{ #category : #accessing }
RTAbstractFlowLayout >> gapSize: aSizeInPixels [
	
	gapSize := aSizeInPixels
]

{ #category : #'initialize-release' }
RTAbstractFlowLayout >> initialize [
	
	super initialize.
	maxWidth := 300.
	gapSize := 5
]

{ #category : #private }
RTAbstractFlowLayout >> maxWidth [
	
	^maxWidth
]

{ #category : #accessing }
RTAbstractFlowLayout >> maxWidth: aSizeInPixels [
	
	maxWidth := aSizeInPixels
]
