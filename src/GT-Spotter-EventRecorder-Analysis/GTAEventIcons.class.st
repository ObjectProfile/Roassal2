Class {
	#name : #GTAEventIcons,
	#superclass : #Object,
	#category : #'GT-Spotter-EventRecorder-Analysis-Obsolete'
}

{ #category : #icons }
GTAEventIcons class >> actOnIcon [
	^ Smalltalk ui icons glamorousPlay
]

{ #category : #icons }
GTAEventIcons class >> contextChangedIcon [
	^ Smalltalk ui icons glamorousEdit  
]

{ #category : #icons }
GTAEventIcons class >> diveInCategoryIcon [
	^ Smalltalk ui icons glamorousDiveAllRightIcon  
]

{ #category : #icons }
GTAEventIcons class >> diveInCategoryMissStepIcon [
	^ Smalltalk ui icons glamorousDiveAllRightIcon
		deepCopy 
			mapColor: (Color r: 0.581 g: 0.581 b: 0.581 alpha: 1.0)
			to: Color red
]

{ #category : #icons }
GTAEventIcons class >> diveInElementIcon [
	^ Smalltalk ui icons glamorousDiveRightIcon  
]

{ #category : #icons }
GTAEventIcons class >> diveInElementMissStepIcon [
	^ Smalltalk ui icons glamorousDiveRightIcon 
			deepCopy mapColor: Color black to: Color red
]

{ #category : #icons }
GTAEventIcons class >> diveOutIcon [
	^ Smalltalk ui icons glamorousLeft  
]

{ #category : #icons }
GTAEventIcons class >> exitIcon [
	^ Smalltalk ui icons glamorousClose  
]

{ #category : #icons }
GTAEventIcons class >> hidePreviewIcon [
	^ Smalltalk ui icons glamorousZoomOut
]

{ #category : #icons }
GTAEventIcons class >> noIcon [
	^ Smalltalk ui icons protocolNoneIcon
]

{ #category : #icons }
GTAEventIcons class >> selectedCandidateChangedIcon [
	^ Smalltalk ui icons glamorousGrayCircle  
]

{ #category : #icons }
GTAEventIcons class >> showPreviewIcon [
	^ Smalltalk ui icons glamorousZoomIn
]
