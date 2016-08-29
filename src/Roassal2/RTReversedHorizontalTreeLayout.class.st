"
This class represent a reversed horizontal tree Layout.

Here is an example:

-=-=-=
v := RTView new.
es := RTBox new size: 10; elementsOn: (1 to: 100).
v addAll: es.

eb := RTEdgeBuilder new.
eb view: v.
eb objects: (1 to: 100).
eb connectFrom: [ :value | value // 2 ].

RTReversedHorizontalTreeLayout  on: es.
v
-=-=-=

Using Mondrian and the layout builder:
-=-=-=
b := RTMondrian new.
b shape box size: 20; color: Color red trans.
b nodes: (1 to: 128).
b edges connectFrom: [ :v | v // 2 ].
b layout horizontalReversedTree.
b 
-=-=-=
"
Class {
	#name : #RTReversedHorizontalTreeLayout,
	#superclass : #RTHorizontalTreeLayout,
	#category : #'Roassal2-Layouts'
}

{ #category : #hook }
RTReversedHorizontalTreeLayout >> doPost: elements [
	| g largeur |
	g := elements asGroup.
	edges do: [ :edge | edge shape attachPoint: (RTShorterHorizontalDistanceAttachPoint new ) ].
	largeur := g extent x.
	elements do: [ :el | el translateTo: (largeur - el position x) @ el position y ].

]
