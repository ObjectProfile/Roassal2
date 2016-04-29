Class {
	#name : #RTColorLegendItem,
	#superclass : #RTLegendItem,
	#instVars : [
		'color',
		'text',
		'model'
	],
	#category : #'Roassal2-Builder-Legend'
}

{ #category : #accessing }
RTColorLegendItem >> color [
	^ color
]

{ #category : #accessing }
RTColorLegendItem >> color: anObject [
	color := anObject
]

{ #category : #hooks }
RTColorLegendItem >> execute [
	"Associate a color with a text"
	| g |
	g := RTGroup new.
	g add: (RTBox new size: self textSize; color: color) element.
	g add: ((RTLabel text: text) height: self textSize; elementOn: model).
	RTHorizontalLineLayout new alignCenter; on: g.
	^ g
]

{ #category : #accessing }
RTColorLegendItem >> model [
	^ model
]

{ #category : #accessing }
RTColorLegendItem >> model: anObject [
	model := anObject
]

{ #category : #accessing }
RTColorLegendItem >> text [
	^ text
]

{ #category : #accessing }
RTColorLegendItem >> text: aStringOrABlockOrASymbol [
	text := aStringOrABlockOrASymbol
]
