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

| view shape els |
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
