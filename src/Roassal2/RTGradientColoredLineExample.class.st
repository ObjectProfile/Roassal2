Class {
	#name : #RTGradientColoredLineExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-ExampleBrowser'
}

{ #category : #sources }
RTGradientColoredLineExample >> exampleA [

	| v elem1 elem2 edge |
	v := RTView new.

	elem1 := (RTEllipse new color: (Color blue alpha:0.3); size:20) elementOn: 1.
	elem2 := (RTEllipse new color: (Color red alpha:0.9); size:20) elementOn: 2.
	elem2 translateBy: 300@0.
	v add: elem1.
	v add: elem2.
	
	edge := RTEdge from:elem1 to:elem2.
	v add: (edge + (RTGradientColoredLine new colors: (Array with: (elem1 color) with: (elem2 color)); precision: 100; gradientColorShape)).

^ v canvas
]

{ #category : #icons }
RTGradientColoredLineExample >> exampleAIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAACBklEQVR4XuXVS1IaUQCFYffg
yC2YgWtxDZZLcwOOdO4IiUZCRIPG94sGRMUHqMc0RUxWkCqK7686C7j91e078/HhN0nN+J/A
B/HzQXwQPx/EB/HzQXwQPx/EB/HzQfx8EB/EzwfxQfx8EB/EzwfxQfx8ED8fxAfx80F8ED8f
xAfx80F8ED8fxM8H8UH8fBAfxM8H8UH8fBAfxM8H8fNBfBA/H8QH8fNBfBA/H8QH8fNB/P4L
SMoqlWR9PSmKZNo/3Oi8WVpKFhaSjY1MHMgIY3X136YeZHk5mZv7u4kDWVsbQ6ysjPaedvFn
rfcUN29plyuuX8e7Go53ORjvYpDW+Uu557TOntI6He0xxUm5435axw8pju7H+3VXrpf24W3a
B93xmp10mu10fhbp7rfK3aS7d51u4yq3jcvc7l6kt3ue3o+z3NVPy53k/vtxuaM81A7Trx2k
v9PM47f9cnt52m7keWu3XD0vX+sZVGsZVncy3NzO6+ZW3irVvM1/yfvs7OSCjH5Tn7ejvMHT
f0NGh/y8IYuL8R91/1H380F8ED8fxM8H8UH8fBAfxM8H8UH8fBAfxM8H8fNBfBA/H8QH8fNB
fBA/H8QH8fNB/HwQH8TPB/FB/HwQH8TPB/FB/HwQPx/EB/HzQXwQPx/EB/HzQXwQPx/Ezwfx
Qfx8EB/EzwfxQfx8EKHfwFZ+KsQkEEMAAAAASUVORK5CYII='
]

{ #category : #sources }
RTGradientColoredLineExample >> exampleB [

	| v elem1 elem2 edge |
	v := RTView new.

	elem1 := (RTEllipse new color: (Color red alpha:0.3); size:20) elementOn: 1.
	elem2 := (RTEllipse new color: (Color red alpha:0.9); size:20) elementOn: 2.
	elem2 translateBy: 300@0.
	v add: elem1.
	v add: elem2.
	
	edge := RTEdge from:elem1 to:elem2.
	v add: (edge + (RTGradientColoredLine new colors: (Array with: (elem1 color) with: (elem2 color)); precision: 100; gradientColorShape)).

^ v canvas
]

{ #category : #icons }
RTGradientColoredLineExample >> exampleBIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAABxUlEQVR4XuXVy01CURiFUXpw
ZAtOqMUajKXRgCOdM/KFiPLwCT5QsIeN4h+pQJMb15fsAu5Z9+S0Viu/JtXyj8AH8fNBfBA/
H8QH8fNBfBA/H8QH8fNB/HwQH8TPB/FB/HwQH8TPB/FB/HwQPx/EB/HzQXwQPx/EB/HzQXwQ
Px/EzwfxQfx8EB/EzwfxQfx8EB/Ezwfx80F8ED8fxAfx80F8ED8fxAfx80H8/gQk646Pk6Oj
5OMj//3gvr93by9pt5NuN80DWWMcHGz270H295Pt7c2aB3J4WBidTu3rlnxvuUwWi9r7e+3t
rTaf115fk5eX2vNz8vRUm82S6bT2+Fh7eKjd3yd3d7Xb29rNTTKZ1MbjZDSqDYe16+vk6qo2
GNQuL2v9fnJxUev1kvPz2tlZcnpaOzmprX++nZ1ka6vBIOvD/7khv3iFG3tDvr5xc0N2d+M/
6v6j7ueD+CB+PoifD+KD+PkgPoifD+KD+PkgPoifD+Lng/ggfj6ID+Lng/ggfj6ID+Lng/j5
ID6Inw/ig/j5ID6Inw/ig/j5IH4+iA/i54P4IH4+iA/i54P4IH4+iJ8P4oP4+SA+iJ8P4oP4
+SBCnzOafijeu2A3AAAAAElFTkSuQmCC'
]

{ #category : #'as yet unclassified' }
RTGradientColoredLineExample >> label [
	^ 'Gradient colored lines'
]
