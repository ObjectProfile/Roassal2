"
This class represent a reversed vertical tree Layout.

Here is an example:

-=-=-=
v := RTView new.
es := RTBox new size: 10; elementsOn: (1 to: 100).
v addAll: es.

eb := RTEdgeBuilder new.
eb view: v.
eb objects: (1 to: 100).
eb connectFrom: [ :value | value // 2 ].

RTReversedTreeLayout  on: es.
v
-=-=-=

Using Mondrian and the layout builder:
-=-=-=
b := RTMondrian new.
b shape box size: 20; color: Color red trans.
b nodes: (1 to: 128).
b edges connectFrom: [ :v | v // 2 ].
b layout treeReversed.
b 
-=-=-=
"
Class {
	#name : #RTReversedTreeLayout,
	#superclass : #RTTreeLayout,
	#category : #'Roassal2-Layouts'
}

{ #category : #'as yet unclassified' }
RTReversedTreeLayout >> doPost: elements [
	| g hauteur |
	g := elements asGroup.
	edges do: [ :edge | edge shape attachPoint: (RTShorterVerticalDistanceAttachPoint new ) ].
	hauteur := g extent y.
	elements do: [ :el | el translateTo: el position x @ (hauteur - el position y) ].

]
