Class {
	#name : #TRExtensibleLabelShape,
	#superclass : #TRLabelShape,
	#category : #'Trachel-Core'
}

{ #category : #'as yet unclassified' }
TRExtensibleLabelShape >> extent: newExtent [
	| oldExtent |
	oldExtent := self extent.
	(oldExtent = (0 @ 0)) ifTrue: [ ^ self ].
	matrix scaleBy: newExtent / oldExtent.
	self triggerCallbacksForNewExtent: newExtent oldExtent: oldExtent.

]
