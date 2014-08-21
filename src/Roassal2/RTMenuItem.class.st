Class {
	#name : #RTMenuItem,
	#superclass : #Object,
	#instVars : [
		'name',
		'callback',
		'selected',
		'after',
		'rawmenu',
		'color',
		'background'
	],
	#category : 'Roassal2-Builder-Menu'
}

{ #category : #accesing }
RTMenuItem >> after [
	^ after
]

{ #category : #accesing }
RTMenuItem >> after: ablock [
	after := ablock
]

{ #category : #accesing }
RTMenuItem >> background [
	^ background 
]

{ #category : #accesing }
RTMenuItem >> background: aShape [

	background := aShape
]

{ #category : #accesing }
RTMenuItem >> callback [
	^ callback
	
]

{ #category : #accesing }
RTMenuItem >> callback: ablock. [
	callback := ablock
	
]

{ #category : #accesing }
RTMenuItem >> color [
	^ color
]

{ #category : #accesing }
RTMenuItem >> color: aColor [
	color := aColor
]

{ #category : #public }
RTMenuItem >> execute: m [
	self callback value.
	self after ifNotNil: [self after value: m.]
]

{ #category : #'initialize-release' }
RTMenuItem >> initialize [
	super initialize.
	selected := false.
	name := ''.
	callback := [  ].
	after := nil.
]

{ #category : #accesing }
RTMenuItem >> label [
	^ (self selected ifTrue:['* '] ifFalse:['']), self name.
]

{ #category : #accesing }
RTMenuItem >> menu: menu [
	rawmenu := menu.
]

{ #category : #accesing }
RTMenuItem >> name [
	^ name
]

{ #category : #accesing }
RTMenuItem >> name: aString [
	name := aString.
]

{ #category : #accesing }
RTMenuItem >> rawmenu [
	^ rawmenu
]

{ #category : #accesing }
RTMenuItem >> selected [
	^ selected
]

{ #category : #accesing }
RTMenuItem >> selected: abool [
	selected := abool
]
