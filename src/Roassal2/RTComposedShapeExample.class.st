"
RTComposedShapeExample new installTitle: 'Flags' 
		code:
		'

v canvas'
	
"
Class {
	#name : #RTComposedShapeExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-ExampleBrowser'
}

{ #category : #sources }
RTComposedShapeExample >> exampleFlags [

| view shape els flags |
view := RTView new.
shape := RTMultiCompositeShape new.
shape add: (RTBox new color: #first; height: 20; width: 15).
shape add: (RTBox new color: #second; height: 20; width: 15) translateBy: 15 @ 0.
shape add: (RTBox new color: #third; height: 20; width: 15) translateBy: 30 @ 0.

flags := Dictionary new.
flags at: 'France' put: (Array with: Color blue with: Color white with: Color red).
flags at: 'Belgium' put: (Array with: Color black with: Color yellow with: Color red).
flags at: 'Romania' put: (Array with: Color blue with: Color yellow with: Color red).
flags at: 'Italia' put: (Array with: Color green with: Color white with: Color red).	

els := shape elementsOn: flags values.
els @ RTDraggable.
view addAll: els.

RTGridLayout new on: els.
view open.

view canvas
]

{ #category : #icons }
RTComposedShapeExample >> exampleFlagsIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAABKUlEQVR4XuXVQQrAIAwAwfz/
0yooBg96EhRmi5cWSukQEqX4/VT4v8AH8fNBfBA/H8QH8fNBfBA/H8QH8fNB/HwQH8TPB/FB
/HwQH8TPB/FB/HwQPx/EB/HzQXwQPx/EB/HzQXwQPx/EzwfxQfx8EB/EzwfxQfx8EB/Ezwfx
80F8ED8fxAfx80F8ED8fxAf58yMjT//kcdYH7U5ehxf4ID6ID+KD+CD+UveX+rsJiXmOE7Ib
BH9CfBAfxAfxQfyl7i91Px/EB/HzQfx8EB/EzwfxQfx8EB/EzwfxQfx8ED8fxAfx80F8ED8f
xAfx80F8ED8fxM8H8UH8fBAfxM8H8UH8fBAfxM8H8fNBfBA/H8QH8fNBfBA/H8QH8fNB/HwQ
H8TPB/FB/K5UAYIdyaudpALHAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTComposedShapeExample >> exampleHorizontalCompositeShape1 [
| view shape els |
view := RTView new.
shape := RTHorizontalCompositeShape new
				shape1: (RTBox new color: Color gray; size: 20);
				shape2: (RTLabel new text: '+').

els := shape elementsOn: (1 to: 20).
els @ RTDraggable.
view addAll: els.

RTGridLayout new on: els.
view open.
view canvas
]

{ #category : #icons }
RTComposedShapeExample >> exampleHorizontalCompositeShape1Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAABTklEQVR4XuXZsQ3EIAxA0YzO
JmyB6LIJA8AOzl2ZSCelNKf3JSp3eTIUOa7Lb6cO/xP4IH4+iA/i54P4IH4+iA/i54P4IH4+
iJ8P4oP4+SA+iJ8P4oP4+SA+iJ8P4ueD+CB+PogP4ueD+CB+PogP4ueD+PkgPoifD+KD+Pkg
PoifD+KD+Pkgfj6ID/LaeZ6PkznzQb6VUh4nc+aD/PhAc85Ya0XGzAfxN8R/Q/w35KUxRtxP
5swH8a+s/UFaa9F7j4yZD+JvyH4gtda4n8yZD+LnX1n+leWD+CA+iA/iP+r+o+5viA/ig2wA
4v8P8TfE3xA/H8QH8fNBfBA/H8QH8fNBfBA/H8TPB/FB/HwQH8TPB/FB/HwQH8TPB/HzQXwQ
Px/EB/HzQXwQPx/EB/HzQfx8EB/EzwfxQfx8EB/EzwfxQfx8ED8fxAfx80H+sg++wcJAXG1T
JgAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTComposedShapeExample >> exampleInnerShapes [

| v |
v := RTView new.
v @ RTDraggableView.

shape := RTMultiCompositeShape new.
shape add: RTLabel new.
shape add: (RTBox new size: 20; color: (Color blue alpha: 0.3)).

es := shape elementsOn: RTShape withAllSubclasses.
v addAll: es.

es do: [ :e | 
	methodElements := RTBox new elementsOn: e model methods.
	RTGridLayout on: methodElements.
	
	RTNest new
		on: e 
		inShape: #second 
		nest: methodElements.
		
	v addAll: methodElements.
	e trachelShape vertical.
].

RTFlowLayout on: es.
es @ RTDraggable.
v open.
v canvas
]

{ #category : #icons }
RTComposedShapeExample >> exampleInnerShapesIcon [
	^ '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'
]
