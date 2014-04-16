Class {
	#name : #RTRoassalExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-ExampleBrowser'
}

{ #category : #'as yet unclassified' }
RTRoassalExample >> exampleAnimatedCircle [
	| nbOfCircles  v shape mousePos |
	nbOfCircles := 25.
	
	mousePos := 50 @ 50.
	v := RTView new.
	shape := RTEllipse new sizeElement: [ :el | ((el position - mousePos) r abs / 3) min: 50 ]; color: (Color blue alpha: 0.4).
	v addAll: (shape elementsOn: (1 to: nbOfCircles)).
	RTGridLayout on: v elements.
	
	v on: TRMouseMove do: [ :evt |  Transcript show: evt positionFromCamera printString; cr . mousePos := evt positionFromCamera. v elements do: #updateShape. v canvas signalUpdate ].
	
	v open.
	v canvas
]

{ #category : #'as yet unclassified' }
RTRoassalExample >> exampleAnimatedCircleIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAAD8UlEQVR4XuWZCUuVQRSGp5Jc
U3HJNENBczfXLCuXXHFX3BUVS/3/PyHepsM3M3cSkYLieWDg+vrduTBnzvo5Pnz48OHDhw8f
Pnz48OHDhw8fPnz48OHDhw8fPnz48OHDhw8fPnz48OHDhw8fPnz48OHDhw8fPnz48OHDhw8f
Pnz48OFzD2/eOHdx4dzdnXOTk4U+MeG1y0vnOjq89uSJcwsLXt/YcK6hweutrc4dHnr98+di
j6Eh575/92tkpNA/ffLPHh3574r6eufW172+uOjcs2dQg+gAwvX6tT+kVBdzc7G2u+v1q6tY
lyEqK0v3qKlxrq8v1r5983tsb8e6jMI3yJ33DPOOcMk7jo/zhkq16Wnveane1eXc+/cP20Ne
i+TkJD6IxkYfPkLt/Nw/qwMN9bU1r29txbqFodvbQtNnGTX1Pn1XLC/Hen8/1CBVVYVX6FYb
Cl2mv3hR6OPjPtdIN3TQ+lv6wECht7QUe7x6Vei9vcUeT5/GeUtLv4Gmudm57u5SXR7x8mWs
6QB1eysqYl1GU35IaW+PDW3o2draWCsv93tjE7pQVWRhYmen0MMkOztb3Pibm9LQ9PZtHN7k
dUIhzXRVUHboYZg0I4ahTL8RehQ6qQ8OllZClnhXVvIVUvrs1JRzdXWluvJTrmDIVWqbm3yD
/Fyjo84ND+errDR5K1Hn9vj40fcoqS4v+F2VFXqe1v4+1CDWjFkTaElWocd0NYFpWNHq7PS6
DBAaSZ4gFALTnkUVXFh9WThMy2QLh0jkEQolYTKVYaS9exc/a2EnTdQ9PV5X8xeiiimtmqyy
U7UVYpVdUxO8ylIYUXJXtRUevEYcygcKV4YS+Py8D20hOkh18qqqDHXr8h6t6ur44OUZYeks
ZHztLeNiUZgKQ4UOTiVtqF1fF6VqqGuulYYmG7/kcksu7O3t5ccyKi74Sf2e0YnC2enpw8Ye
8jYNJFNd3iWPe8geqrr4Bvk1b8odppiZibWzs9IRiZZyhvqNdA/ljrGx/N7pnEyhC0lbW37C
+vVraQgSKkftBlsCV8NoRgn7B4Ud2yMcv6tqs4rMGkDlG3sNoFE+Hz7/BkqydrtVbRkWWvS/
sCew261bXFZW9BZ2u5eW+Gf6R3OI+guFkVyctzd9tiy06I1gqIfhic9fqrLUKD60yvryhX+u
jyadISn8aJSem1np5of66qrXDw7yIxU+j+D5c19RadakiivMLWr41PyF7z7UTStUffgQ7yOv
kJ57r8KHDx8+fPjw4cOHDx8+fPjw4cOHDx8+fPjw4cOHDx8+fPjw4cOHDx8+fPjw4cOHDx8+
fPjw4cOHDx8+fPjw4cOHD5//mx9m6Vpqr6HZGwAAAABJRU5ErkJggg=='
]

{ #category : #'as yet unclassified' }
RTRoassalExample >> exampleBezier [
| v shape  edge els |
v := RTView new.
shape := RTEllipse new size: 10; color: (Color purple alpha: 0.3).
els := (shape elementsOn: (1 to: 6)) @ RTDraggable.
v addAll: els .
RTHorizontalLineLayout on: v elements.

v elements first translateBy: -50 @ 50.
v elements third translateBy: -10 @ 20.
v elements fifth translateBy: 0 @ -60.
v elements last translateBy: 150 @ 100.

edge := (RTBezierLine new controllingElements: v elements) edgeFrom: els first to: els last.
v add: edge.

v open.
v canvas
]

{ #category : #'as yet unclassified' }
RTRoassalExample >> exampleBezierIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABjCAYAAABt56XsAAACcUlEQVR4XuXb3W/SUBjH8YPI
qFHREayhikDBUkbLW+2kkAUUEl9ivDMh3K2JmYk323/hpX+yPUYTQzagCOzA93NJS6C/59Cn
57QIPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
OF2Uey+E+4mfhCKOheE8Fyfv+Unw8fHx8cXhOE7Xdd1XYRhedjqdwDTNWjqd1vjJ3GJB5l/z
ff+sVqu5/HR2LJvN5hZtb7fbr6NfTY+f1I5MJpPPy/aRpy/btpv8tHZA9oxV9221Wn6lUrH5
qW1J1COcuO/pdrtB1HM8fnprSIrUjVdKiUTizqnXG6/Zd55EV2X8osTxVJj9RWtT388vf/zv
2tVgMBjzk17RfXFcyIpn1zZiz/P6i7bHEQTBG37aS2QymceWZf3uD8VisTrfmDf9ec1m00+l
Ukf85Ofoum7IYvx7iZrP5wvheXhVrVbr2xzNsvCyt/Cr8IcsghypcXvJJpVKpZeRE3Qh5Ey6
Xq/f2As08SC3iV6xKsMwCsiZvaZp96JT0FtVe5gcKJhiRJOzftQv8krPgZLJu+tMPPdrohcd
5HA4/LBP37lcLlsHOeOWSxb7OuIOamHSELXxty9XP/f9OEaj0cfDaN47vkrapul0+pU/QVGM
vE3MT0Exs9nsgp8Cv6fwLdNoNDr8FBTDvyWsoOhWQeO6R5H4bhH/cSNFi+K5p+OHImfy01DE
mf0u5P9PRSFyZeKR0C1+Enx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8
fHx8fHx8fHx8fHx//QL7WkIkODawDAAAAABJRU5ErkJggg=='
]

{ #category : #'as yet unclassified' }
RTRoassalExample >> label [
	^ 'Plain Roassal'
]
