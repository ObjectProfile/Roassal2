"
RTMultiLinearColorForIdentity associates to each objects a distinct color. 

Consider the following example:
[[[
classes := Collection withAllSubclasses.
packages := (classes collect: #package) asSet asArray.
v := RTView new.
v @ RTDraggableView.
normalizer := RTMultiLinearColorForIdentity new 
					objects: packages;
					command: #package.
s := RTBox new size: 15; color: normalizer.
v addAll: (s elementsOn: classes).

e := RTEdgeBuilder new
		view: v;
		moveBehind;
		objects: classes.
e connectFrom: #superclass.
RTClusterLayout on: v elements.
v
]]]

Using the Mondrian api, the normalizer es:
"
Class {
	#name : #RTMultiLinearColorForIdentity,
	#superclass : #RTMultiLinearColor,
	#instVars : [
		'objects'
	],
	#category : #'Roassal2-ColorNormalizer'
}

{ #category : #public }
RTMultiLinearColorForIdentity >> elements: roassalElements [
	^ self objects: (roassalElements collect: #model)
]

{ #category : #initialization }
RTMultiLinearColorForIdentity >> initialize [
	super initialize.
	self colors: (ColorPalette qualitative colors: 12 scheme: 'Set3').
	objects := #()
]

{ #category : #public }
RTMultiLinearColorForIdentity >> numberOfColors: aValue [
	^ self objects: (1 to: aValue)
]

{ #category : #public }
RTMultiLinearColorForIdentity >> objects: someObjects [
	objects := someObjects
]

{ #category : #accessing }
RTMultiLinearColorForIdentity >> rtValue: anObject [
	^ self level: (objects indexOf: (command rtValue: anObject)) - 1 / objects size
]
