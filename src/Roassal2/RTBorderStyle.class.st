"
Define the style of a border.
It is used now in RTBox.
Here is an example:

-=-=-=
v := RTView new.

box := RTBox new.
box width: 50; height: 30.
box borderStyle dot.
box borderWidth: 3.
box borderColor: Color blue.

v add: box element.
v
-=-=-=

"
Class {
	#name : #RTBorderStyle,
	#superclass : #RTObject,
	#instVars : [
		'style'
	],
	#category : #'Roassal2-Shapes'
}

{ #category : #styles }
RTBorderStyle >> dash [
	self style: #(6 4)
]

{ #category : #styles }
RTBorderStyle >> dashDot [
	self style: #(6 3 1 3)
]

{ #category : #styles }
RTBorderStyle >> dot [
	self style: #(1 2)
]

{ #category : #styles }
RTBorderStyle >> solid [
	self style: nil
]

{ #category : #accessing }
RTBorderStyle >> style [
	^ style
]

{ #category : #accessing }
RTBorderStyle >> style: aStyle [
	aStyle isSymbol
		ifTrue: [ self perform: aStyle ]
		ifFalse: [ style := aStyle ]
]
