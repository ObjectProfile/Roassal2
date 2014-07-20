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

	| v shape es methodElements |
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

{ #category : #sources }
RTComposedShapeExample >> exampleNamedPopup [

| v es |
v := RTView new.

es := RTLabel elementsOn: (1 to: 10).

v addAll: es.

es @ (RTPopup new 
	named: #yourself
	background: Color blue
	group: [ :group :el |  
 
		group addAll: (RTEllipse elementsOn: (1 to: el model)).
		RTWeightedCircleLayout new
			initialRadius: 50;
			on: group.
		]).

RTHorizontalLineLayout on: es.
v open.
v canvas
]

{ #category : #icons }
RTComposedShapeExample >> exampleNamedPopupIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAB3ElEQVR4XuXVz8pBQRjAYfds
IyllaeMCLFwF+ZNEFrJRRJYWNhaUnQWvz1mYDDfw1fMrdV6Z05zzNCk9n37/qZL/CnwQPx/E
B/HzQXwQPx/EB/HzQXwQPx/EzwfxQfx8EB/EzwfxQfx8EB/Ezwfx80F8ED8fxAfx80F8ED8f
xAfx80H8fBAfxM8H8UH8fBAfxM8H8UH8fBA/H8QH8fNBfBA/H8QH8fNBfBA/H8TPB/FBfrvd
btHv9+M9b7fbWC6XaT4cDjGbzeJzzXg8zn5/Op3SfDweo/juPV+v1xiNRmler9cxGAzSPJ1O
Y7FYxPd+ijWf96FOSLPZzB682+1mc6PRSHOn04larZbmzWYT1Wo1zfV6/Vkul7P17XY7A2i1
WmkusCuVSnzv53Wf4uOdkNVqlT34ZDJ5fs77/T56vV72wi6XS5p3u10Mh8M0Px6P7MS9T8n7
+nw+Z/cr1s/n8/jez2sfcb/fw/8P8fNBfBA/H8QH8fNBfBA/H8QH8fNB/HwQH8TPB/FB/HwQ
H8TPB/FB/HwQH8R/BT6Inw/ig/j5ID6Inw/ig/j5ID6Inw/i54P4IH4+iA/i54P4IH4+iA/i
54P4+SA+iJ8P4oP4+SA+iJ8P4oP4+SB+v/0B+zt+o1wgBuoAAAAASUVORK5CYII='
]

{ #category : #sources }
RTComposedShapeExample >> exampleNesting1 [

| v  es |

v := RTView new.
es := RTBox elementsOn: RTShape withAllSubclasses.

v addAll: es.

RTNest new
	for: es
	add: [ :group :model | 
		group addAll: ((RTBox new color: Color blue) elementsOn: model methods).
		RTGridLayout on: group.
	].

RTFlowLayout new on: es.
es @ RTPopup @ RTDraggable.
v open.
v canvas
]

{ #category : #icons }
RTComposedShapeExample >> exampleNesting1Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAACGUlEQVR4XuXa3Y3CMBBFYVql
SAqhgmgftoCtICveyY8nHsf2dyWElNgx4uSSmWse6+qrJz38r8AH4ssH4gPx5QPxgfjygfhA
fPlAfCC+fCC+fCA+EF8+EB+ILx+ID8SXD8QH4ssH4ssH4gPx5QPxgfjygfhAfPlAfCC+5gOy
LMvhq2RsZE7k+lfW6R7I8/m3vl6/m+8lYyNzIte/sk73QD4f9v3+2XwvGRuZE7n+lXV8h/gO
8R3iO8R3iO+QKR1Sy0175ejRnJK7vMY6UwHZuvv2vqijOSV3eY11/E7d79R9TR2dZEUo0XN7
Y0qPDVn2ZpW/0XN7Y0qPDVn2ZpW/0XN7Y0qP+Q5JcMh0z5DRHTIdkJoOqb0H8W2t7L5iKodk
AGnd6HXnkNY7bn4fcvIO9IH4nboPxNcA0UnruCMjGmn5c5v+UG8dd2REIy2byPSHeuu4IyMa
adlE3uKQMzt0Jc1cxh74XU3kLQ45s0NX0sxl7IHf1UROUWXd+S8RH0gwsvGBdOKQ0ZKB6R3i
A/HlA/GBnIhOMqKKyD9UeCCZUUVkR5IHkhlVRHYk/WdIxdI1EpH4DkksXSMRie+QziIS3yGd
RSS+QzqLSPyyt7OIxAfiywfiA/HlA/GB+PKB+PKB+EB8+UB8IL58ID4QXz4QH4gvH4gvH4gP
xJcPxAfiywfiA/HlA/GB+PKB+PKB+EB8+UB8IL58IBPqH65mwUlrOttkAAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTComposedShapeExample >> exampleNesting2 [

| v shape es |
v := RTView new.
shape := RTMultiCompositeShape new.
shape add: RTLabel new.
shape add: RTBox new.
es := shape elementsOn: RTShape withAllSubclasses.

v addAll: es.

RTNest new
	for: es
	inShape: #second
	add: [ :group :model | 
		group addAll: ((RTBox new color: Color blue) elementsOn: model methods).
		RTGridLayout on: group.
	].

RTFlowLayout new on: es.
es @ RTPopup @ RTDraggable.
v open.
v canvas
]

{ #category : #icons }
RTComposedShapeExample >> exampleNesting2Icon [
	^ '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'
]

{ #category : #accessing }
RTComposedShapeExample >> label [
	^ 'Composite shapes'
]
