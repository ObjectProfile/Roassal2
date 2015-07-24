"
RTConstraintExample new installTitle: 'AboveTopOnLabel' 
		code:
		'
| v b e |
v := RTView new.

e := RTLabel elementOn: ''Happiness''.
b := (RTBox new size: 80; color: (Color blue alpha: 0.3)) element.
v add: e; add: b.

b @ RTDraggable.
e @ RTDraggable.

(RTConstraint child: e parent: b)
	above;
	top;
	stick.
^ v'
	
"
Class {
	#name : #RTConstraintExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-ExampleBrowser'
}

{ #category : #sources }
RTConstraintExample >> exampleAboveTopOnLabel [

| v b e |
v := RTView new.

e := RTLabel elementOn: 'Happiness'.
b := (RTBox new size: 80; color: (Color blue alpha: 0.3)) element.
v add: e; add: b.

b @ RTDraggable.
e @ RTDraggable.

(RTConstraint on: e background: b)
	above;
	top;
	stick.
^ v
]

{ #category : #icons }
RTConstraintExample >> exampleAboveTopOnLabelIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAABnElEQVR4XuXRMYrCUBSGUXfu
MhQJpBC1EQs3YCEiIgTrmB1YWIki8isTmGqmM8Iw54MLl/e6e3rPp99fquefwAfx80F8ED8f
xAfx80F8ED8fxAfx80H8fBAfxM8H8UH8fBAfxM8H8UH8fBA/H8QH8fNBfBA/H8QH8fNBfBA/
H8TPB/FB/HwQH8TPB/FB/HwQH8TPB/HzQXwQv/8KUhRFDodDVqtVbrdbJpNJmqbJeDzOdrvN
er3O8XjMbDbL+XzOfr/PYrGID/KhBoNBqqpKWZbp9/vt2xfGbrdrDz+dTjMajTKfz1uguq4z
HA59kE93uVzaI9/v9xbher3mt//H45Hv3QfpuM0meWd8kI5bLpN3xgfxQXwQH8QH8UF8EB/E
B/FBfBAfxAfxQXwQH8QH8UF8EB/EB/FBfJAfnU7JO+OD+PkgPoifD+KD+PkgPoifD+Lng/gg
fj6ID+Lng/ggfj6ID+Lng/j5ID6Inw/ig/j5ID6Inw/ig/j5IH4+iA/i54P4IH4+iA/i54P4
IH4+iJ8P4oP4+SA+iF8nvQDq9/iZKK4j/gAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTConstraintExample >> exampleBelowAndStick [

| v b e |
v := RTView new.

e := (RTEllipse new size: 20; color: (Color red alpha: 0.3)) element.
b := (RTBox new size: 80; color: (Color blue alpha: 0.3)) element.
v add: e; add: b.

b @ RTDraggable.
e @ RTDraggable.

(RTConstraint on: e background: b)
	below;
	stick.
^ v
]

{ #category : #icons }
RTConstraintExample >> exampleBelowAndStickIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABeCAYAAADVA7GfAAABR0lEQVR4XuXTIQ6DQBBAUe5/
nE0xXKAat2kQeFKDQg0NNQ0C1QR2eT8ZN2bnZZt19Supxj+BD+Lng/ggfj6ID+Lng/ggfj6I
D+Lng/j5ID6Inw/ig/j5ID6Inw/ig/j5IH4+iA/i54P4IH4+iA/i54P4IH4+iJ8P4oP4+SA+
iJ8P4oP4+SA+SMmlFPHP5Bzhg/ggPogP4oP4ID6ID+KD+CA+iA/ig/ggPogP4oP4ID6ID+KD
+CA+iA9ScttBD+fxipxy5Of7cGeafJBTir7ff4VliZrfUz9I2+5BhsEHuRRkHH8YXRdbPsjV
KPMcX5jKMW4Dcqd8EB/EzwfxQfx8EB/EzwfxQfx8EB/Ezwfx80F8ED8fxAfx80F8ED8fxAfx
80H8fBAfxM8H8UH8fBAfxM8H8UH8fBA/H8QH8fNBfBA/H8QH8TupD9ZNp2Sij7j1AAAAAElF
TkSuQmCC'
]

{ #category : #sources }
RTConstraintExample >> exampleBelowAndStickWithLabel [

| v b e |
v := RTView new.

e := RTLabel elementOn: 'Happiness'.
b := (RTBox new size: 80; color: (Color blue alpha: 0.3)) element.
v add: e; add: b.

b @ RTDraggable.
e @ RTDraggable.

(RTConstraint on: e background: b)
	below;
	stick.
^ v
]

{ #category : #icons }
RTConstraintExample >> exampleBelowAndStickWithLabelIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAABh0lEQVR4XuXUPYqDABCA0ZzQ
S6Wzt7LRRmySQhGCTZpUYoJYWNl7i3EX622W/WHZ98FcYN4wp333+0ud/BX4IH4+iA/i54P4
IH4+iA/i54P4IH4+iJ8P4oP4+SA+iJ8P4oP4+SA+iJ8P4ueD+CB+PogP4ueD+CB+PogP4ueD
+PkgPoifD+KD+PkgPoifD+KD+Pkgfj6ID/ItNU3EV8YH8UF8EB/EB/FBfBAfxAfxQXwQH8QH
8UF8EB/EB/FBfBAfxAfxQXwQH8TPB/l0XdfFuq4fXvvr9Qof5JdLkiTquo7H4xHn8/kAKMsy
hmGI6/UaVVVFlmXvL6qJy+USfd9H27bhg/xQz+cztm07UO73+56m6YGQ53ksyxLzPMc4jlEU
RUzTFLfb7YDyQfx8EB/EzwfxQfx8EB/Ezwfx80F8ED8fxAfx80F8ED8fxAfx80H8fBAfxM8H
8UH8fBAfxM8H8UH8fBA/H8QH8fNBfBA/H8QH8fNBfBA/H8TPB/FB/HwQH8TPB/mvvQEMgfXI
HXCtJwAAAABJRU5ErkJggg=='
]

{ #category : #accessing }
RTConstraintExample >> label [
	^ 'Constraint'
]
