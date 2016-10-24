"
I am an interaction to export views with the RTHTML5Exporter and linked it, check my example in RTHTML5Example to get more info.
"
Class {
	#name : #RTLinkView,
	#superclass : #RTInteraction,
	#instVars : [
		'showView',
		'viewBlock',
		'nameBlock'
	],
	#category : #'Roassal2-Exporter-HTML5'
}

{ #category : #visitor }
RTLinkView >> accept: aVisitor with: args [
	aVisitor visitLinkView: self with: args
]

{ #category : #initialization }
RTLinkView >> initialize [
	super initialize.
	showView := false.
]

{ #category : #hooks }
RTLinkView >> initializeElement: element [
	element when: TRMouseLeftClick do: [ 
		showView ifTrue: [ (self viewFor: element) inspect ]. ].
]

{ #category : #accessing }
RTLinkView >> showView [
	showView := true.
]

{ #category : #accessing }
RTLinkView >> view: aBlock [
	self viewElement: [ :e | aBlock rtValue: e model ].
]

{ #category : #accessing }
RTLinkView >> viewBlock [
	^ viewBlock
]

{ #category : #accessing }
RTLinkView >> viewElement: aBlock [
	^ viewBlock := aBlock
]

{ #category : #accessing }
RTLinkView >> viewFor: element [
	^ viewBlock rtValue: element
	
]
