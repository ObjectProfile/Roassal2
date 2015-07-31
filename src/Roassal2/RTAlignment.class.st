"
Define alignment of elements. 

For example, inspect the following:
-=-=-=
	objects := TRShape withAllSubclasses.
	v := RTView new.
	n := RTMultiLinearColorForIdentity new objects: objects.
	shape := RTBox new color: n; size: #numberOfMethods.
	es := shape elementsOn: objects.
	v addAll: es.
	RTHorizontalLineLayout new gapSize: 0; on: es.
	RTAlignment new elements: es; fromTop.
	v
-=-=-=
"
Class {
	#name : #RTAlignment,
	#superclass : #RTObject,
	#instVars : [
		'elements'
	],
	#category : #'Roassal2-Core'
}

{ #category : #public }
RTAlignment >> alignFromBottomUsing: anElement [
	| topY newY |
	topY := anElement encompassingRectangle bottomCenter y.
	elements do: [ :s |
		newY := topY - (s encompassingRectangle height / 2).
		s translateTo: s position x @ newY
	]
]

{ #category : #public }
RTAlignment >> alignFromLeftUsing: anElement [
	| topX newX |
	topX := anElement encompassingRectangle topLeft x.
	elements do: [ :s |
		newX := topX + (s encompassingRectangle width / 2).
		s translateTo: newX @ s position y
	]
]

{ #category : #public }
RTAlignment >> alignFromRightUsing: anElement [
	| topX newX |
	topX := anElement encompassingRectangle topRight x.
	elements do: [ :s |
		newX := topX - (s encompassingRectangle width / 2).
		s translateTo: newX @ s position y
	]
]

{ #category : #public }
RTAlignment >> alignFromTopUsing: anElement [
	| topY newY |
	topY := anElement encompassingRectangle topCenter y.
	elements do: [ :s |
		newY := topY + (s encompassingRectangle height / 2).
		s translateTo: s position x @ newY
	]
]

{ #category : #'accessing - computed' }
RTAlignment >> bottomMostElement [
	^ elements inject: elements first into: [ :maxS :s | 
			maxS encompassingRectangle top <= s encompassingRectangle top
					ifTrue: [ s ] ifFalse: [ maxS ] ] 
]

{ #category : #accessing }
RTAlignment >> elements [
	^ elements
]

{ #category : #accessing }
RTAlignment >> elements: someElements [
	elements := someElements asGroup
]

{ #category : #public }
RTAlignment >> fromBottom [

	self alignFromBottomUsing: self bottomMostElement 
]

{ #category : #public }
RTAlignment >> fromLeft [

	self alignFromLeftUsing: self leftMostElement 
]

{ #category : #public }
RTAlignment >> fromRight [

	self alignFromRightUsing: self rightMostElement 
]

{ #category : #public }
RTAlignment >> fromTop [

	self alignFromTopUsing: self topMostElement 
]

{ #category : #'accessing - computed' }
RTAlignment >> leftMostElement [
	^ elements inject: elements first into: [ :maxS :s | 
			maxS encompassingRectangle left >= s encompassingRectangle left
					ifTrue: [ s ] ifFalse: [ maxS ] ] 
]

{ #category : #'accessing - computed' }
RTAlignment >> rightMostElement [
	^ elements inject: elements first into: [ :maxS :s | 
			maxS encompassingRectangle right <= s encompassingRectangle right
					ifTrue: [ s ] ifFalse: [ maxS ] ] 
]

{ #category : #'accessing - computed' }
RTAlignment >> topMostElement [
	^ elements inject: elements first into: [ :maxS :s | 
			maxS encompassingRectangle top >= s encompassingRectangle top
					ifTrue: [ s ] ifFalse: [ maxS ] ] 
]
